<!-- Created by phatt-23 on 19/10/2025 -->

<script lang="ts">
    import type { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";

    type Props = {
        cert : CertificateHCYCLE;
    };

    const { cert } : Props = $props();

    const path = cert.path;

    let showAsList = $state(true);
</script>

<main>
    <h2>CertRenderer HCYCLE</h2>

    <div class="controls">
        <input type="checkbox" bind:checked={showAsList} name="showAsListCheckbox">
        <label for="showAsListCheckbox">Show as list</label>
    </div>

    {#if showAsList}
        <ol>
            {#each path as node, i}
                <li>
                    {node.id}
                </li>
            {/each}
        </ol>
    {:else}
        <div>
            {#each path as node, i}
                <span>{@html i != 0 ? '&ThinSpace;&LongRightArrow;&ThinSpace;' : ''} {node.id}</span>
            {/each}
        </div>
    {/if}
</main>

<style>
</style>
