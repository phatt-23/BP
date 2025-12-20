// Created by phatt-23 on 21/10/2025

import { Unsolvable } from "$lib/core/Unsolvable";
import { Graph } from "$lib/instance/Graph";
import { SolverTSP } from "$lib/solve/SolverTSP";

self.onmessage = async (e) => {
    const serializedGraph: string = e.data.graph;
    const maxCost: number = e.data.maxCost;
    console.debug(serializedGraph);
    console.debug(maxCost);

    const instance: Graph = Graph.fromSerializedString(serializedGraph);

    const solver = new SolverTSP(instance, maxCost);
    try {
        const result = solver.solve();
        postMessage(result || Unsolvable);
    } finally {
        postMessage(Unsolvable);
    }
};
