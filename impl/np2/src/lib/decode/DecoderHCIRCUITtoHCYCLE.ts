// Created by phatt-23 on 21/10/2025

import { NODE_GAP_POSTFIX, NODE_ID_PREFIX, NODE_IN_POSTFIX, NODE_OUT_POSTFIX, type Id } from "$lib/core/Id";
import type { Graph, GraphNode } from "$lib/instance/Graph";
import type { CertificateHCIRCUIT } from "$lib/solve/CertificateHCIRCUIT";
import { CertificateHCYCLE } from "$lib/solve/CertificateHCYCLE";
import type { Decoder } from "./Decoder";

export class DecorderHCIRCUITtoHCYCLE implements Decoder<Graph, CertificateHCIRCUIT, CertificateHCYCLE> {
    decode(outInstance: Graph, outCert: CertificateHCIRCUIT): CertificateHCYCLE {
        console.debug(outCert.path);

        const path = new Array<Id>();

        outCert.path.forEach(node => {
            const inPos = node.id.lastIndexOf(NODE_IN_POSTFIX);
            const gapPos = node.id.lastIndexOf(NODE_GAP_POSTFIX);
            const outPos = node.id.lastIndexOf(NODE_OUT_POSTFIX);

            const end = Math.max(inPos, gapPos, outPos);

            const nodeName = node.id.slice(NODE_ID_PREFIX.length, end)

            path.push(nodeName);
        });

        // remove duplicate occurences that are next to each other
        const reconstructed = new Array<GraphNode>();

        let p = undefined;
        for (let i = 0; i < path.length; i++) {
            if (p == path[i])
                continue;

            p = path[i];
            reconstructed.push({
                id: NODE_ID_PREFIX + p,
            });
        }

        return new CertificateHCYCLE(reconstructed);
    }
}
