// Created by phatt-23 on 21/10/2025

import { Unsolvable } from "$lib/core/Unsolvable";
import { Graph } from "$lib/instance/Graph";
import { SolverTSP } from "$lib/solve/SolverTSP";

self.onmessage = async (e) => {
    const instance : Graph = Graph.fromSerializedString(e.data);
    const solver = new SolverTSP(instance);
    try {
        const result = solver.solve();
        postMessage(result || Unsolvable);
    } finally {
        postMessage(Unsolvable);
    }
};
