<!-- Created by phatt-23 on 11/10/2025 -->

<script lang="ts">
    import CertRenderer3SAT from "$lib/component/CertRenderer3SAT.svelte";
    import CertRendererHCYCLE from "$lib/component/CertRendererHCYCLE.svelte";
    import Editor3CNF from "$lib/component/Editor3CNF.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import Renderer3CNF from "$lib/component/Renderer3CNF.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import { EDGE_ID_PREFIX, PREFIX_AND_ID_DELIM } from "$lib/core/Id";
    import localStorageKeys from "$lib/core/localStorageKeys";
    import Serializer from "$lib/core/Serializer";
    import { Unsolvable } from "$lib/core/Unsolvable";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import { DecoderHCYCLEto3SAT } from "$lib/decode/DecoderHCYCLEto3SAT";
    import { CNF3 } from "$lib/instance/CNF3.svelte";
    import { Graph } from "$lib/instance/Graph.svelte";
    import { Reducer3SATtoHCYCLE } from "$lib/reduction/Reducer3SATtoHCYCLE";
    import type { Certificate3SAT } from "$lib/solve/Certificate3SAT";
    import type { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";

    let storage = useLocalStorage(
        localStorageKeys.LS_3SAT_HCYCLE, 
        new ReductionStore<CNF3, Graph, Certificate3SAT, CertificateHCYCLE>()
    );

    let redStore = storage.value;

    let showStepper = $state(false);
    let isSolving = $state(false);
    let solveMessage = $state('');

    function onEditorChange(cnf: CNF3) {
        redStore.update(rs => { 
            rs.reset();
            rs.setInInstance(cnf); 
            storage.save();
            return rs; 
        });
    }

    function onReduceClick() {
        if ($redStore.inInstance) {
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
        let { inCert, outInstance, outCert } = $redStore;

        // solve only if the output instance is valid and it hasn't been solved yet
        if (!outInstance || outCert) return;

        isSolving = true;
        solveMessage = 'Solving Hamiltonian cycle...';

        try {
            const worker = new Worker(new URL("$lib/workers/WorkerHCYCLESolver.ts", import.meta.url), { type: "module" });

            const outCertPromise = new Promise<CertificateHCYCLE | Unsolvable>(resolve => {
                worker.onmessage = (e) => {
                    worker.terminate();
                    resolve(e.data);
                };
            });

            worker.postMessage(outInstance.toSerializedString());
            outCert = await outCertPromise;

            if (outCert == Unsolvable) {
                redStore.update(rs => {
                    rs.inCert = Unsolvable;
                    rs.outCert = Unsolvable;
                    return rs;
                });
            } else {
                // Style the graph, so the path visible.

                // alias
                const graph = outInstance;
                const path = outCert.path;

                // add 'solved' class ot every edge
                // all 'solved' edges are dimmed down
                // only those that are 'solved' and 'used' 
                // will at full opacity
                graph.edges.forEach(e => e.classes += ' solved');

                const cutPrefix = (id : string) => id.slice(id.search(PREFIX_AND_ID_DELIM) + 1)

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

                // decode back to 3SAT
                inCert = new DecoderHCYCLEto3SAT().decode(graph, outCert);

                redStore.update(rs => {
                    rs.inCert = inCert;
                    rs.outCert = outCert;
                    rs.outInstance = graph;
                    return rs;
                });
            }

            // Save changes to storage
            storage.save();

        } catch (e) {
            console.error('Error during solving:', e);
            solveMessage = 'An error occured while solving.';
        } finally {
            isSolving = false;
            solveMessage = '';
        }
    }

    // reset the step index back to 0, if anything changes
    $effect(() => {
        redStore.update(rs => {
            rs.resetStepIndex();
            return rs;
        });
    })
</script>

<svelte:head>
    <title>3SAT to HCYCLE</title>
	<meta name="description" content="Redcution from 3SAT to HCYCLE" />
</svelte:head>

<section>
    <h1>3SAT to HCYCLE reduction</h1>

    <Editor3CNF
        cnf={$redStore.inInstance} 
        onChange={(cnf) => onEditorChange(cnf)}
        onWrongFormat={(msg) => alert("From editor: " + msg)}
    />

    <div>
        <button onclick={onReduceClick}>Reduce</button>

        <button
            disabled={!$redStore.hasInstances() || isSolving}
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
        <div class="loading">
            <span class="spinner"></span>
            <span>{solveMessage}</span>
        </div>
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
                {#if $redStore.inInstance && !$redStore.inInstance.empty()}
                    <Renderer3CNF cnf={$redStore.inInstance} />
                {/if}
                {#if $redStore.inCert}
                    <CertRenderer3SAT cert={$redStore.inCert} />
                {/if}
            </div>
            <div>
                {#if $redStore.outInstance && !$redStore.outInstance.empty()}
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
</section>

<style>
.panes {
    display: grid;
    grid-template-columns: 1fr;
    gap: 1rem;
}

.loading {
    display: flex;
    align-items: center;
    gap: 0.5rem;
    margin-top: 0.5rem;
    font-style: italic;
}

.spinner {
    width: 1em;
    height: 1em;
    border: 2px solid rgba(0,0,0,0.2);
    border-top-color: rgba(0,0,0,0.6);
    border-radius: 50%;
    animation: spin 0.6s linear infinite;
}

@keyframes spin {
    to { transform: rotate(360deg); }
}
</style>



