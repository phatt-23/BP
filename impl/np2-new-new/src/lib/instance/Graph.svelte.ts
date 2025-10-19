//
// Created by phatt-23 on 11/10/2025
//

import { ProblemInstance } from "./ProblemInstance";
import Serializer from "$lib/core/Serializer";
import type { Id } from "$lib/core/Id";

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
        this._nodes.add(node);
    }
    public addEdge(edge: GraphEdge) {
        if (edge.classes == undefined) {
            edge.classes = '';
        }
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
        return this.nodes.length == 0 || this.edges.length == 0;
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
}
