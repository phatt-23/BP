// Created by phatt-23 on 22/10/2025

import type { SSP } from "$lib/instance/SSP";
import type { Certificate3SAT } from "$lib/solve/Certificate3SAT";
import type { CertificateSSP } from "$lib/solve/CertificateSSP";
import type { Decoder } from "./Decoder";

export class DecoderSSPto3SAT implements Decoder<SSP, CertificateSSP, Certificate3SAT> {
    decode(outInstance: SSP, outCert: CertificateSSP): Certificate3SAT {
        throw new Error("Method not implemented.");
    }
}