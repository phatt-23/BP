#import "../lib/global.typ": *

== Implementace redukcí

Každá redukce je implementována jako samostatná třída rozšiřující abstraktní třídu `Reducer`.
Třída `Reducer` definuje společné rozhraní pro všechny redukce:

#figure(sourcecode[```ts
    abstract class Reducer<
        I extends ProblemInstance, 
        O extends ProblemInstance,
    > {
        constructor(public inInstance: I) {}

        public reduce(): ReductionResult<I, O> {
            if (this.inInstance.isEmpty()) {
                throw "Call to reduce failed. Input instance is empty.";
            }
            const result = this.doReduce();
            return result;
        }

        /*
        * Implemented by derived classes.
        */
        protected abstract doReduce(): ReductionResult<I, O>;
    }
```], caption: [
  Abstraktní třída `Reducer` 
])

Metoda `reduce` kontroluje, zda vstupní instance není prázdná,
a následně volá abstraktní metodu `doReduce`,
která je implementována v každé konkrétní redukci.

Výsledkem redukce je datová struktura `ReductionResult` 
obsahující výstupní instanci a seznam kroků redukce.
Každý krok redukce je reprezentován strukturou `ReductionStep`,
která obsahuje:

- jedinečný identifikátor kroku,
- nadpis popisující prováděnou operaci,
- podrobný popis v HTML formátu a
- snímek (snapshot) výstupní instance v aktuálním kroku.

Tato struktura umožňuje zpětnou rekonstrukci procesu redukce 
a vizualizaci jednotlivých kroků.

Následující diagram znázorňuje třídní hierarchii redukcí.

#figure(
  image("../assets/plantuml/reduction-class-diagram.svg"),
  caption: [Třídní hierarchie redukcí]
)


=== Redukce 3-SAT na HCYCLE

Implementace redukce `Reducer3SATtoHCYCLE` se skládá ze dvou hlavních fází:

+ vytvoření konstrukčních prvků proměnných a 
+ vytvoření konstrukčních prvků klauzulí.


V první fázi metoda `createVarGadgets` vytváří pro každou proměnnou formule
řadu vrcholů reprezentující konstrukční prvek proměnné.
Součástí této fáze je vytvoření zdrojového vrcholu $alpha$,
cílového vrcholu $beta$ a mezi-vrcholů spojujících jednotlivé řady proměnných.
Tyto vrcholy jsou propojeny s krajními vrcholy příslušných řad.

Ve druhé fázi metoda `createClauseGadgets` vytváří pro každou klauzuli jeden vrchol klauzule.
Na základě literálů v klauzuli jsou přidány hrany mezi vrcholem klauzule
a příslušnými vrcholy v řadách proměnných.
Směr připojení hran závisí na tom, zda je literál negován či nikoli.

Redukce využívá konstanty definované v modulu `Id` pro jednotné označování
různých typů vrcholů a hran v grafu.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-3sat-hcycle[kapitole].


=== Redukce 3-SAT na SSP

Implementace redukce `Reducer3SATtoSSP` využívá maticovou reprezentaci čísel SSP.
Hlavní metoda `doReduce` volá postupně čtyři pomocné metody:

+ `createTargetSum` nastaví cílovou hodnotu $tau$,
   která se skládá z $v$ jedniček a $c$ trojek,
   kde $v$ je počet proměnných a $c$ počet klauzulí.

+ `createVarNumbers` vytváří dvojici čísel $nu_T$ a $nu_F$ pro každou proměnnou $nu$.
   Diagonála matice je nastavena na hodnotu 1,
   což zajišťuje, že v konečné podmnožině může být zvolena
   buď $nu_T$ nebo $nu_F$, nikoli obě.

+ `updateVarNumbers` aktualizuje čísla proměnných na základě struktury klauzulí.
   Pro každý výskyt proměnné v klauzuli je příslušná pozice v matici nastavena na 1.

+ `createBufferNumbers` přidává dvojici vyrovnávacích čísel pro každou klauzuli.
   Tato čísla umožňují dosáhnout cílové hodnoty 3 v příslušné pozici,
   pokud je klauzule splněna.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-3sat-ssp[kapitole].


=== Redukce 3-SAT na 3-CG


Implementace redukce `Reducer3SATto3CG` se skládá ze tří fází:

+ vytvoření jádra, 
+ vytvoření konstrukčních prvků proměnných a 
+ vytvoření konstrukčních prvků klauzulí.



Metoda `createCoreGadget` vytváří základní trojici vrcholů $T$, $F$ a $B$,
které jsou vzájemně propojeny.
Tyto vrcholy reprezentují pravdu, nepravdu a vyrovnávací barvu.

Metoda `createVariableGadgets` vytváří pro každou proměnnou trojici vrcholů
$nu$, $not nu$ a $B$.
Vrcholy $nu$ a $not nu$ jsou spojeny s vrcholem $B$,
což zajišťuje, že mohou být obarveny pouze barvami pravdy a nepravdy.

Metoda `createClauseGadgets` vytváří pro každou klauzuli šest vrcholů
a příslušné hrany.
Klauzule je připojena k vrcholům odpovídajícím jejím literálům.

Barvy jsou reprezentovány číselně:
červená pro nepravdu, zelená pro pravdu a modrá pro vyrovnávací barvu.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-3sat-3cg[kapitole].


=== Redukce HCYCLE na HCIRCUIT

Implementace redukce `ReducerHCYCLEtoHCIRCUIT` převádí orientovaný graf na neorientovaný.

Metoda `createNodeTriplets` vytváří pro každý vrchol orientovaného grafu
trojici vrcholů neorientovaného grafu:
$v_i$ pro vstup, $v_o$ pro výstup a $v_b$ jako propojovací uzel.
Tyto tři vrcholy jsou spojeny do řetězce.

Metoda `connectEdges` propojuje výstupní vrcholy zdrojových uzlů
se vstupními vrcholy cílových uzlů podle hran původního grafu.

Redukce využívá kruhové uspořádání vrcholů pro přehlednou vizualizaci.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-hcycle-hcircuit[kapitole].


=== Redukce HCIRCUIT na TSP


Implementace redukce `ReducerHCIRCUITtoTSP` se skládá ze tří fází:

+ zkopírování vrcholů, 
+ vytvoření úplného grafu a 
+ přiřazení vah hran.

Metoda `copyVertices` přenáší všechny vrcholy z výstupní instance HCIRCUIT
do nového grafu.

Metoda `createEdges` přidává hrany mezi každou dvojicí vrcholů,
čímž vzniká úplný graf.

Metoda `assignWeights` přiřazuje váhu 1 hranám, které odpovídají hranám
původního grafu HCIRCUIT, a váhu 2 ostatním hranám.
Cílová hodnota $k$ je nastavena na počet vrcholů grafu.

Podrobnosti tohoto převodu jsou popsány v kapitole @sec-redukce-hcircuit-tsp.


=== Ukládání kroků redukce

Každá implementace redukce ukládá mezikroky do seznamu `ReductionStep[]`.

Každý krok obsahuje popis prováděné operace v kombinaci HTML a TeX,
který je následně vykreslen pomocí knihovny KaTeX.

Pro vizualizaci změn mezi kroky jsou pořizovány snímky instancí
pomocí metody `copy` příslušné třídy.

