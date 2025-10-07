<!-- phatt 2025-10-06 -->
<!-- Small editor for creating input instances for 3-SAT -->

<script lang="ts">
    import { currentInstance, reductionSteps, currentStepIndex } from "../../stores";
    import { threeSatToHCycle } from "../../Reductions/threeSatToHCycle";
    import type { CNF3Instance } from "../../Models/Instances/CNF";

    type Props = {
        initial: CNF3Instance;
    }

    const { initial }: Props = $props();

    let cnf: CNF3Instance = $state(initial);

    function addVariable() {
        const nextId = `x${cnf.vars.length + 1}`;
        cnf.vars.push(nextId);
    }

    function addClause() {
        const newId = `C${cnf.clauses.length + 1}`;
        const defaultLits = Array.from({ length: 3 }).map((_, i) => ({
        id: `${newId}_l${i}`,
        var: cnf.vars[Math.min(i, cnf.vars.length - 1)],
        negated: false,
        }));
        cnf.clauses.push({ id: newId, lits: defaultLits as any });
    }

    function runReduction() {
        currentInstance.set(cnf);
        const { steps } = threeSatToHCycle(cnf);
        reductionSteps.set(steps);
        currentStepIndex.set(0);
    }

    function toggleNeg(clauseIndex: number, litIndex: number) {
        cnf.clauses[clauseIndex].lits[litIndex].negated = !cnf.clauses[clauseIndex].lits[litIndex].negated;
    }
</script>

<div class="editor">
    <h3>CNF Editor</h3>

    <div class="vars">
        <strong>Variables:</strong>
        {#each cnf.vars as v}
        <span class="var">{v}</span>
        {/each}
        <button onclick={addVariable}>+ Var</button>
    </div>

    <div class="clauses">
        <strong>Clauses:</strong>
        {#each cnf.clauses as clause, ci}
        <div class="clause">
            ({#each clause.lits as lit, li}
            <button
                class="lit {lit.negated ? 'neg' : ''}"
                onclick={() => toggleNeg(ci, li)}>
                {lit.negated ? '¬' : ''}{lit.var}
            </button>{li < 2 ? ' ∨ ' : ''}
            {/each})
        </div>
        {/each}
        <button onclick={addClause}>+ Clause</button>
    </div>

    <button class="run" onclick={runReduction}>Run Reduction</button>

</div>

<style>
.editor { padding:1rem; border:1px solid #ccc; border-radius:1rem; background:#f8f8f8; }
.vars, .clauses { margin-bottom:0.8rem; }
.var { background:#e0e0e0; padding:0.2rem 0.4rem; border-radius:4px; margin:0 0.2rem; }
.lit { background:none; border:none; cursor:pointer; font-family:monospace; }
.lit.neg { color:crimson; }
.run { margin-top:0.8rem; padding:0.4rem 1rem; border-radius:8px; }
</style>
