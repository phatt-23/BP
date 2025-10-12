<!--
    Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import type { CNF3 } from "$lib/instance/CNF3.svelte";

    type Props = {
        cnf: CNF3;
    }
    const { cnf }: Props = $props();
</script>

<div class="cnf-renderer">
    <h2>CNF Renderer</h2>

    {#each cnf.clauses as clause}
        <div class="clause">
            ({#each clause.literals as lit, i}
                <span class:neg={lit.negated} class="literal">{lit.negated ? '¬' : ''}{lit.varName}</span>{i < 2 ? '∨' : ''}
            {/each})
        </div> 
    {/each}
</div>

<style>
    .neg { color: crimson; }
    .clause { margin: 0.2em 0; }
</style>