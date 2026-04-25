#import "../lib/global.typ": *

== Implementace redukcí

Každá redukce je implementována jako samostatná třída rozšiřující abstraktní třídu `Reducer`.
Třída `Reducer` definuje společné rozhraní pro všechny redukce:

#figure(sourcecode[```ts

  abstract class Reducer<
    I extends ProblemInstance, 
    O extends ProblemInstance
  > {
      constructor(public inInstance: I) {}
      
      public reduce(): ReductionResult<I, O>
  }

```], caption: [Abstraktní třída `Reducer`])

Metoda `reduce` kontroluje, zda vstupní instance není prázdná,
a následně volá abstraktní metodu `doReduce`,
která je implementována v každé konkrétní redukci.

Výsledkem redukce je datová struktura `ReductionResult` 
obsahující výstupní instanci a seznam kroků redukce.
Každý krok redukce je reprezentován strukturou `ReductionStep`,
která obsahuje:

- jedinečný identifikátor kroku,
- nadpis popisující prováděnou operaci,
- podrobný popis v HTML formátu,
- volitelný snímek vstupní instance před krokem,
- volitelný snímek výstupní instance po kroku,
- mapování mezi prvky vstupní a výstupní instance.

Tato struktura umožňuje zpětnou rekonstrukci procesu redukce
a vizualizaci jednotlivých kroků.

#figure(
  image("../assets/reduction-class-diagram.svg"),
  caption: [Třídní hierarchie redukcí]
)


=== Redukce 3-SAT na HCYCLE

Implementace redukce `Reducer3SATtoHCYCLE` se skládá ze dvou hlavních fází:
vytvoření konstrukčních prvků proměnných a vytvoření konstrukčních prvků klauzulí.

V první fázi metoda `createVarGadgets` vytváří pro každou proměnnou formule
řadu vrcholů reprezentující konstrukční prvek proměnné.
Počet vrcholů v řadě je vypočítán jako $3k + 3$,
kde $k$ je počet klauzulí.
Tento vzorec zajišťuje dostatečný počet vrcholů pro propojení s konstrukčními prvky klauzulí
a zároveň zabraňuje nežádoucímu přeskakování mezi konstrukčními prvky.

Součástí této fáze je vytvoření zdrojového vrcholu $alpha$,
cílového vrcholu $beta$ a mezi-vrcholů spojujících jednotlivé řady proměnných.
Tyto vrcholy jsou propojeny s krajními vrcholy příslušných řad.

Ve druhé fázi metoda `createClauseGadgets` vytváří pro každou klauzuli jeden vrchol klauzule.
Na základě literálů v klauzuli jsou přidány hrany mezi vrcholem klauzule
a příslušnými vrcholy v řadách proměnných.
Směr připojení hran závisí na tom, zda je literál negován či nikoli.

Redukce využívá konstanty definované v modulu `Id` pro jednotné označování
různých typů vrcholů a hran v grafu.


=== Redukce 3-SAT na SSP

Implementace redukce `Reducer3SATtoSSP` využívá maticovou reprezentaci čísel SSP.
Hlavní metoda `doReduce` volá postupně čtyři pomocné metody:

1. `createTargetSum` nastaví cílovou hodnotu $tau$,
   která se skládá z $v$ jedniček a $c$ trojek,
   kde $v$ je počet proměnných a $c$ počet klauzulí.

2. `createVarNumbers` vytváří dvojici čísel $nu_T$ a $nu_F$ pro každou proměnnou $nu$.
   Diagonála matice je nastavena na hodnotu 1,
   což zajišťuje, že v konečné podmnožině může být zvolena
   buď $nu_T$ nebo $nu_F$, nikoli obě.

3. `updateVarNumbers` aktualizuje čísla proměnných na základě struktury klauzulí.
   Pro každý výskyt proměnné v klauzuli je příslušná pozice v matici nastavena na 1.

4. `createBufferNumbers` přidává dvojici vyrovnávacích čísel pro každou klauzuli.
   Tato čísla umožňují dosáhnout cílové hodnoty 3 v příslušné pozici,
   pokud je klauzule splněna.

Implementace využívá datovou strukturu `Map` pro rychlé vyhledávání
hodnot čísel podle jejich identifikátorů.


=== Redukce 3-SAT na 3-CG

Implementace redukce `Reducer3SATto3CG` se skládá ze tří fází:
vytvoření jádra, vytvoření konstrukčních prvků proměnných a vytvoření konstrukčních prvků klauzulí.

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


=== Redukce HCYCLE na HCIRCUIT

Implementace redukce `ReducerHCYCLEtoHCIRCUIT` převádí orientovaný graf na neorientovaný.

Metoda `createNodeTriplets` vytváří pro každý vrchol orientovaného grafu
trojici vrcholů neorientovaného grafu:
$v_i$ pro vstup, $v_o$ pro výstup a $v_b$ jako propojovací uzel.
Tyto tři vrcholy jsou spojeny do řetězce.

Metoda `connectEdges` propojuje výstupní vrcholy zdrojových uzlů
se vstupními vrcholy cílových uzlů podle hran původního grafu.

Redukce využívá kruhové uspořádání vrcholů pro přehlednou vizualizaci.


=== Redukce HCIRCUIT na TSP

Implementace redukce `ReducerHCIRCUITtoTSP` se skládá ze tří fází:
zkopírování vrcholů, vytvoření úplného grafu a přiřazení vah hran.

Metoda `copyVertices` přenáší všechny vrcholy z výstupní instance HCIRCUIT
do nového grafu.

Metoda `createEdges` přidává hrany mezi každou dvojicí vrcholů,
čímž vzniká úplný graf.

Metoda `assignWeights` přiřazuje váhu 1 hranám, které odpovídají hranám
původního grafu HCIRCUIT, a váhu 2 ostatním hranám.
Cílová hodnota $k$ je nastavena na počet vrcholů grafu.


=== Ukládání kroků redukce

Každá implementace redukce ukládá mezikroky do seznamu `ReductionStep[]`.
Každý krok obsahuje LaTeXový popis prováděné operace,
který je následně vykreslen pomocí knihovny KaTeX.

Pro vizualizaci změn mezi kroky jsou pořizovány snímky instancí
pomocí metody `copy` příslušné třídy.

