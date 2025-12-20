// Created by phatt-23 on 20/12/2025

import { CG3_ID, cutNodeIdPrefix, EDGE_ID_PREFIX, NODE_ID_PREFIX, NODE_ID_PREFIX_FALSE, NODE_ID_PREFIX_TRUE } from "$lib/core/Id";
import type { CNF3 } from "$lib/instance/CNF3";
import { Graph, type GraphEdge, type GraphNode } from "$lib/instance/Graph";
import { Reducer, type ReductionResult } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class Reducer3SATto3CG extends Reducer<CNF3, Graph> {

    constructor(i: CNF3) {
        super(i);
    }

    protected doReduce(): ReductionResult<CNF3, Graph> {
        const graph = new Graph();
        const steps: ReductionStep<CNF3,Graph>[] = [];

        // add core nodes and join them together
        const coreNodes: Record<string, GraphNode> = {
            T: {
                id: CG3_ID.CORE.T,
                label: 'T',
                classes: 'T',
            },
            F: {
                id: CG3_ID.CORE.F,
                label: 'F',
                classes: 'F',
            },
            B: {
                id: CG3_ID.CORE.B,
                label: 'B',
                classes: 'B',
            },
        };
        const coreNodeValues = Object.values(coreNodes);

        coreNodeValues.forEach(n => graph.addNode(n));

        for (let i = 0; i < coreNodeValues.length; i++) {
            for (let j = i + 1; j < coreNodeValues.length; j++) {
                const from = coreNodeValues[i].label;
                const to = coreNodeValues[j].label;
                const edge: GraphEdge = {
                    id: EDGE_ID_PREFIX + `${from}-${to}`,
                    from: NODE_ID_PREFIX + from,
                    to: NODE_ID_PREFIX + to,
                };
                graph.addEdge(edge);
            }
        }

        // add variable nodes
        this.inInstance.variables.forEach(v => {
            const trueNode: GraphNode = {
                id: NODE_ID_PREFIX_TRUE + v,
            };

            const falseNode: GraphNode = {
                id: NODE_ID_PREFIX_FALSE + v,
            };

            graph.addNode(trueNode);
            graph.addNode(falseNode);

            const edges: GraphEdge[] = [
                {
                    id: EDGE_ID_PREFIX + v + 'true-false',
                    from: trueNode.id,
                    to: falseNode.id,
                },
                {
                    id: EDGE_ID_PREFIX + v + 'true-B',
                    from: trueNode.id,
                    to: CG3_ID.CORE.B,
                },
                {
                    id: EDGE_ID_PREFIX + v + 'false-B',
                    from: falseNode.id,
                    to: CG3_ID.CORE.B,
                },
            ];

            edges.forEach(e => graph.addEdge(e));
        });

        // add clause nodes
        this.inInstance.clauses.forEach(c => {
            const nodes: GraphNode[] = [];
            const edges: GraphEdge[] = [];

            // add the six
            for (let i = 0; i < 6; i++) {
                const label = c.id + '-' + i;

                nodes.push({
                    id: CG3_ID.CLAUSE_NODE_PREFIX + label,
                    label: label,
                });
            }

            const connections = [
                [0,3], [1,4], [2,5], 
                [coreNodes.T, 0], [coreNodes.T, 1], [coreNodes.T, 2],
                [coreNodes.T, 3], [3,4], [4,5], [5,coreNodes.F]
            ];

            connections.forEach(c => {
                const from = (typeof(c[0]) == "number") ? nodes[c[0]] : c[0];
                const to = (typeof(c[1]) == "number") ? nodes[c[1]] : c[1];

                edges.push({
                    id: EDGE_ID_PREFIX + `${from.label}-${to.label}`,
                    from: from.id,
                    to: to.id,
                });
            });

            c.literals.forEach((v, i) => {
                const varNode: string = (v.negated ? NODE_ID_PREFIX_FALSE : NODE_ID_PREFIX_TRUE) + v.varName;
                const node: GraphNode = nodes[i];
                
                edges.push({
                    id: EDGE_ID_PREFIX + `${varNode}-${node.label}`,
                    from: varNode,
                    to: node.id,
                });
            });

            nodes.forEach(n => graph.addNode(n));
            edges.forEach(e => graph.addEdge(e));
        });

        return {
            outInstance: graph, 
            steps: steps,
        };
    }

}
