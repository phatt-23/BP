//
// Created by phatt-23 on 11/10/2025
//

import type { ProblemInstance } from "$lib/instance/ProblemInstance";
import type { ReductionStep } from "./ReductionStep";

export interface Reducer<I extends ProblemInstance, O extends ProblemInstance> {
    inInstance: I; 
    reduce(): { outInstance: O, steps: ReductionStep<I, O>[] };
}