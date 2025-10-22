<!-- Created by phatt-23 on 22/10/2025 -->

<script lang="ts">
    import type { SSP } from "$lib/instance/SSP";

    type Props = {
        ssp: SSP;
    };

    let { ssp }: Props = $props();
</script>

<main>
    <h2>SSP Renderer</h2>
    <p>Target: {ssp.target}</p>
    <p>Numbers:</p>
    <ul>
        {#each ssp.numbers as num, i} 
            <li>{num.value}</li>
        {/each}
    </ul>
</main>