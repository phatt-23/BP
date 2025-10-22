import type { CNF3 } from "$lib/instance/CNF3";
import { SSP, SSPNumber } from "$lib/instance/SSP";
import type { Reducer } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class Reducer3SATtoSSP implements Reducer<CNF3, SSP> {
    inInstance: CNF3;

    constructor(instance: CNF3) {
        this.inInstance = instance;
    }

    reduce(): { outInstance: SSP; steps: ReductionStep<CNF3, SSP>[]; } {
        const { variables, clauses } = this.inInstance;
        const ssp = new SSP();

        /**
         * let v = number of variables
         * let c = number of clauses
         * let k = v + c
         * 
         * construct 2 * k numbers, each with k digits
         * 
         * these numbers can stored in (2 * k)x(k) matrix
         */

        const v = variables.length;
        const c = clauses.length;
        const k = v + c;

        const matrix = Array.from({ length: 2 * k}, () => new Array(k).fill(0));


        /**
         * fill the diagonal
         */

        for (let i = 0; i < k; i++) {
            matrix[2 * i][i] = 1;
            matrix[2 * i + 1][i] = 1;
        }

        /**
         * fill numbers for clauses
         */

        clauses.forEach((clause, i) => clause.literals.forEach(lit => {
            // lookup the index of the current literal variable name
            const idx = variables.findIndex(v => v == lit.varName);

            // set the literal in the clause
            matrix[2 * idx + (lit.negated ? 1 : 0)][v + i] = 1;
        }));
    
        const steps: ReductionStep<CNF3, SSP>[] = [];
        
        matrix.forEach((arr, i) => {
            ssp.addNumber(new SSPNumber(`${i}`, arr));
        });

        /**
         * The target sum is simply v number of 1s and c number of 3s.
         */
        const target = [...new Array(v).fill(1), ...new Array(c).fill(3)];
        ssp.setTarget(target);

        return {
            outInstance: ssp,
            steps,
        };
    }

}