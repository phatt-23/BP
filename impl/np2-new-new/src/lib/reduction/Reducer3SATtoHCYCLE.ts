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

            const rowNodeCount = 3 * clauses.length + 3;

            if (i == 0) {
                /**
                 * For the first variable, there is no other 
                 * layer above it, add the source node.
                 */
                const sourceNode = "source";
                graph.addNode({ id: `n:${sourceNode}`}); 
                /**
                 * Add edges from source to row ends of this first variable.
                 */
                graph.addEdge({ id: `e:${sourceNode}-${v}_1`, from: `n:${sourceNode}`, to: `n:${v}_1` });
                graph.addEdge({ id: `e:${sourceNode}-${v}_${rowNodeCount}`, from: `n:${sourceNode}`, to: `n:${v}_${rowNodeCount}` });
            } else {
                /**
                 * For other variables, there is layer above it 
                 * that needs to be wired to the inbetween node.
                 */
                const inbetweenNode = `${variables[i - 1]}_${v}`;

                /**
                 * Add the inbetween node.
                 */
                graph.addNode({ id: `n:${inbetweenNode}` }); 

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
                    id: `e:${prevVar}_${rowNodeCount}-${inbetweenNode}`, 
                    from: `n:${prevVar}_${rowNodeCount}`, 
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
                    id: `e:${inbetweenNode}-${v}_${rowNodeCount}`, 
                    from: `n:${inbetweenNode}`,
                    to: `n:${v}_${rowNodeCount}`, 
                });
            }

            /**
             * Create row nodes and connect them bidirectionally.
             */
            for (let j = 1; j <= rowNodeCount - 1; j++) {
                const current = `${v}_${j}`;
                const next = `${v}_${j + 1}`;

                graph.addNode({ id: `n:${current}` }); 

                if (j == rowNodeCount - 1) {
                    graph.addNode({ id: `n:${next}` }); 
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
                const targetName = "target";
                graph.addNode({ id: `n:${targetName}` }); 

                /**
                 * Connect the row ends to the target.
                 */
                graph.addEdge({ 
                    id: `e:${v}_1-${targetName}`,
                    from: `n:${v}_1`,
                    to: `n:${targetName}`,
                })
                graph.addEdge({ 
                    id: `e:${v}_${rowNodeCount}-${targetName}`,
                    from: `n:${v}_${rowNodeCount}`,
                    to: `n:${targetName}`,
                })
            }  

            function onlyif(cond: unknown, value: string, otherwise?: string): string {
                return cond ? value : (otherwise ?? '');
            }
            
            interSteps.push({
                id: `create-variable-gadget-${i}`,
                title: `Create variable gadget for ${v}`,
                description: 
                '<div>' + 
                    `<p>
                        Create row nodes, <b>${v}_i</b> for <b>1 < i < ${rowNodeCount}</b>, and connect them bidirectionally. 
                    </p>` +
                    onlyif(i == 0, '<p>Create <b>source</b> node.</p>') +
                    onlyif(i < variables.length - 1, 
                        `<p>Create bottom inbetween node <b>n:${v}-${variables[i + 1]}</b>`,
                        `<p>Create <b>target</b> node.</p>`
                    ) +
                    `<p>
                        Connect the row ends, <b>${v}_1</b> and <b>${v}_${rowNodeCount}</b>, to the ` + 
                        onlyif(i > 0, 
                            `top inbetween node <b>n:${variables[i - 1]}-${v}</b>`,
                            '<b>source</b> node'
                        ) + 
                        ' and ' +
                        onlyif(i < variables.length - 1, 
                            `bottom inbetween node <b>n:${v}-${variables[i + 1]}</b>`, 
                            '<b>target</b> node'
                        ) + '.' +
                    '</p>' + 
                '</div>',
                mapping: {},
            })
        });

        return { 
            graph,
            interSteps,
        };
    }

    reduce(): { outInstance: Graph, steps: ReductionStep<CNF3, Graph>[] } {
        let steps : ReductionStep<CNF3, Graph>[] = [];

        const { graph, interSteps } = this.createVarGadgets();

        steps.push({
            id: `step:1`,
            title: `Create variable gadgets`,
            description: `For every variable create a gadget corresponding to a boolean assignment.`,
            inSnapshot: this.inInstance,
            outStapshot: graph,
            mapping: {},
        });

        steps.push(...interSteps);

        return {
            outInstance: graph,
            steps,
        }
    }
}