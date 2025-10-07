// phatt 2025-10-06

export interface Triple {
    id: string;
    x: string;
    y: string;
    z: string;
}

export interface ThreeDMInstance {
    id: string;
    X: string[];
    Y: string[];
    Z: string[];
    triples: Triple[];
}
