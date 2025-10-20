// Created by phatt-23 on 20/10/2025

import { SolverHCYCLE } from "$lib/solve/SolverHCYCLE";
import { Unsolvable } from "$lib/core/Unsolvable";
import { Graph } from "$lib/instance/Graph.svelte";
import Serializer from "$lib/core/Serializer";

self.onmessage = async (e) => {
    const instance : Graph = Graph.fromSerializedString(e.data);
    const solver = new SolverHCYCLE(instance);
    const result = await solver.solve();
    postMessage(result || Unsolvable);
};