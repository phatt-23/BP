<!-- Created by phatt-23 on 11/10/2025 -->

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
        <input bind:checked={viewAsColumn} type="checkbox" name="viewAsColumnCheckbox">
        <label for="viewAsColumnCheckbox">View as column</label>
    </div>

    {#each cnf.clauses as clause, i}
        {#if viewAsColumn}
            <div class="clause">
                {@html clause.asHtmlString()}
            </div> 
        {:else}
            <span class="clause">
                {@html clause.asHtmlString()}
            </span> 
            {@html i < cnf.clauses.length - 1 ? '&and;': ''}
        {/if}
    {/each}
</div>

<style>
.clause { margin: 0.2em 0; }
</style>