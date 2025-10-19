// Created by phat-23 on 19/10/2025

import { CNF3 } from "$lib/instance/CNF3.svelte";
import type { ProblemInstance } from "$lib/instance/ProblemInstance";

export class DemoProvider {
    // Predefined demos for CNF3
    private static cnf3TextInput: Record<string, string> = {
        NO_SOLUTION: 
            'x y z\n' +
            '!x y z\n' +
            'x !y z\n' +
            '!x !y z\n' +
            'x y !z\n' +
            '!x y !z\n' +
            'x !y !z\n' +
            '!x !y !z\n',
        BASIC:
            'x y z\n' +
            'a b c\n',
    };

    /**
     * Uses constructor references instead of generics
     */
    public static getTextInputs(instanceClass: new (...args: any[]) => ProblemInstance) : Record<string, string> {
        if (instanceClass === CNF3) {
            return DemoProvider.cnf3TextInput;
        }

        throw new Error(`No demos provided for class ${instanceClass.name}.`);
    }
}