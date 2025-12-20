// Created by phatt-23 on 19/12/2025

import { Unsolvable } from "$lib/core/Unsolvable";
import type { LocalStorage } from "$lib/core/useLocalStorage.svelte";
import type { Decoder } from "$lib/decode/Decoder";
import type { ProblemInstance } from "$lib/instance/ProblemInstance";
import type { Reducer } from "$lib/reduction/Reducer";
import type { ReductionStep } from "$lib/reduction/ReductionStep";
import type { Certificate } from "$lib/solve/Certificate";
import type { ReductionStore } from "$lib/state/ReductionStore.svelte";
import { onDestroy } from "svelte";
import { writable, type Writable } from "svelte/store";

type PI = ProblemInstance;
type CR = Certificate;

type Params<
    I extends PI,
    O extends PI,
    IC extends CR,
    OC extends CR,
> = {
    storage: LocalStorage<I, O, IC, OC>;
    workerUrl?: URL;
    reducerFactory: (inInstance: I) => Reducer<I, O>;
    decoderFactory: () => Decoder<O, OC, IC>;
    onSolveFinished?: (outInstance: O, outCert: OC | Unsolvable) => void;
    createWorkerMessage?: (outInst: O) => object;
}

type Controller<
    I extends PI,
    O extends PI,
    IC extends CR,
    OC extends CR,
> = {
    redStore: Writable<ReductionStore<I, O, IC, OC>>,
    showStepper: Writable<boolean>,
    isSolving: Writable<boolean>,
    solveMessage: Writable<string>,
    editorChanged: (inInstace: I) => void,
    reduce: () => void,
    solve: () => Promise<void>,
}

export function useReductionController<
    I extends PI,
    O extends PI,
    IC extends CR,
    OC extends CR
>(params: Params<I, O, IC, OC>): Controller<I, O, IC, OC> {
    let redStore = params.storage.value;
    let showStepper = writable<boolean>(false);
    let isSolving = writable<boolean>(false);
    let solveMessage = writable<string>('');
    let currentWorker: Worker | null = null;

    let inInstance: I | null = null;
    let outInstance: O | null = null;
    let hasOutCert: boolean = false;

    redStore.subscribe(rs => {
        hasOutCert = rs.hasOutCertificate();
        inInstance = rs.inInstance;
        outInstance = rs.outInstance;
    });

    function editorChanged(i: I) {
        console.debug("editorChanged");
        // terminate the solver if running
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
            isSolving.set(false);
            solveMessage.set('Solving cancelled.');
        }

        redStore.update(rs => {
            rs.reset();
            rs.setInInstance(i);
            return rs;
        });

        params.storage.save();
    }

    function reduce() {
        if (!inInstance || inInstance.isEmpty()) {
            return;
        }

        const reducer = params.reducerFactory(inInstance);
        const { outInstance, steps } = reducer.reduce();

        redStore.update(rs => {
            rs.setSteps(steps);
            rs.setOutInstance(outInstance);
            return rs;
        });

        params.storage.save();
    }

    async function solve(): Promise<void> {
        if (!params.workerUrl) 
            throw 'Worker URL not provided';
        if (!outInstance) 
            throw 'Output instance is not set';
        if (hasOutCert)
            throw 'Reduction storage already has certificate of the output problem';

        isSolving.set(true);
        solveMessage.set('Solving...');

        if (currentWorker) {
            currentWorker.terminate();
        }

        const worker = new Worker(params.workerUrl, { type: "module" });
        currentWorker = worker;

        const message = params.createWorkerMessage?.(outInstance) ?? outInstance.toSerializedString();
        worker.postMessage(message);

        try {
            const result = await new Promise<any>((resolve, reject) => {
                worker.onmessage = (e) => resolve(e.data);
                worker.onerror = (err) => reject(err);
            });

            redStore.update(rs => {
                rs.outCert = result;
                if (result != Unsolvable) {
                    const decoder = params.decoderFactory();
                    rs.inCert = decoder.decode(rs.outInstance!, result);
                }

                return rs;
            });

            params.onSolveFinished?.(outInstance, result);

            params.storage.save();
        } catch (exception) {
            console.debug(`Error occured while solving: ${exception}`);
            solveMessage.set(`Error occured while solving: ${exception}`);
        } finally {
            solveMessage.set('');
            isSolving.set(false);

            worker.terminate();
            currentWorker = null;
        }
    }

    onDestroy(() => {
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
        }
    });

    // reset the step index back to 0, if anything changes
    $effect(() => {
        redStore.update(rs => {
            rs.resetStepIndex();
            return rs;
        });
    })

    return {
        redStore,
        showStepper,
        isSolving,
        solveMessage,
        editorChanged,
        reduce,
        solve,
    };
}
