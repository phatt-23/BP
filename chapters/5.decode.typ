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
Naopak, pokud identifikátor vrchol začíná prefixem `NODE_ID_PREFIX_FALSE`,
je příslušná proměnná nastavena na hodnotu nepravda.

Název proměnné je extrahován odstraněním příslušného prefixu
a následné části identifikátoru obsahující pořadové číslo vrcholu.


=== Dekódování řešení SSP na 3-SAT

Dekoder `DecoderSSPto3SAT` analyzuje nalezenou podmnožinu čísel
a rekonstruuje ohodnocení booleovských proměnných.

Proměnná je nastavena na pravdu, 
pokud je v podmnožině přítomno
odpovídající číslo $x^((T))$.
Proměnná je nastavena na nepravdu, 
pokud je v podmnožině přítomno
odpovídající číslo $x^((F))$.


=== Dekódování řešení 3-CG na 3-SAT

Dekoder `Decoder3CGto3SAT` analyzuje nalezené obarvení grafu
a rekonstruuje ohodnocení booleovských proměnných.

Proměnná je nastavena na pravdu, pokud je vrchol $x$ obarven zeleně.
Proměnná je nastavena na nepravdu, pokud je vrchol $x$ obarven červeně.


=== Dekódování řešení HCIRCUIT na HCYCLE

Dekoder `DecoderHCIRCUITtoHCYCLE` převádí nalezenou hamiltonovskou kružnici
v neorientovaném grafu na hamiltonovský cyklus v orientovaném grafu.

Algoritmus prochází nalezenou cestu, odebírá prefixy identifikátorů vrcholů,
které označují typ uzlu (vstupní, výstupní nebo propojovací),
a odstraňuje po sobě jdoucí duplicity. 
Vrcholy, které zbydou, odpovídají hamiltonovskému cyklu v orientovaném grafu.


=== Dekódování řešení TSP na HCIRCUIT

Dekoder `DecoderTSPtoHCIRCUIT` převádí nalezenou optimální cestu v TSP
na hamiltonovskou kružnici v neorientovaném grafu.

Jelikož vrcholy grafů TSP a HCIRCUIT jsou totožné a řešení má shodný formát,
dekodování je triviální -- nalezená cesta je přímo vrácena jako řešení HCIRCUIT. 

