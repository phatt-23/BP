<!-- Created by phatt-23 on 11/10/2025 -->

<script lang="ts">
    import CertRenderer3SAT from "$lib/component/CertRenderer3SAT.svelte";
    import CertRendererHCYCLE from "$lib/component/CertRendererHCYCLE.svelte";
    import Editor3CNF from "$lib/component/Editor3CNF.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import Renderer3CNF from "$lib/component/Renderer3CNF.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import Spinner from "$lib/component/Spinner.svelte";
    import { EDGE_ID_PREFIX, PREFIX_AND_ID_DELIM } from "$lib/core/Id";
    import localStorageKeys from "$lib/core/localStorageKeys";
    import { Unsolvable } from "$lib/core/Unsolvable";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import { DecoderHCYCLEto3SAT } from "$lib/decode/DecoderHCYCLEto3SAT";
    import { CNF3 } from "$lib/instance/CNF3";
    import { Graph } from "$lib/instance/Graph";
    import { Reducer3SATtoHCYCLE } from "$lib/reduction/Reducer3SATtoHCYCLE";
    import { Certificate3SAT } from "$lib/solve/Certificate3SAT";
    import { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";
    import { onDestroy, onMount } from "svelte";

    let storage = useLocalStorage(
        localStorageKeys.LS_3SAT_HCYCLE, 
        new ReductionStore<CNF3, Graph, Certificate3SAT, CertificateHCYCLE>()
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
        if ($redStore.inInstance && !$redStore.inInstance.isEmpty()) {
            const reducer = new Reducer3SATtoHCYCLE($redStore.inInstance);
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
        if (!$redStore.inInstance || $redStore.inInstance.isEmpty()) {
            throw "Input instance is not set or is empty.";
        }

        let { inCert, outInstance, outCert } = $redStore;
        if (!outInstance || outCert) return;

        isSolving = true;
        solveMessage = 'Solving Hamiltonian cycle...';

        // terminate any previous worker just in case
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
        }

        try {
            const worker = new Worker(
                new URL("$lib/workers/WorkerHCYCLESolver.ts", import.meta.url),
                { type: "module" }
            );
            currentWorker = worker;

            const outCertPromise = new Promise<CertificateHCYCLE | Unsolvable>((resolve, reject) => {
                worker.onmessage = (e) => {
                    if (worker !== currentWorker) return; // ignore stale workers
                    worker.terminate();
                    currentWorker = null;
                    resolve(e.data);
                };
                worker.onerror = (err) => {
                    if (worker !== currentWorker) return;
                    worker.terminate();
                    currentWorker = null;
                    reject(err);
                };
            });

            worker.postMessage(outInstance.toSerializedString());
            outCert = await outCertPromise;

            // ignore if user changed CNF during solving
            if (!currentWorker && !isSolving) return;

            if (outCert == Unsolvable) {
                redStore.update(rs => {
                    rs.inCert = Unsolvable;
                    rs.outCert = Unsolvable;
                    return rs;
                });
            } else {
                const graph = outInstance;
                const path = outCert.path;
                graph.edges.forEach(e => e.classes += ' solved');

                const cutPrefix = (id: string) => id.slice(id.search(PREFIX_AND_ID_DELIM) + 1);

                for (let i = 0; i < path.length - 1; i++) {
                    const from = cutPrefix(path[i].id);
                    const to = cutPrefix(path[i + 1].id);
                    const edgeId = EDGE_ID_PREFIX + `${from}-${to}`;
                    const edge = graph.edges.find(e => e.id == edgeId);
                    if (edge) {
                        graph.removeEdge(edge);
                        edge.classes += ' used';
                        graph.addEdge(edge);
                    }
                }

                inCert = new DecoderHCYCLEto3SAT().decode(graph, outCert);

                redStore.update(rs => {
                    rs.inCert = inCert;
                    rs.outCert = outCert;
                    rs.outInstance = graph;
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
    <title>3SAT to HCYCLE</title>
	<meta name="description" content="Redcution from 3SAT to HCYCLE" />
</svelte:head>

<main>
    <h1>3SAT to HCYCLE reduction</h1>

    <Editor3CNF
        cnf={$redStore.inInstance} 
        onChange={(cnf) => onEditorChange(cnf)}
        onWrongFormat={(msg) => alert("From editor: " + msg)}
    />

    <div class="controls">
        <button 
            disabled={!$redStore.hasInInstance() 
                || $redStore.hasOutInstance() 
                || $redStore.inInstance?.isEmpty()
                || isSolving} 
            onclick={onReduceClick}
        >
            Reduce
        </button>

        <button
            disabled={!$redStore.hasInstances() 
                || $redStore.hasOutCertificate()
                || $redStore.inInstance?.isEmpty()
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
                    !steps[stepIndex].inSnapshot.isEmpty()
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
                    <RendererGraph 
                        graph={$redStore.steps[$redStore.stepIndex].outSnapshot!} 
                        style={'3SAT-HCYCLE'}
                    />
                {/if}
            </div>
        {:else}
            <span>There are no steps to step through.</span>
        {/if}
    {:else}
        <div class="panes">
            <div>
                {#if $redStore.inInstance && !$redStore.inInstance.isEmpty()}
                    <Renderer3CNF cnf={$redStore.inInstance} />
                {/if}
                {#if $redStore.inCert}
                    <CertRenderer3SAT cert={$redStore.inCert} />
                {/if}
            </div>
            <div>
                {#if $redStore.outInstance && !$redStore.outInstance.isEmpty()}
                    <RendererGraph graph={$redStore.outInstance} style={'3SAT-HCYCLE'}/>
                {/if}
                {#if $redStore.outCert}
                    <CertRendererHCYCLE cert={$redStore.outCert}/>
                {/if}
            </div>
        </div>
    {/if}


    <!-- {#if $redStore.inInstance}
        <p>{JSON.stringify(Serializer.serialize($redStore.inInstance))}</p>
        <p>{JSON.stringify(Serializer.serialize($redStore.outInstance))}</p>
    {/if} -->
</main>

<style>
.panes {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1rem;
}
</style>
