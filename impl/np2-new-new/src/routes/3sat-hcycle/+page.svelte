<!--
Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import Editor3SAT from "$lib/component/Editor3SAT.svelte";
    import Renderer3SAT from "$lib/component/Renderer3SAT.svelte";
    import { Serializer } from "$lib/core/Serializer";
    import useLocalStorage from "$lib/core/useLocalStorage.svelte";
    import type { CNF3 } from "$lib/instance/CNF3.svelte";
    import type { Graph } from "$lib/instance/Graph.svelte";
    import { ReductionStore } from "$lib/state/ReductionStore.svelte";
    import { onMount } from "svelte";
    import { writable } from "svelte/store";

    const LOCAL_STORAGE_3SAT_HCYCLE = "$_cookie_3sat_hcycle"

    let redStore = writable(new ReductionStore<CNF3, Graph>());

    onMount(() => {
        const currentValue = localStorage.getItem(LOCAL_STORAGE_3SAT_HCYCLE);
        if (currentValue) 
            $redStore = Serializer.revive(JSON.parse(currentValue));
    });

    const save = () => {
        const str = JSON.stringify(Serializer.serialize($redStore))
        localStorage.setItem(LOCAL_STORAGE_3SAT_HCYCLE, str);
    };

</script>

<svelte:head>
    <title>3SAT to HCYCLE</title>
	<meta name="description" content="Redcution from 3SAT to HCYCLE" />
</svelte:head>

<section>
    <h1>
        3SAT to HCYCLE reduction
    </h1>

    <Editor3SAT 
        cnf={$redStore.inInstance} 
        onChange={(newCnf) => redStore.update(rs => { 
            rs.inInstance = newCnf; 
            save();
            return rs; 
        })}
        onWrongFormat={(msg) => alert("From editor: " + msg)}
    />

    {#if $redStore.inInstance}
        <Renderer3SAT cnf={$redStore.inInstance} />
    {/if}
</section>



