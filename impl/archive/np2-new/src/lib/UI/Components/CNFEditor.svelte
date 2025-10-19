<!-- phatt 2025-10-06 -->
<!-- Small editor for creating input instances for 3-SAT -->

<script lang="ts">
    import { currentInstance, reductionSteps, currentStepIndex } from "../../stores";
    import { threeSatToHCycle } from "../../Reductions/threeSatToHCycle";
    import type { CNF3Instance } from "../../Models/Instances/CNF";

    type Props = { initial: CNF3Instance; }
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
            var: cnf.vars.length > 0 ? cnf.vars[Math.min(i, cnf.vars.length - 1)] : "x1",
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

    function setLiteralVar(clauseIndex: number, litIndex: number, newVar: string) {
        cnf.clauses[clauseIndex].lits[litIndex].var = newVar;
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
                    <span class="lit-wrapper">
                        <button
                            class="lit {lit.negated ? 'neg' : ''}"
                            onclick={() => toggleNeg(ci, li)}>
                            {lit.negated ? '¬' : ''}
                        </button>
                        <select
                            bind:value={lit.var}
                            onchange={(e) => {
                                if (e.target) {
                                    setLiteralVar(ci, li, e.target.value);
                                }
                            }}>
                            {#each cnf.vars as v}
                                <option value={v}>{v}</option>
                            {/each}
                        </select>
                    </span>{li < 2 ? ' ∨ ' : ''}
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
.lit-wrapper { display:inline-flex; align-items:center; margin-right:0.25rem; }
.lit { background:none; border:none; cursor:pointer; font-family:monospace; font-size:1rem; }
.lit.neg { color:crimson; }
select { margin-left:0.1rem; border-radius:4px; }
.run { margin-top:0.8rem; padding:0.4rem 1rem; border-radius:8px; }
</style>