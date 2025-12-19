<!-- Created by phatt-23 on 19/10/2025 -->

<script lang="ts">
    import CertRendererHCIRCUIT from "$lib/component/CertRendererHCIRCUIT.svelte";
    import CertRendererHCYCLE from "$lib/component/CertRendererHCYCLE.svelte";
    import EditorGraph from "$lib/component/EditorGraph.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import RendererEditableGraph from "$lib/component/RendererEditableGraph.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import Spinner from "$lib/component/Spinner.svelte";
    import { EDGE_ID_PREFIX, PREFIX_AND_ID_DELIM } from "$lib/core/Id";
    import localStorageKeys from "$lib/core/localStorageKeys";
    import { Unsolvable } from "$lib/core/Unsolvable";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import { DecorderHCIRCUITtoHCYCLE } from "$lib/decode/DecoderHCIRCUITtoHCYCLE";
    import type { Graph } from "$lib/instance/Graph";
    import { ReducerHCYCLEtoHCIRCUIT } from "$lib/reduction/ReducerHCYCLEtoHCIRCUIT";
    import type { CertificateHCIRCUIT } from "$lib/solve/CertificateHCIRCUIT";
    import type { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";
    import { onDestroy, onMount } from "svelte";

    let storage = useLocalStorage(
        localStorageKeys.LS_HCYCLE_HCIRCUIT,
        new ReductionStore<Graph, Graph, CertificateHCYCLE, CertificateHCIRCUIT>()
    );

    let redStore = storage.value
    console.debug('input instance:', $redStore.inInstance)

    let showStepper = $state(false);
    let isSolving = $state(false);
    let solveMessage = $state('');
    let currentWorker: Worker | null = null;

    function onEditorChange(graph: Graph) {
        console.debug('onEditorChange');

        // terminate the solver if running
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
            isSolving = false;
            solveMessage = 'Solving cancelled — formula changed.';
        }

        redStore.update(rs => { 
            rs.reset();
            rs.setInInstance(graph); 
            storage.save();
            return rs; 
        });
    }

    function onReduceClick() {
        if ($redStore.inInstance && !$redStore.inInstance.isEmpty()) {
            const reducer = new ReducerHCYCLEtoHCIRCUIT($redStore.inInstance);
            const { outInstance, steps } = reducer.reduce();

            redStore.update(rs => {
                rs.setSteps(steps);
                rs.setOutInstance(outInstance);
                storage.save();
                return rs;
            });
        }
    }

    async function onSolveClick() {
        let { inCert, outInstance, outCert } = $redStore;
        if (!outInstance || outCert) return;

        isSolving = true;
        solveMessage = 'Solving Hamiltonian circuit...';

        // terminate any previous worker just in case
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
        }

        try {
            const worker = new Worker(
                new URL("$lib/workers/WorkerHCIRCUITSolver.ts", import.meta.url),
                { type: "module" }
            );
            currentWorker = worker;

            const outCertPromise = new Promise<CertificateHCIRCUIT | Unsolvable>((resolve, reject) => {
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
                    const edgeIdMirror = EDGE_ID_PREFIX + `${to}-${from}`;

                    const edge = graph.edges.find(e => e.id == edgeId || e.id == edgeIdMirror);

                    if (edge) {
                        graph.removeEdge(edge);
                        edge.classes += ' used';
                        graph.addEdge(edge);
                    }
                }

                console.debug('Path', path);
                console.debug('After class assignment', graph.edges);

                const decoder = new DecorderHCIRCUITtoHCYCLE()
                inCert = decoder.decode(graph, outCert);

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
        if (currentWorker) {
            currentWorker.terminate();
            currentWorker = null;
        }
    })
</script>

<svelte:head>
    <title>HCYCLE to HCIRCUIT</title>
	<meta name="description" content="Reduction from HCYCLE to HCIRCUIT" />
</svelte:head>

<main>
    <h1>
        HCYCLE to HCIRCUIT reduction
    </h1>

    <EditorGraph
        graph={$redStore.inInstance}
        onChange={(graph) => onEditorChange(graph)}
        onWrongFormat={(msg) => alert("From graph editor: " + msg)}
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
                    !steps[stepIndex].inSnapshot.isEmpty()
                }
                    <RendererGraph 
                        graph={steps[stepIndex].inSnapshot!} 
                        style='DIRECTED'
                        layout='circle'
                    />
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
                        style='HCIRCUIT'
                        layout='preset'
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
                    <RendererEditableGraph 
                        graph={$redStore.inInstance} 
                        style='DIRECTED' 
                        layout='circle'
                        directed 
                        onAddEdge={(edge) => {
                            redStore.update(rs => {
                                let inInstance = rs.inInstance!;
                                inInstance.addEdge(edge);

                                rs.reset();
                                rs.setInInstance(inInstance);
                                storage.save();

                                return rs;
                            });
                        }}
                        onRemoveEdge={(edge) => {
                            redStore.update(rs => {
                                let inInstance = rs.inInstance!;
                                inInstance.removeEdgeById(edge.id());

                                rs.reset();
                                rs.setInInstance(inInstance);
                                storage.save();

                                return rs;
                            });
                        }}
                    />
                {/if}
                {#if $redStore.inCert}
                    <CertRendererHCYCLE cert={$redStore.inCert} />
                {/if}
            </div>
            <div>
                {#if $redStore.outInstance && !$redStore.outInstance.isEmpty()}
                    <RendererGraph 
                        graph={$redStore.outInstance} 
                        style='HCIRCUIT'
                        layout='preset'
                    />
                {/if}
                {#if $redStore.outCert}
                    <CertRendererHCIRCUIT cert={$redStore.outCert}/>
                {/if}
            </div>
        </div>
    {/if}
</main>
