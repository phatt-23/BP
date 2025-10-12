<!--
Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import Editor3SAT from "$lib/component/Editor3SAT.svelte";
    import ReductionStepper from "$lib/component/ReductionStepper.svelte";
    import Renderer3SAT from "$lib/component/Renderer3SAT.svelte";
    import RendererGraph from "$lib/component/RendererGraph.svelte";
    import Serializer from "$lib/core/Serializer";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import type { CNF3 } from "$lib/instance/CNF3.svelte";
    import type { Graph } from "$lib/instance/Graph.svelte";
    import { Reducer3SATtoHCYCLE } from "$lib/reduction/Reducer3SATtoHCYCLE";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";

    const LS_3SAT_HCYCLE = "$_cookie_3sat_hcycle"

    let state = useLocalStorage(LS_3SAT_HCYCLE, new ReductionStore<CNF3, Graph>());
    let redStore = state.value;

    function onReduceClick() {
        if ($redStore.inInstance) {
            const reducer = new Reducer3SATtoHCYCLE($redStore.inInstance);
            const { outInstance, steps } = reducer.reduce();

            redStore.update(rs => {
                rs.steps = steps;
                rs.outInstance = outInstance;
                state.save();
                return rs;
            });
        }
    }
</script>

<svelte:head>
    <title>3SAT to HCYCLE</title>
	<meta name="description" content="Redcution from 3SAT to HCYCLE" />
</svelte:head>

<section>
    <h1>3SAT to HCYCLE reduction</h1>

    <Editor3SAT 
        cnf={$redStore.inInstance} 
        onChange={(newCnf) => redStore.update(rs => { 
            rs.inInstance = newCnf; 
            state.save();
            return rs; 
        })}
        onWrongFormat={(msg) => alert("From editor: " + msg)}
    />

    <button onclick={onReduceClick}>Reduce</button>

    <div class="panes">
        <div>
            {#if $redStore.inInstance}
                <Renderer3SAT cnf={$redStore.inInstance} />
            {/if}
        </div>
        <div>
            {#if $redStore.outInstance}
                <RendererGraph graph={$redStore.outInstance} />
            {/if}
        </div>
    </div>

    {#if $redStore.steps.length}
        <ReductionStepper steps={$redStore.steps} />
    {/if}

    {#if $redStore.inInstance}
        <p>{JSON.stringify(Serializer.serialize($redStore.inInstance))}</p>
        <p>{JSON.stringify(Serializer.serialize($redStore.outInstance))}</p>
    {/if}
</section>

<style>
.panes {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 1rem;
}
</style>



