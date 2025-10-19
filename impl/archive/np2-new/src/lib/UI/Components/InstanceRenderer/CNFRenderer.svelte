<!-- phatt-23 2025-10-07 -->

<script lang="ts">
    import type { CNF3Instance } from "../../../Models/Instances/CNF";

    interface Props {
        cnf: CNF3Instance,
    };

    let { cnf }: Props = $props();
</script>

<div class="cnf">
    {#each cnf.clauses as clause}
        <div class="clause">
        ({#each clause.lits as lit, i}
            <span class:neg={lit.negated}>{lit.negated ? '¬' : ''}{lit.var}</span>{i < 2 ? ' ∨ ' : ''}
        {/each})
        </div>
    {/each}
</div>

<style>
.cnf { font-family: monospace; line-height: 1.4; }
.neg { color: crimson; }
.clause { margin: 0.2em 0; }
</style>
