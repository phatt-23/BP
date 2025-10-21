// Created by phatt-23 on 21/10/2025

import type { Graph } from "$lib/instance/Graph";
import type { CertificateTSP } from "./CertificateTSP";
import type { Solver } from "./Solver";

export class SolverTSP implements Solver<Graph, CertificateTSP> {
    instance: Graph;

    constructor(instance: Graph) {
        this.instance = instance;
    }

    solve(): CertificateTSP | "unsolvable" {
        throw new Error("Method not implemented.");
    }
}