// Created by phatt-23 on 21/10/2025

import { EDGE_ID_PREFIX, NODE_ID_PREFIX, type Id } from "$lib/core/Id";
import { Graph } from "$lib/instance/Graph";
import type { Reducer } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class ReducerHCIRCUITtoTSP implements Reducer<Graph, Graph> {
    inInstance: Graph;
    nodeCount: number;

    constructor(inInstance: Graph) {
        this.inInstance = inInstance;

        this.nodeCount = this.inInstance.nodes.length;
    }

    reduce(): { outInstance: Graph; steps: ReductionStep<Graph, Graph>[]; } {
        const graph = new Graph();
        const steps: ReductionStep<Graph, Graph>[] = [];

        const edgeIds = new Set<Id>(this.inInstance.edges.map(e => e.id));

        const nodeNames = this.inInstance.nodes.map(n => {
            graph.addNode(n);
            const nodeName = n.id.slice(NODE_ID_PREFIX.length);
            return nodeName;
        });

        console.debug('edgeIds:', edgeIds);

        for (let i = 0; i < this.nodeCount; i++) {
            for (let j = i + 1; j < this.nodeCount; j++) {
                const ni = nodeNames[i];
                const nj = nodeNames[j];

                const edgeId = EDGE_ID_PREFIX + `${ni}-${nj}`;
                const edgeExists = edgeIds.has(edgeId);

                graph.addEdge({
                    id: edgeId,
                    from: NODE_ID_PREFIX + ni,
                    to: NODE_ID_PREFIX + nj,
                    weight: edgeExists ? 1 : 2,
                    classes: edgeExists ? 'solid' : 'muted',
                });
            }
        }

        steps.push({
            id: `reduce-hcircuit-to-tsp-1`,
            title: `Create complete graph`,
            description: `
                <p> 
                    Take all of the nodes from the original graph and add an edge between each of them (make a complete graph).
                    For every edge that exists in the original instance, assign a weight of 1.
                    Otherwise assign some weight larger than 1.
                </p>
                <p>
                    There is ${this.nodeCount} nodes, 
                    which means there will be (${this.nodeCount} * ${this.nodeCount - 1}) / 2 = ${(this.nodeCount * (this.nodeCount - 1)) / 2} edges, 
                    for it to be complete.
                </p>
                <p>
                    Now this problem can expressed by a decision question:
                    Is there a hamiltonian cycle such that the cost of the traversal is less than or equal to ${this.nodeCount}?
                </p>
            `,
            inSnapshot: this.inInstance.copy(),
            outSnapshot: graph.copy(),
            mapping: {},
        });

        return {
            outInstance: graph,
            steps,
        }

    }

}