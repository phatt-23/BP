// phatt 2025-10-06

export interface Position {
    x: number;
    y: number;
}

export interface Node {
    id: string;
    label?: string;
    position?: Position;
}

export interface Edge {
    id: string;
    from: string;
    to: string;
    weight?: string;
}

export interface GraphInstance {
    id: string;
    nodes: Node[];
    edges: Edge[];
    directed: boolean;
    weighted?: boolean;
}