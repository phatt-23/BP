// Created by phatt-23 on 21/10/2025

import type { GraphNode } from "$lib/instance/Graph";
import type { Certificate } from "./Certificate";

export class CertificateTSP implements Certificate {
    path: GraphNode[]

    constructor(path: GraphNode[]) {
        this.path = path;
    }
}