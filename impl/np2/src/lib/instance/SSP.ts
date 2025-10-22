// Created by phatt-23

import type { ErrorMessage } from "$lib/core/assert";
import Serializer from "$lib/core/Serializer";
import { ProblemInstance } from "./ProblemInstance";

@Serializer.SerializableClass()
export class SSPNumber {
    id: string;
    value: number[];
    used: boolean;
    classes?: string;
    
    constructor(id: string, value: number[], used: boolean = false, classes?: string) {
        this.id = id;
        this.value = value;
        this.used = used;
        this.classes = classes;
    }

    public asString(): string {
        return this.value.join('');
    }
};

@Serializer.SerializableClass()
export class SSP extends ProblemInstance {
    public numbers: SSPNumber[];
    public target: number[];

    public constructor() {
        super(); 
        this.numbers = [];
        this.target = [0];
    }

    public addNumber(x: SSPNumber) {
        this.numbers.push(x);
    }

    public setTarget(target: number[]) {
        this.target = target;
    }

    public empty(): boolean {
        return this.numbers.length == 0;
    }

    public static fromString(numbersText: string, targetText: string): SSP | ErrorMessage {
        const ssp = new SSP();

        const lines = numbersText.split('\n').map(x => x.trim()).filter(x => x.length);

        try {
            const target = Array(targetText).map(c => Number.parseInt(c));
            ssp.setTarget(target);
        } catch (e) {
            console.error(e);
            return `Couldn't parse the target number: ${targetText}`;
        }

        lines.forEach((line, i) => {
            try {
                const numArray = Array.from(line).map(c => Number.parseInt(c));
                ssp.addNumber(new SSPNumber(`${i}`, numArray));
            } catch (e) {
                console.error(e);
                return `Couldn't parse the number on the line ${i}: ${line}.`;
            }
        });

        return ssp;
    }
}