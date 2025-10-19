// phatt 205-10-06

export interface ProblemInstance<TCertificate = any> {
    id: string;
    kind: "3SAT" | "3DM" | "SSP" | "GRAPH" | "TSP" | string;
    data: any;
    metadata?: Record<string, any>;
    certificate?: TCertificate;  // witness (assignment, matching)
}
