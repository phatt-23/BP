// Created by phatt-23 on 22/10/2025

import { Unsolvable } from "$lib/core/Unsolvable";
import { SSP } from "$lib/instance/SSP";
import { SolverSSP } from "$lib/solve/SolverSSP";

self.onmessage = async (e) => {
    const ssp = SSP.fromString(e.data.numbers, e.data.target);

    if (typeof ssp == 'string') {
        postMessage(new Error("SSP couldn't be parsed from string."));
        return;
    }

    const solver = new SolverSSP(ssp);

    try {
        const result = solver.solve();
        postMessage(result || Unsolvable);
    } finally {
        postMessage(Unsolvable);
    }
};