<!-- Created by phatt-23 on 22/10/2025 -->

<script lang="ts">
    import CertRenderer3SAT from "$lib/component/CertRenderer3SAT.svelte";
    import CertRendererHCYCLE from "$lib/component/CertRendererHCYCLE.svelte";
    import CertRendererSSP from "$lib/component/CertRendererSSP.svelte";
    import Editor3CNF from "$lib/component/Editor3CNF.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import Renderer3CNF from "$lib/component/Renderer3CNF.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import RendererSSP from "$lib/component/RendererSSP.svelte";
    import Spinner from "$lib/component/Spinner.svelte";
    import { EDGE_ID_PREFIX, PREFIX_AND_ID_DELIM } from "$lib/core/Id";
    import localStorageKeys from "$lib/core/localStorageKeys";
    import { Unsolvable } from "$lib/core/Unsolvable";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import { DecoderHCYCLEto3SAT } from "$lib/decode/DecoderHCYCLEto3SAT";
    import { DecoderSSPto3SAT } from "$lib/decode/DecoderSSPto3SAT";
    import { CNF3 } from "$lib/instance/CNF3";
    import type { SSP } from "$lib/instance/SSP";
    import { Reducer3SATtoHCYCLE } from "$lib/reduction/Reducer3SATtoHCYCLE";
    import { Reducer3SATtoSSP } from "$lib/reduction/Reducer3SATtoSSP";
    import { Certificate3SAT } from "$lib/solve/Certificate3SAT";
    import { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";
    import { CertificateSSP } from "$lib/solve/CertificateSSP";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";
    import { onDestroy, onMount } from "svelte";

    let storage = useLocalStorage(
        localStorageKeys.LS_3SAT_SSP, 
        new ReductionStore<CNF3, SSP, Certificate3SAT, CertificateSSP>()
    );

    let redStore = storage.value;

    let showStepper = $state(false);
    let isSolving = $state(false);
    let solveMessage = $state('');
    let currentWorker: Worker | null = null;

    function onEditorChange(cnf: CNF3) {
        // terminate the solver if running
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
            isSolving = false;
            solveMessage = 'Solving cancelled — formula changed.';
        }

        redStore.update(rs => { 
            rs.reset();
            rs.setInInstance(cnf); 
            storage.save();
            return rs; 
        });
    }

    function onReduceClick() {
        if ($redStore.inInstance) {
            const reducer = new Reducer3SATtoSSP($redStore.inInstance);
            const { outInstance, steps } = reducer.reduce();

            redStore.update(rs => {
                rs.steps = steps;
                rs.outInstance = outInstance;
                return rs;
            });

            storage.save();
        }
    }

    async function onSolveClick() {
        let { inCert, outInstance, outCert } = $redStore;
        if (!outInstance || outCert) return;

        isSolving = true;
        solveMessage = 'Solving SSP...';

        // terminate any previous worker just in case
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
        }

        try {
            const workerURL = new URL("$lib/workers/WorkerSSPSolver.ts", import.meta.url);
            const worker = new Worker(workerURL, { type: "module" });

            currentWorker = worker;

            const outCertPromise = new Promise<CertificateSSP | Unsolvable>((resolve, reject) => {
                worker.onmessage = (e) => {
                    if (worker !== currentWorker) 
                        return; // ignore stale workers

                    worker.terminate();
                    currentWorker = null;
                    resolve(e.data);
                };
                worker.onerror = (err) => {
                    if (worker !== currentWorker) 
                        return;

                    worker.terminate();
                    currentWorker = null;
                    reject(err);
                };
            });

            const message = {
                numbers: outInstance.numbers,
                target: outInstance.target,
            };

            worker.postMessage(message);
            outCert = await outCertPromise;

            // ignore if user changed CNF during solving
            // (the current worker is null and the isSolving is false)
            if (!currentWorker && !isSolving) 
                return;

            if (outCert == Unsolvable) {
                redStore.update(rs => {
                    rs.inCert = Unsolvable;
                    rs.outCert = Unsolvable;
                    return rs;
                });
            } else {
                const numbers = outCert.numbers;

                const decoder = new DecoderSSPto3SAT()
                inCert = decoder.decode(outInstance, outCert);

                redStore.update(rs => {
                    rs.inCert = inCert;
                    rs.outCert = outCert;
                    rs.outInstance = outInstance;
                    return rs;
                });
            }

            storage.save();
        } catch (e) {
            console.error('Error during solving:', e);
            solveMessage = 'An error occurred while solving.';
        } finally {
            isSolving = false;
            solveMessage = '';
            currentWorker = null;
        }
    }

    // reset the step index back to 0, if anything changes
    $effect(() => {
        redStore.update(rs => {
            rs.resetStepIndex();
            return rs;
        });
    })

    onDestroy(() => {
        console.debug('onDestroy');
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
        }
    })
</script>

<svelte:head>
    <title>3SAT to SSP</title>
	<meta name="description" content="Redcution from 3SAT to SSP" />
</svelte:head>

<main>
    <h1>3SAT to SSP reduction</h1>

    <Editor3CNF
        cnf={$redStore.inInstance} 
        onChange={(cnf) => onEditorChange(cnf)}
        onWrongFormat={(msg) => alert("From editor: " + msg)}
    />

    <div class="controls">
        <button 
            disabled={!$redStore.hasInInstance() 
                || $redStore.hasOutInstance() 
                || isSolving} 
            onclick={onReduceClick}
        >
            Reduce
        </button>

        <button
            disabled={!$redStore.hasInstances() 
                || $redStore.hasOutCertificate()
                || isSolving}
            onclick={() => onSolveClick()}
        >
            {#if isSolving}
                Solving...
            {:else}
                Solve
            {/if}
        </button>

        <input type="checkbox" bind:checked={showStepper} name="showStepperCheckbox">
        <label for="showStepperCheckbox">Show steps</label>
    </div>

    {#if isSolving}
        <Spinner>{solveMessage}</Spinner>
    {/if}

    {#if showStepper}
        {@const steps = $redStore.steps}
        {@const stepIndex = $redStore.stepIndex}
        {#if steps.length}
            <div>
                {#if stepIndex < steps.length &&
                    steps[stepIndex].inSnapshot && 
                    !steps[stepIndex].inSnapshot.empty()
                }
                    <Renderer3CNF cnf={steps[stepIndex].inSnapshot!} />
                {/if}
            </div>

            <ReductionStepper 
                steps={$redStore.steps} 
                stepIndex={$redStore.stepIndex}
                onPrevClick={() => {
                    redStore.update(rs => { 
                        rs.prevStep();
                        return rs;
                    });
                    storage.save();
                }}
                onNextClick={() => { 
                    redStore.update(rs => { 
                        rs.nextStep();
                        return rs;
                    });
                    storage.save();
                }}
            />

            <div>
                {#if $redStore.stepIndex < $redStore.steps.length && 
                    $redStore.steps[$redStore.stepIndex].outSnapshot}
                    <RendererSSP ssp={$redStore.steps[$redStore.stepIndex].outSnapshot!} />
                {/if}
            </div>
        {:else}
            <span>There are no steps to step through.</span>
        {/if}
    {:else}
        <div class="panes">
            <div>
                {#if $redStore.inInstance && !$redStore.inInstance.empty()}
                    <Renderer3CNF cnf={$redStore.inInstance} />
                {/if}
                {#if $redStore.inCert}
                    <CertRenderer3SAT cert={$redStore.inCert} />
                {/if}
            </div>
            <div>
                {#if $redStore.outInstance && !$redStore.outInstance.empty()}
                    <RendererSSP ssp={$redStore.outInstance} />
                {/if}
                {#if $redStore.outCert}
                    <CertRendererSSP cert={$redStore.outCert}/>
                {/if}
            </div>
        </div>
    {/if}
</main>

<style>
.panes {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1rem;
}
</style>