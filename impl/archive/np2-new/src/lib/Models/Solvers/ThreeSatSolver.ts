// phatt-23 2025-10-07

import type { CNF3Instance } from "../Instances/3-CNF";

export class ThreeSatSolver {
    cnf: CNF3Instance;

    constructor(instance: CNF3Instance) {
        this.cnf = instance;
    }

    solve(): Record<string, boolean> | null {
        const vars = this.cnf.vars;
        const n = vars.length;
        for (let mask = 0; mask < (1 << n); mask++) {
            const assignment: Record<string, boolean> = {};
            vars.forEach((v, i) => (assignment[v] = Boolean(mask & (1 << i))));
            const sat = this.cnf.clauses.every(clause =>
                clause.lits.some(l => assignment[l.var] !== l.negated)
            );
            if (sat) 
                return assignment;
        }
        return null; 
    }
}