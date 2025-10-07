// phatt 2025-10-06

import { type Step } from "./Step";
import { type ProblemInstance } from "../Instances/ProblemInstance";

export interface ReductionPlannerRunner<S = any, T = any> {
    id: string;
    name: string;
    run(input: S): { steps: Step<S,T>[], finalInstance: ProblemInstance<T> };
}