<!-- Created by phatt-23 on 20/12/2025 -->

<script lang="ts">
    import { Unsolvable } from "$lib/core/Unsolvable";
    import type { Certificate3CG } from "$lib/solve/Certificate3CG";

    type Props = {
        cert : Certificate3CG | Unsolvable;
    };

    const { cert } : Props = $props();
</script>

<main>
    <h2>CertRenderer 3CG</h2>

    {#if cert == Unsolvable}
        <p>The graph can't be colored by 3 colors.</p>
    {:else}
        {cert.rNodes}
        {cert.gNodes}
        {cert.bNodes}
    {/if}
</main>

<style>
</style>

