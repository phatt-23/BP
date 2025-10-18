//
// Created by phatt-23 on 11/10/2025
//

import type { CNF3 } from "$lib/instance/CNF3.svelte";
import { Graph, type GraphNode } from "$lib/instance/Graph.svelte";
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

        steps.push({
            id: `step:1`,
            title: `Create variable gadgets`,
            description: `For every variable create a gadget corresponding to a boolean assignment.`,
            inSnapshot: this.inInstance,
            outSnapshot: step1.graph.copy(),
            mapping: {},
            interSteps: step1.interSteps,
        });

        const step2 = this.createClauseGadgets(step1.graph);

        steps.push({
            id: `step:2`,
            title: `Create clause gadgets`,
            description: `For every clause, create a node and connect it to variable rows.`,
            inSnapshot: this.inInstance,
            outSnapshot: step2.graph.copy(),
            mapping: {},
            interSteps: step2.interSteps,
        });

        return {
            outInstance: step2.graph,
            steps,
        }
    }


    private createClauseGadgets(graph: Graph): { graph: Graph, interSteps: ReductionStep<CNF3, Graph>[] } {
        const { variables, clauses } = this.inInstance;
        let interSteps: ReductionStep<CNF3, Graph>[] = [];

        clauses.forEach((c,i) => {
            const idx = i + 1;
            const clauseId = `%c_${idx}`;
            graph.addNode({
                id: `n:${clauseId}`,
                position: {
                    x: 2 * this.rowXOffset,
                    y: i * this.yStep + this.yOffset,
                },
                classes: 'clause'
            });

            c.literals.forEach((l,j) => {
                const litId = `${l.varName}_${3 * idx}`;
                const adjLitId = `${l.varName}_${3 * idx + 1}`;

                if (!l.negated) {
                    graph.addEdge({
                        id: `e:${litId}-${clauseId}`,
                        from: `n:${litId}`,
                        to: `n:${clauseId}`,
                    });

                    graph.addEdge({
                        id: `e:${clauseId}-${adjLitId}`,
                        from: `n:${clauseId}`,
                        to: `n:${adjLitId}`,
                    });
                } else {
                    graph.addEdge({
                        id: `e:${adjLitId}-${clauseId}`,
                        from: `n:${adjLitId}`,
                        to: `n:${clauseId}`,
                    });

                    graph.addEdge({
                        id: `e:${clauseId}-${litId}`,
                        from: `n:${clauseId}`,
                        to: `n:${litId}`,
                    });
                }
            })

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
        const { variables, clauses } = this.inInstance;
        let graph = new Graph();
        let interSteps: ReductionStep<CNF3, Graph>[] = [];


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
                const sourceNode = "%source";
                graph.addNode({ 
                    id: `n:${sourceNode}`, 
                    position: { 
                        x: 0, 
                        y: i * this.yDist - this.yDist/2 
                    },
                    classes: 'source'
                }); 
                /**
                 * Add edges from source to row ends of this first variable.
                 */
                graph.addEdge({ id: `e:${sourceNode}-${v}_1`, from: `n:${sourceNode}`, to: `n:${v}_1` });
                graph.addEdge({ id: `e:${sourceNode}-${v}_${this.rowNodeCount}`, from: `n:${sourceNode}`, to: `n:${v}_${this.rowNodeCount}` });

            } else {
                /**
                 * For other variables, there is layer above it 
                 * that needs to be wired to the inbetween node.
                 */
                const inbetweenNode = `%${variables[i - 1]}_${v}`;

                /**
                 * Add the inbetween node.
                 */
                graph.addNode({ 
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
                graph.addEdge({ 
                    id: `e:${prevVar}_1-${inbetweenNode}`, 
                    from: `n:${prevVar}_1`, 
                    to: `n:${inbetweenNode}` 
                });
                graph.addEdge({ 
                    id: `e:${prevVar}_${this.rowNodeCount}-${inbetweenNode}`, 
                    from: `n:${prevVar}_${this.rowNodeCount}`, 
                    to: `n:${inbetweenNode}` 
                });

                /** 
                 * Connect this inbetween node to current variable's row ends.
                 */ 
                graph.addEdge({ 
                    id: `e:${inbetweenNode}-${v}_1`, 
                    from: `n:${inbetweenNode}`,
                    to: `n:${v}_1`, 
                });
                graph.addEdge({ 
                    id: `e:${inbetweenNode}-${v}_${this.rowNodeCount}`, 
                    from: `n:${inbetweenNode}`,
                    to: `n:${v}_${this.rowNodeCount}`, 
                });
            }

            /**
             * Create row nodes and connect them bidirectionally.
             */
            for (let j = 1; j <= this.rowNodeCount - 1; j++) {
                const current = `${v}_${j}`;
                const next = `${v}_${j + 1}`;

                // first
                const classes = (j == 1) ? 'true' : '';

                graph.addNode({ 
                    id: `n:${current}`, 
                    position: { 
                        x: (j - 1) * this.xDist - this.rowXOffset,
                        y: i * this.yDist 
                    },
                    classes: classes,
                }); 

                // last
                if (j == this.rowNodeCount - 1) {
                    graph.addNode({ 
                        id: `n:${next}`, 
                        position: { 
                            x: j * this.xDist - this.rowXOffset,
                            y: i * this.yDist 
                        },
                        classes: 'false' 
                    }); 
                }

                graph.addEdge({
                    id: `e:${current}-{next}`,
                    from: `n:${current}`,
                    to: `n:${next}`,
                });
                graph.addEdge({
                    id: `e:${next}-{current}`,
                    from: `n:${next}`,
                    to: `n:${current}`,
                });
            }

            /**
             * The last iteration.
             */ 
            if (i == variables.length - 1) {
                /**
                 * Add the target node.
                 */
                const targetName = "%target";
                graph.addNode({ 
                    id: `n:${targetName}`, 
                    position: { 
                        x: 0, 
                        y: i * this.yDist + this.yDist/2
                    } 
                }); 

                /**
                 * Connect the row ends to the target.
                 */
                graph.addEdge({ 
                    id: `e:${v}_1-${targetName}`,
                    from: `n:${v}_1`,
                    to: `n:${targetName}`,
                })
                graph.addEdge({ 
                    id: `e:${v}_${this.rowNodeCount}-${targetName}`,
                    from: `n:${v}_${this.rowNodeCount}`,
                    to: `n:${targetName}`,
                })
            }  

            function onlyif(cond: unknown, value: string, otherwise?: string): string {
                return cond ? value : (otherwise ?? '');
            }
            
        });

        return { 
            graph,
            interSteps,
        };
    }
}