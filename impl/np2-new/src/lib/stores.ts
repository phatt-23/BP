// phatt 2025-10-07

import { writable } from 'svelte/store';
import type { ProblemInstance } from './Models/Instances/ProblemInstance';
import type { Step } from './Models/Reductions/Step';
import type { CNF3Instance } from './Models/Instances/3-CNF';
import type { GraphInstance } from './Models/Instances/Graph';

// export const currentInstance = writable<ProblemInstance | null>(null);
// export const reductionSteps = writable<Step[] | null>(null);
// export const currentStepIndex = writable<number>(0);

export const currentInstance = writable<CNF3Instance | null>(null);
export const reductionSteps = writable<Step<CNF3Instance, GraphInstance>[]>([]);
export const currentStepIndex = writable<number>(0);
