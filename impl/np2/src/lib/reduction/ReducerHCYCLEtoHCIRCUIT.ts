// Created by phatt-23 on 21/10/2025

import { EDGE_ID_PREFIX, NODE_GAP_POSTFIX, NODE_ID_PREFIX, NODE_IN_POSTFIX, NODE_OUT_POSTFIX } from "$lib/core/Id";
import { Graph, type Position } from "$lib/instance/Graph";
import type { Reducer } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class ReducerHCYCLEtoHCIRCUIT implements Reducer<Graph, Graph> {
    inInstance: Graph;

    private nodeDist = 80;  // vzdalenost mezi vrcholy v trojici
    private tripletDist = 2 * 3 * this.nodeDist;  // vzdalenost mezi trojicemi vrcholu
    private nodeCount: number;
    private circum: number;
    private radius: number;
    private radStep: number;
    private startRot: number;

    constructor(instance: Graph) {
        if (instance.empty()) {
            throw new Error("Reducer doesn't accept empty graphs (Graph with node nodes).");
        }

        this.inInstance = instance;

        this.nodeCount = instance.nodes.length; 

        // obvod kruhu: o = 2 * pi * r
        // r = o / (2 * pi)
        this.circum = this.tripletDist * this.nodeCount;
        
        // radius
        this.radius = this.circum / (2 * Math.PI);

        // step in radians
        this.radStep = (2 * Math.PI) / this.nodeCount;

        // in radians
        this.startRot = 0.5 * Math.PI;  
    }

    reduce(): { outInstance: Graph; steps: ReductionStep<Graph, Graph>[]; } {
        const steps: ReductionStep<Graph, Graph>[] = [];

        const step1 = this.createNodeTriplets();
        steps.push(...step1.steps);

        const step2 = this.connectEdges(step1.graph.copy());
        steps.push(...step2.steps);
        
        const outInstance = step2.graph;

        return { outInstance, steps };
    }

    private stripPrefix(x: string, prefix: string) : string {
        return x.slice(prefix.length);
    }

    private connectEdges(graph: Graph): { graph: Graph; steps: ReductionStep<Graph, Graph>[]; } {
        const steps: ReductionStep<Graph, Graph>[] = [];

        this.inInstance.edges.forEach(e => {
            const fromName = e.from.slice(NODE_ID_PREFIX.length) + NODE_OUT_POSTFIX;
            const toName = e.to.slice(NODE_ID_PREFIX.length) + NODE_IN_POSTFIX;

            graph.addEdge({
                id: EDGE_ID_PREFIX + `${fromName}-${toName}`,
                from: NODE_ID_PREFIX + fromName,
                to: NODE_ID_PREFIX + toName,
            });
        });

        steps.push({
            id: `connect-edges`,
            title: `Connect edges`,
            description: `
                <p> 
                    For every original edge from node <i>a</i> to node <i>b</i>,
                    connect the node <i>a_out</i> with the node <i>b_in</i>.
                </p>
                <p>
                    In this particular case, add these edges:
                    <ul>
                        ${this.inInstance.edges.map(e => {
                            const fromName = this.stripPrefix(e.from, EDGE_ID_PREFIX) + NODE_OUT_POSTFIX;
                            const toName = this.stripPrefix(e.to, EDGE_ID_PREFIX) + NODE_IN_POSTFIX;

                            return `
                                <li> 
                                    (${fromName}, ${toName})
                                </li>
                            `;
                        }).join('')}
                    </ul>
                </p>
            `,
            inSnapshot: this.inInstance.copy(),
            outSnapshot: graph.copy(),
            mapping: {},
        });

        return { graph, steps };
    }

    private createNodeTriplets(): { graph: Graph; steps: ReductionStep<Graph, Graph>[]; } {
        const steps: ReductionStep<Graph, Graph>[] = [];

        const graph = new Graph();

        this.inInstance.nodes.forEach((n,i) => {
            const nodeName = n.id.slice(NODE_ID_PREFIX.length);

            const inPos: Position = {
                x: this.radius * Math.cos(i * this.radStep - this.startRot - 0.2 * this.radStep),
                y: this.radius * Math.sin(i * this.radStep - this.startRot - 0.2 * this.radStep),
            }
            const gapPos: Position = {
                x: this.radius * Math.cos(i * this.radStep - this.startRot),
                y: this.radius * Math.sin(i * this.radStep - this.startRot),
            }
            const outPos: Position = {
                x: this.radius * Math.cos(i * this.radStep - this.startRot + 0.2 * this.radStep),
                y: this.radius * Math.sin(i * this.radStep - this.startRot + 0.2 * this.radStep),
            }
            
            graph.addNode({
                id: NODE_ID_PREFIX + nodeName + NODE_IN_POSTFIX,
                position: inPos,
                classes: n.classes
            });

            graph.addNode({
                id: NODE_ID_PREFIX + nodeName + NODE_GAP_POSTFIX,
                position: gapPos,
                classes: n.classes
            });

            graph.addNode({
                id: NODE_ID_PREFIX + nodeName + NODE_OUT_POSTFIX,
                position: outPos,
                classes: n.classes
            });

            // connect the in-coming and out-going nodes with the gap node
            graph.addEdge({
                id: EDGE_ID_PREFIX + `${nodeName}${NODE_IN_POSTFIX}-${nodeName}${NODE_GAP_POSTFIX}`,
                from: NODE_ID_PREFIX + nodeName + NODE_IN_POSTFIX,
                to: NODE_ID_PREFIX + nodeName + NODE_GAP_POSTFIX,
            });
            graph.addEdge({
                id: EDGE_ID_PREFIX + `${nodeName}${NODE_OUT_POSTFIX}-${nodeName}${NODE_GAP_POSTFIX}`,
                from: NODE_ID_PREFIX + nodeName + NODE_OUT_POSTFIX,
                to: NODE_ID_PREFIX + nodeName + NODE_GAP_POSTFIX,
            });
        });

        steps.push({
            id: `create-node-triplets`,
            title: `Create node triplets`,
            description: `
                <p> 
                    For each node in the original graph,
                    create three nodes that represent:
                    <ul>
                        <li>
                            an in-coming node
                        </li>
                        <li>
                            a gap node
                        </li>
                        <li>
                            and an out-going node
                        </li>
                    </ul>
                </p>
                <p>
                    Connect the in-coming node with the gap-node and the gap-node with the out-going node.
                </p>
                <p>
                    For this particular graph there will be ${this.nodeCount} node ${this.nodeCount == 1 ? 'triplet' : 'triplets'}.
                    ${this.nodeCount == 1 ? 'The triplet is:' : 'The triplets are:'}
                    <ul>  
                        ${this.inInstance.nodes.map(n => {
                            const nodeName = n.id.slice(NODE_ID_PREFIX.length);

                            return `
                                <li>
                                    ${nodeName} - (${nodeName + NODE_IN_POSTFIX}, ${nodeName + NODE_GAP_POSTFIX}, ${nodeName + NODE_OUT_POSTFIX})
                                </li>
                            `;
                        }).join('')}
                    </ul>
                </p>
            `,
            inSnapshot: this.inInstance.copy(),
            outSnapshot: graph.copy(),
            mapping: {},
        });

        return { graph, steps };
    }

}