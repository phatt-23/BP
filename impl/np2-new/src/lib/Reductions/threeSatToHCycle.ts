// phatt-23 2025-10-07

import type { CNF3Instance } from "../Models/Instances/3-CNF";
import type { Edge, GraphInstance } from "../Models/Instances/Graph";
import type { Step } from "../Models/Reductions/Step";
import type { ReductionResult } from "../Models/Reductions/ReductionResult";

export function threeSatToHCycle(cnf: CNF3Instance): any { // ReductionResult<CNF3Instance, GraphInstance> {
    const steps: Step<CNF3Instance, GraphInstance>[] = [];

    // Step 1 - build variable gadgets
    const varNodes: string[] = [];
    const edges: Edge[] = [];

    cnf.vars.forEach((v, i) => {
        const t1 = `v${i}_T1`;
        const t2 = `v${i}_T2`;
        const f1 = `v${i}_F1`;
        const f2 = `v${i}_F2`;
        varNodes.push(t1, t2, f1, f2);
        edges.push({ id: `e_${t1}_${t2}`, from: t1, to: t2 });
        edges.push({ id: `e_${f1}_${f2}`, from: f1, to: f2 });
    })

    const g1: GraphInstance = {
        id: `${cnf.id}-step1`,
        nodes: varNodes.map(id => ({ id: id })),
        edges,
        directed: false,
    };

    steps.push({
        id: "s1",
        title: "Build variable gadgets",
        description: "Each variable xi is represented by two paths: True brach and False branch.",
        inputKind: "3-SAT",
        outputKind: "GRAPH",
        inputSnapshot: cnf,
        outputSnapshot: g1,
        mapping: Object.fromEntries(cnf.vars.map((v,i) => [
            v, [`v${i}_T1`, `v${i}_T2`, `v${i}_F1`, `v${i}_F2`]
        ])),
    });

    // Step 2 - clause gadgets
    const clauseNodes: string[] = [];
    cnf.clauses.forEach((c, i) => {
        const n = `C${i}`;
        clauseNodes.push(n);
    });

    const g2: GraphInstance = {
        id: `${cnf.id}-step2`,
        nodes: [...g1.nodes, ...clauseNodes.map(id => ({ id: id }))],
        edges: [
            ...g1.edges,
            ...clauseNodes.flatMap((n, i) => 
                cnf.clauses[i].lits.map(lit => ({
                    id: `e_${n}_${lit.negated ? "F" : "T"}`,
                    from: n,
                    to: `v${cnf.vars.indexOf(lit.var)}_${lit.negated ? "F1" : "F2"}`,
                })
            ))
        ],
        directed: false,
    };

    steps.push({
        id: "s2",
        title: "Connect clause gadgets",
        description: "Each clause node is connected to the literal branches corresponding to its literal.",
        inputKind: "3-SAT",
        outputKind: "GRAPH",
        inputSnapshot: cnf,
        outputSnapshot: g2,
        mapping: Object.fromEntries(
            cnf.clauses.map((c, i) => [
                c.id,
                c.lits.map((lit: { var: any; negated: any; }) =>  `c_C${i}_${lit.var}_${lit.negated ? "F" : "T" }`),
            ]
        )),
    });

      // Step 3 – Connect gadgets into a full graph
    const chainEdges = cnf.vars.slice(0, -1).map((v, i) => ({
        id: `chain_${i}`,
        from: `v${i}_T2`,
        to: `v${i + 1}_T1`,
    }));

    const finalGraph: GraphInstance = {
        id: `${cnf.id}-final`,
        nodes: g2.nodes,
        edges: [...g2.edges, ...chainEdges],
        directed: false,
    };

    steps.push({
        id: "s3",
        title: "Chain variable gadgets",
        description: "Link variable gadgets sequentially to form a global structure.",
        inputKind: "3SAT",
        outputKind: "GRAPH",
        inputSnapshot: cnf,
        outputSnapshot: finalGraph,
    });

    return { 
        steps, 
        finalInstance: finalGraph,
        witnessMap: (assignment: Record<string, boolean>) => mapAssignmentToHamiltonianCycle(cnf, assignment),
    };
}

/**
 * Maps a satisfying assignment to a Hamiltonian cycle path.
 * This is *not* the real reduction mapping, but a pedagogical approximation:
 * - each variable true/false determines which “literal node” is included
 * - each clause connects to one literal that satisfies it
 */
function mapAssignmentToHamiltonianCycle(
    cnf: CNF3Instance,
    assignment: Record<string, boolean>
) {
    const cycleNodes: string[] = [];

    for (const clause of cnf.clauses) {
        const satisfyingLiteral = clause.lits.find(
        (l) => assignment[l.var] !== l.negated
        );
        if (satisfyingLiteral) {
        const nodeId = `${clause.id}_${satisfyingLiteral.var}_${satisfyingLiteral.negated ? "neg" : "pos"}`;
        cycleNodes.push(nodeId);
        }
    }

    // Connect in a cycle for demonstration
    const nodes = cycleNodes.map((id) => ({ data: { id, label: id } }));
    const edges = cycleNodes.map((id, i) => ({
        data: { source: id, target: cycleNodes[(i + 1) % cycleNodes.length] },
    }));

    return { nodes, edges, cycleNodes };
}
