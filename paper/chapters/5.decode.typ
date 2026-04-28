#import "../lib/global.typ": *

== Dekódování řešení

Dekódování řešení slouží k převodu certifikátu výstupní instance
zpět na certifikát vstupní instance.
Každý dekoder implementuje rozhraní `Decoder` definované jako:

#figure(sourcecode(```ts
    interface Decoder<
        OC extends Certificate, 
        IC extends Certificate
    > {
        decode(outCert: OC): IC;
    }
  ```), 
  caption: [Rozhraní `Decoder`]
)

Následující diagram znázorňuje třídní hierarchii dekoderů.

#figure(
  image("../assets/plantuml/decode-class-diagram.svg"),
  caption: [Třídní hierarchie dekoderů]
)

=== Dekódování řešení HCYCLE na 3-SAT

Dekoder `DecoderHCYCLEto3SAT` analyzuje nalezený hamiltonovský cyklus
a rekonstruuje ohodnocení booleovských proměnných.

Algoritmus prochází vrcholy v nalezené cestě.
Pokud identifikátor vrchol začíná prefixem `NODE_ID_PREFIX_TRUE`,
je příslušná proměnná nastavena na hodnotu pravda.
Naopak pokud identifikátor vrchol začíná prefixem `NODE_ID_PREFIX_FALSE`,
je příslušná proměnná nastavena na hodnotu nepravda. // AGENT: ma byt carka za Naopak?

Název proměnné je extrahován odstraněním příslušného prefixu
a následné části identifikátoru obsahující pořadové číslo vrcholu.


=== Dekódování řešení SSP na 3-SAT

Dekoder `DecoderSSPto3SAT` analyzuje nalezenou podmnožinu čísel
a rekonstruuje ohodnocení booleovských proměnných.

Proměnná je nastavena na pravdu, 
pokud je v podmnožině přítomno
odpovídající číslo $nu_T$.
Proměnná je nastavena na nepravdu, 
pokud je v podmnožině přítomno
odpovídající číslo $nu_F$.


=== Dekódování řešení 3-CG na 3-SAT

Dekoder `Decoder3CGto3SAT` analyzuje nalezené obarvení grafu
a rekonstruuje ohodnocení booleovských proměnných.

Proměnná je nastavena na pravdu, pokud je vrchol $nu$ obarven zeleně.
Proměnná je nastavena na nepravdu, pokud je vrchol $nu$ obarven červeně.


=== Dekódování řešení HCIRCUIT na HCYCLE

Dekoder `DecoderHCIRCUITtoHCYCLE` převádí nalezenou hamiltonovskou kružnici
v neorientovaném grafu na hamiltonovský cyklus v orientovaném grafu.

Algoritmus prochází nalezenou kružnicí a pro každou dvojici po sobě jdoucích vrcholů
nalezne odpovídající dvojici ve výstupním grafu HCYCLE.


=== Dekódování řešení TSP na HCIRCUIT

Dekoder `DecoderTSPtoHCIRCUIT` převádí nalezenou optimální cestu v TSP
na hamiltonovskou kružnici v neorientovaném grafu.

Algoritmus filtruje hrany nalezené cesty a vybírá pouze ty,
které mají váhu 1, což odpovídá hranám původního grafu HCIRCUIT.

