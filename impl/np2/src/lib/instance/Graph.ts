//
// Created by phatt-23 on 11/10/2025
//

import { ProblemInstance } from "./ProblemInstance";
import Serializer from "$lib/core/Serializer";
import { EDGE_ID_PREFIX, NODE_ID_PREFIX, type Id } from "$lib/core/Id";
import type { ErrorMessage } from "$lib/core/assert";
import { onlyUnique } from "$lib/core/filters";

export type Position = {
    x: number;
    y: number;
}

export type GraphEdge = {
    id: Id;
    from: Id;
    to: Id;
    weight?: number;
    classes?: string;
}

export type GraphNode = {
    id: Id;
    label?: string;
    position?: Position;
    classes?: string;
}

@Serializer.SerializableClass()
export class Graph extends ProblemInstance {
    public _nodes: Set<GraphNode>;
    public _edges: Set<GraphEdge>;

    public constructor() {
        super();
        this._nodes = new Set();
        this._edges = new Set();
    }

    public addNode(node: GraphNode) {
        if (node.classes == undefined) {
            node.classes = '';
        }

        // if there's a node with the same id, don't add it
        if (this.nodes.find(n => n.id == node.id)) 
            return;

        this._nodes.add(node);
    }
    public addEdge(edge: GraphEdge) {
        if (edge.classes == undefined) {
            edge.classes = '';
        }

        // if there's an edge with the same id, don't add it
        if (this.edges.find(e => e.id == edge.id)) 
            return;

        this._edges.add(edge);
    }

    public get nodes() : Array<GraphNode> {
        return Array.from(this._nodes.values());
    }
    public get edges() : Array<GraphEdge> {
        return Array.from(this._edges.values());
    }

    public removeNode(node: GraphNode) {
        if (!this._nodes.has(node)) return;
        this._nodes.delete(node);
        // remove edges incident to 'node'
        const edgesToRemove = Array.from(this.edges).filter(e => e.to === node.id || e.from === node.id);
        edgesToRemove.forEach(edge => this._edges.delete(edge));
    }
    public removeEdge(edge: GraphEdge) { this._edges.delete(edge);
    }
    public empty() : boolean {
        return this.nodes.length == 0; 
    }

    // why the FUUUUCK doesn't typescript have copying objects figured out tf
    public copy(): Graph {
        const newGraph = new Graph();

        // Deep copy nodes
        for (const node of this._nodes) {
            newGraph.addNode({
                id: node.id,
                label: node.label,
                position: node.position ? { ...node.position } : undefined,
                classes: node.classes,
            });
        }

        // Deep copy edges
        for (const edge of this._edges) {
            newGraph.addEdge({
                id: edge.id,
                from: edge.from,
                to: edge.to,
                weight: edge.weight,
                classes: edge.classes,
            });
        }

        return newGraph;
    }

    public asString() : string {
        const nodeLines = this.nodes.map(n => n.id.slice(NODE_ID_PREFIX.length)).join('\n');
        const edgeLines = this.edges.map(e => e.from.slice(NODE_ID_PREFIX.length) + ' ' + e.to.slice(NODE_ID_PREFIX.length) + (e.weight != undefined ? ' ' + e.weight : '')).join('\n');
        return nodeLines + '\n' + edgeLines + '\n';
    }

    public static fromString(text: string): Graph | ErrorMessage {
        if (text.length == 0)
            return "Cannot construct a graph from empty string";

        const lines = text.split('\n').map(x => x.trim()).filter(x => x.length).filter(onlyUnique);
        let graph = new Graph();

        console.debug("LINES", lines);

        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];

            const words = line.split(" ").map(w => w.trim()).filter(w => w.length);
            
            // single node
            if (words.length == 1) {
                const n = words;
                graph.addNode({
                    id: NODE_ID_PREFIX + n,
                });
            }

            // edge between n1 and n2 (optinal weight)
            else if (words.length <= 3) {
                const n1 = words[0];
                const n2 = words[1];

                let w = undefined;
                if (words.length == 3) {
                    try {
                        w = Number.parseFloat(words[2]);
                    } catch (e) {
                        return `On the line ${i}, couldn't parse the weight: '${words[2]}` +
                            `Please enter a number (floating allowed)`;
                    }
                }

                graph.addNode({
                    id: NODE_ID_PREFIX + n1,
                });

                graph.addNode({
                    id: NODE_ID_PREFIX + n2,
                });

                graph.addEdge({
                    id: EDGE_ID_PREFIX + `${n1}-${n2}`,
                    from: NODE_ID_PREFIX + n1,
                    to: NODE_ID_PREFIX + n2,
                    weight: w,
                });
            }
        }

        return graph;
    }


    /**
     * When using workers, these are the methods that serialize and desearialize the Graph
     * The Serializer class cannot be used. Worker has a different context to the main thread
     * and the classes are not registered.
     */

     public toSerializedString(pretty = false): string {
        const data = {
            nodes: this.nodes.map(n => ({
                id: n.id,
                label: n.label ?? null,
                position: n.position ?? null,
                classes: n.classes ?? '',
            })),
            edges: this.edges.map(e => ({
                id: e.id,
                from: e.from,
                to: e.to,
                weight: e.weight ?? null,
                classes: e.classes ?? '',
            })),
        };
        return JSON.stringify(data, null, pretty ? 2 : 0);
    }

    public static fromSerializedString(serialized: string): Graph {
        const data = JSON.parse(serialized);
        const graph = new Graph();

        if (Array.isArray(data.nodes)) {
            for (const node of data.nodes) {
                graph.addNode({
                    id: node.id,
                    label: node.label ?? undefined,
                    position: node.position ?? undefined,
                    classes: node.classes ?? '',
                });
            }
        }

        if (Array.isArray(data.edges)) {
            for (const edge of data.edges) {
                graph.addEdge({
                    id: edge.id,
                    from: edge.from,
                    to: edge.to,
                    weight: edge.weight ?? undefined,
                    classes: edge.classes ?? '',
                });
            }
        }

        return graph;
    }
}
