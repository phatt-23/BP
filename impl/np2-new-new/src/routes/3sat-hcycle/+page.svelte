<!--
Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import CertRenderer3SAT from "$lib/component/CertRenderer3SAT.svelte";
    import CertRendererHCYCLE from "$lib/component/CertRendererHCYCLE.svelte";
    import Editor3CNF from "$lib/component/Editor3CNF.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import Renderer3CNF from "$lib/component/Renderer3CNF.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import { EDGE_ID_PREFIX, PREFIX_AND_ID_DELIM } from "$lib/core/Id";
    import localStorageKeys from "$lib/core/localStorageKeys";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import { DecoderHCYCLEto3SAT } from "$lib/decode/DecoderHCYCLEto3SAT";
    import type { CNF3 } from "$lib/instance/CNF3.svelte";
    import { Graph } from "$lib/instance/Graph.svelte";
    import { Reducer3SATtoHCYCLE } from "$lib/reduction/Reducer3SATtoHCYCLE";
    import type { Certificate3SAT } from "$lib/solve/Certificate3SAT";
    import type { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";
    import { Solver3SAT } from "$lib/solve/Solver3SAT";
    import { SolverHCYCLE } from "$lib/solve/SolverHCYCLE";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";

    let storage = useLocalStorage(
        localStorageKeys.LS_3SAT_HCYCLE, 
        new ReductionStore<CNF3, Graph, Certificate3SAT, CertificateHCYCLE>()
    );

    let redStore = storage.value;

    let showStepper = $state(false);

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

    function onSolveClick() {
        let { inCert, outInstance, outCert } = $redStore;

        // if (inInstance && !cert3SAT) {
        //     cert3SAT = new Solver3SAT(inInstance).solve();
        // }

        // solve only if the output instance is valid and it hasn't been solved yet
        if (outInstance && !outCert) {
            outCert = new SolverHCYCLE(outInstance).solve();
            if (!outCert) {
                return;
            }

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
            disabled={!$redStore.hasInstances()} 
            onclick={onSolveClick}
        >
            Solve
        </button>

        <input type="checkbox" bind:checked={showStepper} name="showStepperCheckbox">
        <label for="showStepperCheckbox">Show steps</label>
    </div>

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
</style>



