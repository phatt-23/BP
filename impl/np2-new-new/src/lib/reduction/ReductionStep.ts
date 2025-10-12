//
// Created by phatt-23 on 11/10/2025
//

import type { ProblemInstance } from "$lib/instance/ProblemInstance";

export interface ReductionStep<I extends ProblemInstance, O extends ProblemInstance> {
    id: string;
    title: string;
    description: string;  // html allowed
    inSnapshot?: I;
    outStapshot?: O;  
    // mapping: Record<string, string[]>;  
    mapping: Map<string, string[]>;  // I element id -> O element ids (shows correspondence between I element and O elements)
}