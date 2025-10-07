// phatt 2025-10-06

import { assert } from "../lib";

// matches not, NOT or !
const NEGATION = /(?:not\s+NOT\s+|!\s*)/i;
const KEYWORDS = [
    "AND", "and", "&&", 
    "OR", "or", "||", 
    "NOT", "!"
];
const IDENTIFIER = /\b[A-Za-z][A-Za-z0-9_]*\b/;

// Matches a literal, possibly negated
const LITERAL = new RegExp(
    `\\s*(${NEGATION.source})?(${IDENTIFIER.source})\\s*`, 
    "i"
);

// Matches OR and AND operators
const OR = /(?:\s+(?:or|OR)\s+|\s*\|\|\s*)/i;
const AND = /(?:\s*(?:and|AND|&&)\s*)/i;

// Matches a clause: (lit OR lit OR lit)
const CLAUSE = /\(\s*([^)]+)\s*\)/g;

// Matches the whole formula: (clause AND clause AND ...)
const FORMULA = new RegExp(
    `^\\s*(${CLAUSE.source}${AND.source})*${CLAUSE.source}\\s*$`, "i"
);

export type VarName = string;

export interface Literal {
    var: VarName;
    negated: boolean;
    id?: string;
}

export interface Clause {
    id: string;
    lits: [Literal, Literal, Literal];
}

export interface CNF3Instance {
    vars: VarName[];
    clauses: Clause[];
}

/**
 * Verifies the format of the sat formula.
 * TODO: Make an actual language checker not just regex. It crashes with bigger input.
 */
export function CheckCNF3InstanceString(instance: string): boolean {
    return FORMULA.test(instance);
}

/**
 * Parses a 3-CNF formula string into CNF3Expression object. 
 */
export function Parse3CNFInstanceString(instance: string): CNF3Instance {
    const variableSet = new Set<string>();
    const clauses = new Array<Clause>();

    const clauseStrings: string[] = instance
        .split(AND)
        .map(s => s.replace("(", "").replace(")", ""))

    for (const clause of clauseStrings) {
        let literals: Literal[] = clause
            .split(OR)
            .map(lit => {
                const literal = lit.replace(NEGATION, "!").trim();
                return {
                    var: literal.replace("!", ""),
                    negated: literal.includes("!"),
                };
            });

        assert(literals.length == 3);

        clauses.push({
            id: `c:${clauses.length}`,
            lits: [literals[0], literals[1], literals[2]],
        });

        literals.forEach(it => {
            variableSet.add(it.var)
        });
    }

    return { 
        vars: Array.from(variableSet).sort(),
        clauses,
    };
}

/**
 * Converts a CNF3Expression object to a formatted input string. 
 */
export function Format3CNFToInputString(expr: CNF3Instance): string {
    return (
        "${sat.variables.length} ${sat.clauses.length}\n\n" +
        expr.vars.join("\n") +
        "\n\n" +
        expr.clauses.map(clause => clause.lits.join(" ")).join("\n")
    );
}

/**
 *  Parse 3-CNF input string into a CNF3Expression object.
 */
export function ParseInputTo3CNF(input: string): CNF3Instance {
    const lines = input
        .split('\n')
        .map(line => line.trim())
        .filter(line => line.length > 0);

    if (lines.length == 0) 
        throw new Error("Sat input is empty.");

    const [variableCount, clauseCount] = lines[0].split(' ').map(Number);
    if (isNaN(variableCount) || isNaN(clauseCount)) 
        throw new Error("Invalid SAT header line.");

    const vars: VarName[] = lines.slice(1, 1 + variableCount);
    const clauses: Clause[] = lines
        .slice(1 + variableCount)
        .map((line, idx) => { 
            const literals: Literal[] = line
                .split(' ')
                .map(word => ({ var: word, negated: false }));

            assert(literals.length == 3);

            const clause: Clause = {
                id:  `clause:${idx}`, 
                lits: [literals[0], literals[1], literals[2]],
            };

            return clause;
        });

    return { vars, clauses };
}
