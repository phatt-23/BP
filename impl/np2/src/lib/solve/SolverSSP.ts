// Created by phatt-23 on 22/10/2025

import type { SSP } from "$lib/instance/SSP";
import type { Solver } from "./Solver";
import type { CertificateSSP } from "./CertificateSSP";
import type { Unsolvable } from "$lib/core/Unsolvable";

export class SolverSSP implements Solver<SSP, CertificateSSP> {
    instance: SSP;

    constructor(instance: SSP) {
        this.instance = instance;
    }

    solve(): CertificateSSP | Unsolvable {
        throw new Error("Method not implemented.");
    }
}