//
// Created by phatt-23 on 11/10/2025
//

import type { CNF3 } from "$lib/instance/CNF3.svelte";
import { Graph, type GraphNode } from "$lib/instance/Graph.svelte";
import type { Reducer } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class Reducer3SATtoHCYCLE implements Reducer<CNF3, Graph> {
    inInstance: CNF3;

    public constructor(inInstance: CNF3) {
        this.inInstance = inInstance;
    }

    public setInstance(ins: CNF3) {
        this.inInstance = ins;
    }

    reduce(): { outInstance: Graph, steps: ReductionStep<CNF3, Graph>[] } {
        // this.inInstance.clauses
        
        let graph = new Graph();

        for (let i = 0; i < this.inInstance.variables.size; i++) {
            const node: GraphNode = {
                id: `n:${i}`,
                label: `node ${i}`,
                position: {
                    x: i * 10,
                    y: 10,
                }
            }

            graph.addNode(node);            
        }

        return {
            outInstance: graph,
            steps: [],
        }
    }
}