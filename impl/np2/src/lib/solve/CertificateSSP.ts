// Created by phatt-23 on 22/10/2025

import type { SSPNumber } from "$lib/instance/SSP";
import type { Certificate } from "./Certificate";

export class CertificateSSP implements Certificate {
    numbers: SSPNumber[];

    constructor(numbers: SSPNumber[]) {
        this.numbers = numbers;
    }
}