<!--
Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import Editor3CNF from "$lib/component/Editor3CNF.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import Renderer3CNF from "$lib/component/Renderer3CNF.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import localStorageKeys from "$lib/core/localStorageKeys";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import type { CNF3 } from "$lib/instance/CNF3.svelte";
    import type { Graph } from "$lib/instance/Graph.svelte";
    import { Reducer3SATtoHCYCLE } from "$lib/reduction/Reducer3SATtoHCYCLE";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";

    let storage = useLocalStorage(localStorageKeys.LS_3SAT_HCYCLE, new ReductionStore<CNF3, Graph>());
    let redStore = storage.value;

    let showStepper = $state(false);

    function onEditorChange(cnf: CNF3) {
        redStore.update(rs => { 
            rs.inInstance = cnf; 
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

        <label for="showStepperCheckbox">Show steps</label>
        <input type="checkbox" bind:checked={showStepper} name="showStepperCheckbox">
    </div>

    {#if showStepper}
        {#if $redStore.steps.length}
            <div>
                {#if $redStore.steps[$redStore.stepIndex].inSnapshot}
                    <Renderer3CNF cnf={$redStore.steps[$redStore.stepIndex].inSnapshot!} />
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
                {#if $redStore.steps[$redStore.stepIndex].outSnapshot}
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
                {#if $redStore.inInstance}
                    <Renderer3CNF cnf={$redStore.inInstance} />
                {/if}
            </div>
            <div>
                {#if $redStore.outInstance}
                    <RendererGraph graph={$redStore.outInstance} style={'3SAT-HCYCLE'}/>
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



