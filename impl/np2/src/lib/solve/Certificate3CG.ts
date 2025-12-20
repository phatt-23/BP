import Serializer from "$lib/core/Serializer";
import type { GraphNode } from "$lib/instance/Graph";
import type { Certificate } from "./Certificate";

@Serializer.SerializableClass("Certificate3CG")
export class Certificate3CG implements Certificate {
    constructor(
        public rNodes: GraphNode[],
        public gNodes: GraphNode[],
        public bNodes: GraphNode[],
    ) {

    }
}
