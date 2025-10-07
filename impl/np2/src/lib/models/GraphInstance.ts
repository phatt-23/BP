// phatt 2025-10-06

export type Node = {
    id: string;         // naming v:{whatever}
    label?: string;
}

export type Edge = {
    id: string;         // naming e:{whatever}
    from: string;
    to: string;
    weight?: number;    // int
}

export type GraphInstance = {
    nodes: Node[];
    edges: Edge[];     
};

/**
 * Verifies that the graph instance string is in correct format.
 * Throws erros for uncorrect instance string.
 */
export function CheckGraphInstanceString(instance: string): boolean {
    const lines = instance
        .split("\n")
        .map(line => line.trim())
        .filter(line => line.length > 0);

    for (const line of lines) {
        const nodes = line.split(" ");

        if (nodes.length > 3) {
            // TODO: for now throw error
            throw new Error("Error: There may not be more than three words per line.");
            return false;
        }
    }
    
    return true;
}

/**
 * Parses a graph instance string into a Graph object. 
 * Supports lines with one node or two nodes (edge) or two nodes and a number (weighted edge). 
 */
export function ParseGraphInstanceString(instance: string): GraphInstance {
    const lines = instance
        .split("\n")
        .map(line => line.trim())
        .filter(line => line.length !== 0);

    const nodeSet = new Set<string>();
    const edges: Edge[] = [];
    
    let edgeId = 0;

    for (const line of lines) {
        const words = line.split(" ");

        if (words.length == 1) {
            nodeSet.add(words[0]);
        } else if (words.length == 2) {
            nodeSet.add(words[0]);
            nodeSet.add(words[1]);
            
            edges.push({
                id: `e:${edgeId}`,
                from: words[0],
                to: words[1],
            });
        } else if (words.length == 3) {
            nodeSet.add(words[0]);
            nodeSet.add(words[1]);
            
            edges.push({
                id: `e:${edgeId}`,
                from: words[0],
                to: words[1],
                weight: Number.parseInt(words[2]),
            });
        } else {
            throw new Error("A line may not have more than 3 words on it.");
        }
    }

    const nodes: Node[] = Array.from(nodeSet).sort().map(id => ({ id }));

    return {
        nodes,
        edges,
    };
}

/**
 * Formats a Graph object into a string suitable for input.
 */
export function FormatGraphToInputString(graph: GraphInstance): string {
    return (
        `${graph.nodes.length} ${graph.edges.length}\n\n` +
        graph.nodes
            .map(n => n.id)
            .join("\n") +
        "\n\n" + 
        graph.edges
            .map(e => `${e.from} ${e.from}` + (e.weight == undefined) ? "" : e.weight)
            .join("\n")
    );
}

/**
 * Parses a formatted graph input string into a Graph object. 
 */
export function ParseGraphInputString(input: string): GraphInstance {
    const lines = input
        .split("\n")
        .map(line => line.trim())
        .filter(line => line.length > 0);

    if (lines.length == 0) {
        throw new Error("Graph input is empty.");
    }

    // First line: vertex count and edge count
    const [vertexCount, edgeCount] = lines[0].split(" ").map(n => Number.parseInt(n)); 
    if (isNaN(vertexCount) || isNaN(edgeCount)) {
        throw new Error("Invalid graph header line.");
    }

    // Next vertexCount lines: node ids
    const nodes: Node[] = lines.slice(1, 1 + vertexCount).map(id => ({ id }));

    // Remaining lines: edges
    const edges: Edge[] = lines.slice(1 + vertexCount).map((line, idx) => {
        const [from, to] = line.split(" ");
        if (!from || !to) 
            throw new Error(`Invalid edge line: ${line}`);
        return { id: `e:${idx}`, from, to };
    })
    
    return { nodes, edges };
}
