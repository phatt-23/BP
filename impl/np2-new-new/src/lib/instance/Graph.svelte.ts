//
// Created by phatt-23 on 11/10/2025
//

import "reflect-metadata";
import { ProblemInstance } from "./ProblemInstance";
import { Serializer } from "$lib/core/Serializer";
import type { Id } from "$lib/core/Id";

type Position = {
    x: number;
    y: number;
}

export type GraphEdge = {
    id: Id;
    from: Id;
    to: Id;
    weight?: number;
}

export type GraphNode = {
    id: Id;
    label?: string;
    position?: Position;
}

@Serializer.SerializableClass()
export class Graph extends ProblemInstance {
    private _nodes: Set<GraphNode>;
    private _edges: Set<GraphEdge>;

    public constructor() {
        super();
        this._nodes = new Set();
        this._edges = new Set();
    }

    public addNode(node: GraphNode) {
        this._nodes.add(node);
    }
    public addEdge(edge: GraphEdge) {
        this._edges.add(edge);
    }

    public removeNode(node: GraphNode) {
        if (!this._nodes.has(node)) return;
        this._nodes.delete(node);
        // remove edges incident to 'node'
        const edgesToRemove = Array.from(this._edges).filter(e => e.to === node.id || e.from === node.id);
        edgesToRemove.forEach(edge => this._edges.delete(edge));
    }
    public removeEdge(edge: GraphEdge) { this._edges.delete(edge);
    }

    public get nodes(): Array<GraphNode> {
        return Array.from(this._nodes.values());
    }
    public get edges(): Array<GraphEdge> {
        return Array.from(this._edges.values());
    }
}
