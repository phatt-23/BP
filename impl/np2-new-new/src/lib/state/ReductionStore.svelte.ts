//
// Created by phatt-23 on 11/10/2025
//

import Serializer from "$lib/core/Serializer";
import type { ProblemInstance } from "$lib/instance/ProblemInstance";
import type { ReductionStep } from "$lib/reduction/ReductionStep";

@Serializer.SerializableClass()
export class ReductionStore<I extends ProblemInstance, O extends ProblemInstance> {
    inInstance: I | null = null
    outInstance: O | null = null
    steps: ReductionStep<I, O>[] = []
    stepIndex: number = 0

    public reset() {
        this.inInstance = null;
        this.outInstance = null;
        this.steps = [];
        this.stepIndex = 0;
    }
    public setInInstance(inInstance: I) {
        this.reset();
        this.inInstance = inInstance;
    }
    public set setSteps(steps: ReductionStep<I, O>[]) {
        this.steps = steps;
        this.stepIndex = 0;
    }
    public nextStep() {
        const stepCount = this.steps.length;
        this.stepIndex = Math.min(this.stepIndex + 1, stepCount);
    }
    public prevStep() {
        this.stepIndex = Math.max(this.stepIndex - 1, 0); 
    }
}
