//
// Created by phatt-23 on 11/10/2025
//

import { assert, type ErrorMessage } from "$lib/core/assert";
import { onlyUnique } from "$lib/core/filters";
import type { Id } from "$lib/core/Id";
import { Serializer } from "$lib/core/Serializer";
import { ProblemInstance } from "./ProblemInstance";
import "reflect-metadata";

type VarName = string;

@Serializer.SerializableClass()
class Literal {
    public id: Id;
    public varName: VarName;
    public negated: boolean;

    constructor(id: Id, varName: VarName, negated: boolean = false) {
        this.id = id;
        this.varName = varName;
        this.negated = negated;
    }

    public toJson() {
        return {
            __type: Literal.name,
            id: this.id,
            varName: this.varName,
            negated: this.negated,
        }
    }
}

@Serializer.SerializableClass()
class Clause {
    public id: Id;
    public literals: [Literal, Literal, Literal];

    constructor(id: Id, lits: Literal[]) {
        assert(lits.length == 3);

        this.id = id;
        this.literals = [lits[0], lits[1], lits[2]];
    }

    public asString() : string {
        return Clause.makeString(this);
    }

    public static makeString(clause: Clause) {
        return clause.literals.map(l => l.varName).join(" ");
    }

    public toJSON() {
        return {
            __type: Clause.name,
            id: this.id,
            literals: this.literals,
        }
    }
}

@Serializer.SerializableClass()
export class CNF3 extends ProblemInstance {
    public variables: Set<VarName> = new Set();
    public clauses: Set<Clause> = new Set();

    public addVariable(v: VarName) {
        this.variables.add(v);
    }

    public addClause(clause: Clause): void {
        this.clauses.add(clause);
        clause.literals.forEach(literal => this.addVariable(literal.varName));
    }

    public asString() {
        return Array.from(this.clauses.values()).map(c => c.asString()).join("\n")
    }

    public static fromString(text: string): CNF3 | ErrorMessage {
        const lines = text.split("\n").map(x => x.trim()).filter(x => x.length).filter(onlyUnique);

        let cnf = new CNF3();

        for (let i = 0; i < lines.length; i++) {
            const line = lines[i];
            const words = line.split(" ").map(word => word.trim()).filter(word => word.length);

            if (words.length != 3) {
                return `Clause number ${i + 1} (${line}) doesn't have exactly 3 literals. Instead it has ${words.length} literals.`;
            }
            
            let lits: Literal[] = [];
            for (let j = 0; j < words.length; j++) {
                let word = words[j];

                // find out if its negated literal
                const negated = word.startsWith("!");
                if (negated) {
                    word = word.replace("!", "");  // replace the first occurence
                }

                // verify that is only has allowed characters
                if (word.includes("!") || word.includes("||") || word.includes("&&")) {
                    return `Literal ${negated ? "!" : ""}${word} is invalid.`;
                }

                const lit = new Literal(`v:${j}-c:${i}`, word, negated);
                lits.push(lit);
            }

            assert(lits.length == 3);

            const clause = new Clause(`c:${i}`, lits);
            cnf.addClause(clause);
        }

        return cnf;
    }
}