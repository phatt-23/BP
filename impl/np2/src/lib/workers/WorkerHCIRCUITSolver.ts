// Created by phatt-23 on 21/10/2025

import { Unsolvable } from "$lib/core/Unsolvable";
import { Graph } from "$lib/instance/Graph";
import { SolverHCIRCUIT } from "$lib/solve/SolverHCIRCUIT";

self.onmessage = async (e) => {
    const instance : Graph = Graph.fromSerializedString(e.data);
    const solver = new SolverHCIRCUIT(instance);
    const result = await solver.solve();
    postMessage(result || Unsolvable);
};
