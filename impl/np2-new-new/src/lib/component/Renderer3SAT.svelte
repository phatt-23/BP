<!--
    Created by phatt-23 on 11/10/2025
-->

<script lang="ts">
    import type { CNF3 } from "$lib/instance/CNF3.svelte";

    type Props = {
        cnf: CNF3;
    }

    const { cnf }: Props = $props();

    let viewAsColumn = $state(false)
</script>

<div class="cnf-renderer">
    <h2>CNF Renderer</h2>

    <div>
        <label for="viewAsColumnCheckbox">view as column</label>
        <input bind:checked={viewAsColumn} type="checkbox" name="viewAsColumnCheckbox">
    </div>

    {#each cnf.clauses as clause, i}
        {#if viewAsColumn}
            <div class="clause">
                ({#each clause.literals as lit, j}
                    <span class:neg={lit.negated} class="literal">{lit.negated ? '¬' : ''}{lit.varName}</span>{j < 2 ? '∨' : ''}
                {/each})
            </div> 
        {:else}
            <span class="clause">
                ({#each clause.literals as lit, j}
                    <span class:neg={lit.negated} class="literal">{lit.negated ? '¬' : ''}{lit.varName}</span>{j < 2 ? '∨' : ''}
                {/each})
            </span> 
            {i < cnf.clauses.size - 1 ? '∧': ''}
        {/if}
    {/each}
</div>

<style>
    .neg { color: crimson; }
    .clause { margin: 0.2em 0; }
</style>