// Created by phatt-23 on 20/12/2025

import type { TriBool } from "$lib/core/TriBool";
import type { VarName } from "$lib/instance/CNF3";
import type { Graph } from "$lib/instance/Graph";
import type { Certificate3CG } from "$lib/solve/Certificate3CG";
import { Certificate3SAT } from "$lib/solve/Certificate3SAT";
import type { Decoder } from "./Decoder";

export class Decoder3CGto3SAT implements Decoder<Graph, Certificate3CG, Certificate3SAT> {
    decode(outInstance: Graph, outCert: Certificate3CG): Certificate3SAT {
        // throw new Error("Method not implemented.");
        const assignment = new Map<VarName, TriBool>();
        return new Certificate3SAT(assignment);
    }
}
