// phatt 2025-10-07

import { get, writable, type Writable } from 'svelte/store';
import type { Step } from './Models/Reductions/Step';
import type { CNF3Instance } from './Models/Instances/CNF'; 
import type { GraphInstance } from './Models/Instances/Graph';
import type { ThreeDMInstance } from './Models/Instances/3DM';
import type { SSPInstance } from './Models/Instances/SSP';
import { threeSatToHCycle } from './Reductions/threeSatToHCycle';

export class ReductionStore<TInput, TOutput> {
  currentInstance: Writable<TInput | null>;
  reductionSteps: Writable<Step<TInput, TOutput>[]>;
  currentStepIndex: Writable<number>;

  constructor() {
    this.currentInstance = writable<TInput | null>(null);
    this.reductionSteps = writable<Step<TInput, TOutput>[]>([]);
    this.currentStepIndex = writable(0);
  }

  setInstance(instance: TInput) {
    this.currentInstance.set(instance);
  }

  setSteps(steps: Step<TInput, TOutput>[]) {
    this.reductionSteps.set(steps);
    this.currentStepIndex.set(0);
  }

  reset() {
    this.currentInstance.set(null);
    this.reductionSteps.set([]);
    this.currentStepIndex.set(0);
  }

  nextStep() {
    this.currentStepIndex.update(i => i + 1);
  }

  prevStep() {
    this.currentStepIndex.update(i => Math.max(0, i - 1));
  }
}

// Store for each supported problem type
export const problemStates = writable({
  "3SAT-HCYCLE": new ReductionStore<CNF3Instance, GraphInstance>(),
  "3SAT-3DM": new ReductionStore<CNF3Instance, ThreeDMInstance>(),
  "HCYCLE-HCIRCUIT": new ReductionStore<GraphInstance, GraphInstance>(),
  "HCIRCUIT-TSP": new ReductionStore<GraphInstance, GraphInstance>(),
  "3SAT-SSP": new ReductionStore<CNF3Instance, SSPInstance>(),
});


// showing usage
function foo() {
  const store = get(problemStates)['3SAT-HCYCLE'];
  const cnf = store.currentInstance;
  if (!cnf)
    return;
  threeSatToHCycle(cnf)
}
