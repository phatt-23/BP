// phatt-23 2025-10-07
// 3-CNF demo instances

import type { CNF3Instance } from "../Instances/3-CNF";

export const exampleCNF: CNF3Instance = {
    id: "demo_cnf",
    vars: [
        "x1", 
        "x2", 
        "x3",
    ],
    clauses: [
        {
            id: "C1",
            lits: [
                { id: "l1", var: "x1", negated: false },
                { id: "l2", var: "x2", negated: true },
                { id: "l3", var: "x3", negated: false },
            ],
        },
        {
            id: "C2",
            lits: [
                { id: "l4", var: "x1", negated: true },
                { id: "l5", var: "x2", negated: false },
                { id: "l6", var: "x3", negated: true },
            ],
        },
        {
            id: "C3",
            lits: [
                { id: "l7", var: "x1", negated: false },
                { id: "l8", var: "x2", negated: false },
                { id: "l9", var: "x3", negated: false },
            ],
        },
    ],
};