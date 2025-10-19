// phatt-23 2025-10-07

import type { Step } from "./Step";

export interface ReductionResult<S = any, T = any> {
    steps: Step<S, T>[];
    finalInstance: T;
}
