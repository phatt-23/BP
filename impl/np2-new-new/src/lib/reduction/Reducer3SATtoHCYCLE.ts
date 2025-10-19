//
// Created by phatt-23 on 11/10/2025
//

import type { CNF3 } from "$lib/instance/CNF3.svelte";
import { Graph, type GraphEdge, type GraphNode } from "$lib/instance/Graph.svelte";
import type { Reducer } from "./Reducer";
import type { ReductionStep } from "./ReductionStep";

export class Reducer3SATtoHCYCLE implements Reducer<CNF3, Graph> {
    inInstance: CNF3;

    private rowNodeCount: number;
    private rowXOffset: number;
    private varCount: number;
    private clauseCount: number;
    private height: number;
    private yStep: number;
    private yOffset: number;
    private xDist = 50;
    private yDist = 300;

    public constructor(inInstance: CNF3) {
        this.inInstance = inInstance;
        const { variables, clauses } = this.inInstance;

        this.yOffset = this.yDist / 2;

        this.varCount = variables.length;
        this.clauseCount = clauses.length;

        this.height = (this.varCount - 1) * this.yDist;
        this.yStep = (this.height - this.yDist) / (this.clauseCount - 1 == 0 ? 1 : this.clauseCount - 1); 

        this.rowNodeCount = 3 * clauses.length + 3;
        this.rowXOffset = (this.rowNodeCount - 1)/2 * this.xDist;

    }

    reduce(): { outInstance: Graph, steps: ReductionStep<CNF3, Graph>[] } {
        let steps : ReductionStep<CNF3, Graph>[] = [];

        const step1 = this.createVarGadgets();

        steps.push(...step1.interSteps);

        const step2 = this.createClauseGadgets(step1.graph.copy());

        steps.push({
            id: `step:2`,
            title: `Create clause gadgets`,
            description: `For every clause, create a node and connect it to variable rows.`,
            inSnapshot: this.inInstance,
            outSnapshot: step1.graph.copy(),
            mapping: {},
            interSteps: step2.interSteps,
        });

        steps.push(...step2.interSteps);

        return {
            outInstance: step2.graph,
            steps,
        }
    }


    private createClauseGadgets(graph: Graph): { graph: Graph, interSteps: ReductionStep<CNF3, Graph>[] } {
        const { clauses } = this.inInstance;
        let interSteps: ReductionStep<CNF3, Graph>[] = [];

        /**
         * For each clause, create a node 
         * and based on literals it contains, 
         * connect it to variable row nodes
         * form either 'true' direction 
         * or 'false' direction. 
         */
        clauses.forEach((c,i) => {
            const idx = i + 1;
            const clauseId = `%c_${idx}`;

            // Create clause node
            graph.addNode({
                id: `n:${clauseId}`,
                position: {
                    x: 2 * this.rowXOffset,
                    y: i * this.yStep + this.yOffset,
                },
                classes: 'clause'
            });

            // For its literals.
            c.literals.forEach((l,j) => {
                const litId = `${l.varName}_${3 * idx}`;
                const adjLitId = `${l.varName}_${3 * idx + 1}`;

                // If its positive literal,
                // add an edge from the true side to the clause node
                // and from the clause node back to the next row node.
                if (!l.negated) {
                    graph.addEdge({
                        id: `e:${litId}-${clauseId}`,
                        from: `n:${litId}`,
                        to: `n:${clauseId}`,
                        classes: 'true_out',
                    });

                    graph.addEdge({
                        id: `e:${clauseId}-${adjLitId}`,
                        from: `n:${clauseId}`,
                        to: `n:${adjLitId}`,
                        classes: 'true_in',
                    });
                } else {
                    graph.addEdge({
                        id: `e:${adjLitId}-${clauseId}`,
                        from: `n:${adjLitId}`,
                        to: `n:${clauseId}`,
                        classes: 'false_out',
                    });

                    graph.addEdge({
                        id: `e:${clauseId}-${litId}`,
                        from: `n:${clauseId}`,
                        to: `n:${litId}`,
                        classes: 'false_in',
                    });
                }
            });

            interSteps.push({
                id: `clause-gadget-${i}`,
                title: `Clause ${i}`,
                description: `Connect the clause node ${clauseId} to it's literals: ${c.asString()}.`,
                inSnapshot: this.inInstance,
                outSnapshot: graph.copy(),
                mapping: {},
            });
        });

        return {
            graph,
            interSteps,
        }
    }


    private createVarGadgets(): { graph: Graph, interSteps: ReductionStep<CNF3, Graph>[] } {
        /**
         * Let k = number of clauses.
         */
        const { variables } = this.inInstance;


        /**
         * I want to show these steps:
         *     1. Create individual variable gadgets - only the row nodes.
         *     2. Create the source, inbetween and target nodes and connect the row ends.
         */


        let firstGraph = new Graph();
        let secondGraph = new Graph();

        let interSteps: ReductionStep<CNF3, Graph>[] = [];

        const sourceName = "%source";
        const targetName = "%target";

        /**
         * For every variable create a varible gadget
         * with 3k + 3 row nodes and connect them up.
         */
        variables.forEach((v, i) => {
            if (i == 0) {
                /**
                 * For the first variable, there is no other 
                 * layer above it, add the source node.
                 */
                secondGraph.addNode({ 
                    id: `n:${sourceName}`, 
                    position: { 
                        x: 0, 
                        y: i * this.yDist - this.yDist/2 
                    },
                    classes: 'source'
                }); 
                /**
                 * Add edges from source to row ends of this first variable.
                 */
                secondGraph.addEdge({ 
                    id: `e:${sourceName}-${v}_1`, 
                    from: `n:${sourceName}`, 
                    to: `n:${v}_1`, 
                    classes: 'muted',
                });
                secondGraph.addEdge({ 
                    id: `e:${sourceName}-${v}_${this.rowNodeCount}`, 
                    from: `n:${sourceName}`, 
                    to: `n:${v}_${this.rowNodeCount}`,
                    classes: 'muted',
                });

            } else {
                /**
                 * For other variables, there is layer above it 
                 * that needs to be wired to the inbetween node.
                 */
                const inbetweenNode = `%${variables[i - 1]}_${v}`;

                /**
                 * Add the inbetween node.
                 */
                secondGraph.addNode({ 
                    id: `n:${inbetweenNode}`, 
                    position: { 
                        x: 0, 
                        y: i * this.yDist - this.yDist/2 
                    },
                    classes: 'inbetween'
                }); 

                /**
                 * Connect above gadget's row ends into this inbetween node.
                 */ 
                const prevVar = variables[i - 1];
                secondGraph.addEdge({ 
                    id: `e:${prevVar}_1-${inbetweenNode}`, 
                    from: `n:${prevVar}_1`, 
                    to: `n:${inbetweenNode}`,
                    classes: 'muted'
                });
                secondGraph.addEdge({ 
                    id: `e:${prevVar}_${this.rowNodeCount}-${inbetweenNode}`, 
                    from: `n:${prevVar}_${this.rowNodeCount}`, 
                    to: `n:${inbetweenNode}`,
                    classes: 'muted'
                });

                /** 
                 * Connect this inbetween node to current variable's row ends.
                 */ 
                secondGraph.addEdge({ 
                    id: `e:${inbetweenNode}-${v}_1`, 
                    from: `n:${inbetweenNode}`,
                    to: `n:${v}_1`, 
                    classes: 'muted'
                });
                secondGraph.addEdge({ 
                    id: `e:${inbetweenNode}-${v}_${this.rowNodeCount}`, 
                    from: `n:${inbetweenNode}`,
                    to: `n:${v}_${this.rowNodeCount}`, 
                    classes: 'muted'
                });
            }

            /**
             * Create row nodes and connect them bidirectionally.
             */
            for (let j = 1; j <= this.rowNodeCount - 1; j++) {
                const current = `${v}_${j}`;
                const next = `${v}_${j + 1}`;

                let classes = ''; 

                // first is 'true'
                if (j == 1) {
                    classes += 'true ';
                }
                else if ((j + 1) % 3 == 0) {
                    classes += 'guarantee ';
                }

                const node: GraphNode = { 
                    id: `n:${current}`, 
                    position: { 
                        x: (j - 1) * this.xDist - this.rowXOffset,
                        y: i * this.yDist 
                    },
                    classes: classes,
                };

                firstGraph.addNode(node);
                secondGraph.addNode(node); 

                // last is 'false'
                if (j == this.rowNodeCount - 1) {
                    const node : GraphNode = { 
                        id: `n:${next}`, 
                        position: { 
                            x: j * this.xDist - this.rowXOffset,
                            y: i * this.yDist 
                        },
                        classes: 'false' 
                    }
                    firstGraph.addNode(node); 
                    secondGraph.addNode(node); 
                }

                const edge1 : GraphEdge = {
                    id: `e:${current}-${next}`,
                    from: `n:${current}`,
                    to: `n:${next}`,
                    classes: 'muted'
                }

                const edge2 : GraphEdge = {
                    id: `e:${next}-${current}`,
                    from: `n:${next}`,
                    to: `n:${current}`,
                    classes: 'muted'
                }
                firstGraph.addEdge(edge1);
                firstGraph.addEdge(edge2);
                secondGraph.addEdge(edge1);
                secondGraph.addEdge(edge2);
            }

            /**
             * The last iteration.
             */ 
            if (i == variables.length - 1) {
                /**
                 * Add the target node.
                 */
                secondGraph.addNode({ 
                    id: `n:${targetName}`, 
                    position: { 
                        x: 0, 
                        y: i * this.yDist + this.yDist/2
                    },
                    classes: 'target',
                }); 

                /**
                 * Connect the row ends to the target.
                 */
                secondGraph.addEdge({ 
                    id: `e:${v}_1-${targetName}`,
                    from: `n:${v}_1`,
                    to: `n:${targetName}`,
                    classes: 'muted',
                });
                secondGraph.addEdge({ 
                    id: `e:${v}_${this.rowNodeCount}-${targetName}`,
                    from: `n:${v}_${this.rowNodeCount}`,
                    to: `n:${targetName}`,
                    classes: 'muted',
                });


                /**
                 * Connect the target node to source node to close the loop.
                 */
                secondGraph.addEdge({
                    id: `e:${targetName}-${sourceName}`,
                    from: `n:${targetName}`,
                    to: `n:${sourceName}`,
                    classes: 'muted',
                })

            }  
        });

        interSteps.push({
            id: `create-variable-gadgets`,
            title: `Create individual variable gadgets`,
            description: `
                <p>
                    For every variable, create a row variable gadget.
                </p>
                <p>
                    This gadget consists of ${this.rowNodeCount} row nodes.
                    They are all connected birectinally.
                </p>
                <p>
                    The number of row nodes it derived as follows: 
                </p>
                <p>
                    For every clause we need 2 nodes - an <i>out-going</i> and <i>in-coming</i> node.
                    Each of these 2 nodes must be padded a <i>pad</i> node (at least one).
                    The rows themselves also need <i>true</i> and and <i>false</i> ends.
                </p>
                <p>
                    There are ${this.clauseCount} clauses. 
                    Therefore we need: 
                    <ul>
                        <li>2 * ${this.clauseCount} out-going and in-coming nodes</li>
                        <li>${this.clauseCount} + 1 pad nodes</li>
                        <li>1 true and 1 false nodes at the row ends</li>
                    </ul>
                </p>
                <p>
                    (2 * ${this.clauseCount}) + (${this.clauseCount} + 1) + 1 + 1 = ${this.rowNodeCount} nodes.
                </p>
            `,
            inSnapshot: this.inInstance,
            outSnapshot: firstGraph,
            mapping: {}
        });

        interSteps.push({
            id: `create-inbetween-nodes`,
            title: `Create inbetween nodes`,
            description: `
                <p>
                    Then create the source node, the inbetween nodes that lie
                    between the variable rows and target node. 
                </p>
                <p>
                    Connect the source node to the row ends of the first variable.
                    After that connect the row ends to the inbetween/target node below.
                    Connect the target node to source node to close the loop.
                </p>
                <p>
                    Going from the source or an inbetween node 
                    to the left means assigning 'true'
                    and going right means assigning 'false'
                    to the corresponding variable.
                </p>
                <p>
                    Notice that we can only choose either 'true' or 'false'.
                    Going back is impossible.
                </p>
                <p>
                    After choosing going through the right or left edge, 
                    for the final cycle to be Hamiltonian, 
                    we must visit the row nodes. 
                </p>
                <p>
                    If we chose the right edge, 
                    then we end up on the false node 
                    and have to traverse the row nodes from right to left.

                    If we chose the left edge, then we end up on the true node 
                    and have to traverse the row nodes from left to right.

                    And then the only choice is to continue to the inbetween/target node below.
                </p>
                <p>
                    At the end at the target node we must go back to source node.
                </p>
            `,
            inSnapshot: this.inInstance,
            outSnapshot: secondGraph,
            mapping: {}
        });

        return { 
            graph: secondGraph,
            interSteps,
        };
    }
}