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

Implementace redukce `Reducer3SATtoHCYCLE` konstruuje orientovaný graf
z konstrukčních prvků pro proměnné a klauzule vstupní formule.
Metoda `doReduce` volá postupně dvě pomocné metody:

+ `createVarGadgets` vytváří pro každou proměnnou formule
  řadu vrcholů reprezentující konstrukční prvek proměnné.
  Součástí je vytvoření mezi-vrcholů,
  které spojují jednotlivé řady proměnných do jednoho cyklu.

+ `createClauseGadgets` vytváří pro každou klauzuli jediný vrchol.
  Na základě literálů v klauzuli jsou přidány hrany mezi vrcholem klauzule
  a příslušnými vrcholy v řadách proměnných.
  Směr připojení hran závisí na tom, zda je literál negován či nikoli.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-3sat-hcycle[kapitole].


=== Redukce 3-SAT na SSP

Implementace redukce `Reducer3SATtoSSP` využívá maticovou reprezentaci čísel.
Metoda `doReduce` volá postupně čtyři pomocné metody:

+ `createTargetSum` nastaví cílovou hodnotu $tau$,
  která se skládá z $v$ jedniček a $c$ trojek,
  kde $v$ je počet proměnných a $c$ počet klauzulí.

+ `createVarNumbers` vytváří dvojici čísel $x^((T))$ a $x^((F))$ pro každou proměnnou $x$.
  Diagonála matice je nastavena na hodnotu 1,
  což zajišťuje, že v konečné podmnožině může být zvolena
  buď $x^((T))$ nebo $x^((F))$, nikoli obě.

+ `updateVarNumbers` aktualizuje čísla proměnných na základě struktury klauzulí.
  Pro každý výskyt proměnné v klauzuli je příslušná pozice v matici nastavena na 1.

+ `createBufferNumbers` přidává dvojici vyrovnávacích čísel pro každou klauzuli.
  Tato čísla umožňují dosáhnout cílové hodnoty 3 v příslušné pozici,
  pokud je klauzule splněna.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-3sat-ssp[kapitole].


=== Redukce 3-SAT na 3-CG

Implementace redukce `Reducer3SATto3CG` konstruuje neorientovaný graf
z jádrového prvku, prvků proměnných a prvků klauzulí.
Metoda `doReduce` volá postupně tři pomocné metody:

+ `createCoreGadget` vytváří základní trojici vzájemně propojených vrcholů
  $T$, $F$ a $B$, které reprezentují pravdu, nepravdu a vyrovnávací barvu.

+ `createVariableGadgets` vytváří pro každou proměnnou trojici vrcholů
  $nu$, $not nu$ a $B$.
  Vrcholy $nu$ a $not nu$ jsou spojeny s vrcholem $B$,
  což zajišťuje, že mohou být obarveny pouze barvami pravdy a nepravdy.

+ `createClauseGadgets` vytváří pro každou klauzuli šest vrcholů
  a příslušné hrany.
  Klauzule je připojena k vrcholům odpovídajícím jejím literálům.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-3sat-3cg[kapitole].


=== Redukce HCYCLE na HCIRCUIT

Implementace redukce `ReducerHCYCLEtoHCIRCUIT` převádí orientovaný graf na neorientovaný.
Metoda `doReduce` volá postupně dvě pomocné metody:

+ `createNodeTriplets` vytváří pro každý vrchol orientovaného grafu
  trojici vrcholů neorientovaného grafu:
  $v_i$ pro vstup, $v_b$ jako propojovací uzel a $v_o$ pro výstup.
  Tyto tři vrcholy jsou spojeny do řetězce.

+ `connectEdges` propojuje výstupní vrcholy zdrojových uzlů
  se vstupními vrcholy cílových uzlů podle hran původního grafu.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-hcycle-hcircuit[kapitole].


=== Redukce HCIRCUIT na TSP

Implementace redukce `ReducerHCIRCUITtoTSP` převádí neorientovaný graf
na ohodnocený úplný graf.
Metoda `doReduce` volá postupně tři pomocné metody:

+ `copyVertices` přenáší všechny vrcholy ze vstupní instance HCIRCUIT
  do nového grafu.

+ `createEdges` přidává hrany mezi každou dvojicí vrcholů,
  čímž vzniká úplný graf.

+ `assignWeights` přiřazuje váhu 1 hranám, které odpovídají hranám
  původního grafu HCIRCUIT, a váhu 2 ostatním hranám.
  Cílová hodnota $k$ je nastavena na počet vrcholů grafu.

Podrobnosti tohoto převodu jsou popsány v @sec-redukce-hcircuit-tsp[kapitole].


=== Ukládání kroků redukce

Každá implementace redukce ukládá mezikroky do seznamu `ReductionStep[]`.
Každý krok obsahuje popis prováděné operace v kombinaci HTML a TeX,
který je následně vykreslen pomocí knihovny KaTeX.
Pro vizualizaci změn mezi kroky jsou pořizovány snímky instancí
pomocí metody `copy` příslušné třídy.

