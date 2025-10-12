//
// Created by phatt-23 on 11/10/2025
//

import type { CNF3 } from "$lib/instance/CNF3.svelte";
import type { Graph } from "$lib/instance/Graph.svelte";
import type { Reducer } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class Reducer3SATtoHCYCLE implements Reducer<CNF3, Graph> {
    inInstance: CNF3 | null;

    public constructor() {
        this.inInstance = null;
    }

    public setInstance(ins: CNF3) {
        this.inInstance = ins;
    }

    reduce(): [Graph, ReductionStep<CNF3, Graph>[]] {
        throw new Error("Method not implemented.");
    }
}