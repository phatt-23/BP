// phatt 2025-10-07

export type SSPInstance = {
    elements: number[];
    target: number[];
};

export function FormatSSPToInputString(ssp: SSPInstance): string {
    return (
        `${ssp.elements.length} ${ssp.elements.toString().length}\n\n` +
        ssp.target +
        "\n\n" + 
        ssp.elements.join("\n")
    );
}

export function parseSubsetSumInput(input: string): SSPInstance {

    const lines = input.split("\n").filter(line => line.length != 0);

    if (lines.length == 0) {
        throw new Error("SubsetSum input is empty.");
    }

    const [numberCount, digitCount] = lines.shift()!.split(" ").map(a => Number.parseInt(a));

    const targetSum = lines.shift()!.split("").map(a => Number.parseInt(a));
    const numbers = lines.map(line => line.split("").map(a => Number.parseInt(a)));
    
    return {
        targetSum: targetSum,
        numbers: numbers,
    };
}
