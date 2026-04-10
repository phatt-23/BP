#import "/lib/global.typ": *

= Implementace

Tato kapitola se věnuje implementaci navrženého systému.
Nejprve je popsána vnitřní reprezentace instancí problémů a validace vstupních dat.
Následně je detailně rozebrána implementace jednotlivých redukcí,
včetně mapování teoretických kroků na programový kód.
Kapitola dále popisuje, jakým způsobem systém řeší problémy a dekóduje řešení.

Cílem bylo vytvořit přehledný a srozumitelný kód,
který co nejpřesněji reflektuje teoretický popis redukcí.
Optimalizace výkonu byly prováděny pouze v nezbytných případech.


== Reprezentace instancí problémů

Interní reprezentace instancí je založena na abstraktní třídě `ProblemInstance`,
která definuje společné rozhraní pro všechny typy problémů.
Každá konkrétní reprezentace rozšiřuje tuto abstraktní třídu
a implementuje specifické metody pro práci s daným typem problému.

Toto řešení umožňuje jednotné zpracování různých typů problémů
v rámci systému redukcí,
přičemž každá instance si zachovává specifické vlastnosti svého typu.

=== Reprezentace formule 3-SAT

Booleovská formule v 3-KNF je reprezentována třídou `CNF3`.
Tato třída obsahuje množinu proměnných a množinu klauzulí.
Každá klauzule je reprezentována třídou `Clause`,
která obsahuje trojici literálů.
Literál je reprezentován třídou `Literal`, jež obsahuje název proměnné a příznak negace.

Třída `CNF3` poskytuje statickou metodu `fromString` pro parsování textového vstupu.
Tato metoda očekává vstup ve formě víceřádkového textu,
kde každý řádek reprezentuje jednu klauzuli.
Literály jsou odděleny mezerou a negace je označena prefixem `!`.

Příklad vstupního formátu:

```
a b c
!x y z
```

=== Reprezentace grafů

Grafové problémy využívají třídu `Graph`, která poskytuje reprezentaci orientovaných i neorientovaných grafů.
Graf je reprezentován jako množina vrcholů a množina hran.
Každý vrchol obsahuje identifikátor, popisek, pozici pro vizualizaci a volitelnou barvu.
Hrana obsahuje identifikátor, počáteční vrchol, cílový vrchol a volitelnou váhu.

Pro parsování vstupu poskytuje třída `Graph` statickou metodu `fromString`.
Vstupní formát umožňuje specifikovat vrcholy a hrany.
Jednotlivé řádky mohou obsahovat:

- pouze název vrcholu pro definici izolovaného vrcholu,
- dva názvy vrcholů oddělené mezerou pro definici hrany,
- dva názvy vrcholů a celé číslo pro definici hrany s váhou.

Třída `Graph` poskytuje metodu `copy` pro vytvoření hluboké kopie grafu
a metodu `labelSolved` pro označení hran náležících k nalezenému řešení.

=== Reprezentace problému SSP

Problém podmnožinového součtu je reprezentován třídou `SSP`.
Tato třída obsahuje seznam čísel a cílovou hodnotu.
Každé číslo je reprezentováno jako pole cifer, což umožňuje práci s velkými čísly,
která by přesáhla maximální hodnotu standardního celočíselného typu.

Parsování vstupu probíhá ve dvou krocích:
nejprve se parsuje text obsahující jednotlivá čísla,
poté se parsuje cílová hodnota.
Každý řádek vstupu reprezentuje jedno číslo.

=== Validace vstupu

Validace vstupních dat probíhá ve dvou fázích.
První fáze kontroluje syntaktickou správnost vstupu během parsování.
V této fázi jsou odmítnuty vstupy obsahující neplatné znaky nebo porušující základní syntaktická pravidla.

Druhá fáze validace probíhá po úspěšném parsování vstupu prostřednictvím metody `isEmpty`.
Tato metoda kontroluje, zda instance obsahuje všechny potřebné prvky.
Například pro problém 3-SAT kontroluje, zda formule obsahuje alespoň jednu proměnnou a jednu klauzuli.

Chybové zprávy jsou vraceny jako typ `ErrorMessage`,
který v případě chyby obsahuje textový popis problému
a v případě úspěchu je hodnota `null`.


== Implementace redukcí

Každá redukce je implementována jako samostatná třída rozšiřující abstraktní třídu `Reducer`.
Třída `Reducer` definuje společné rozhraní pro všechny redukce:

```
export abstract class Reducer<I extends ProblemInstance, O extends ProblemInstance> {
    constructor(public inInstance: I) {}
    
    public reduce(): ReductionResult<I, O>
}
```

Metoda `reduce` kontroluje, zda vstupní instance není prázdná,
a následně volá abstraktní metodu `doReduce`,
která je implementována v každé konkrétní redukci.

Výsledkem redukce je datová struktura `ReductionResult` obsahující
výstupní instanci a seznam kroků redukce.
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


== Řešení problémů

Pro nalezení odpovědi na rozhodovací otázku je využito rozhraní `Solver`,
které definuje metodu `solve` vracející buď certifikát řešení,
nebo konstantu `Unsolvable`.

Každý solver je navržen jako samostatná třída implementující toto rozhraní:

```
export interface Solver<I extends ProblemInstance, C extends Certificate> {
    instance: I;
    solve(): C | Unsolvable;
}
```

=== Řešení problému 3-SAT

Solver `Solver3SAT` využívá algoritmus DPLL,
který kombinuje rozhodování s propagací omezení.

Algoritmus DPLL se skládá z následujících kroků:

1. Kontrola, zda jsou všechny klauzule splněny.
2. Kontrola, zda některá klauzule nemůže být splněna.
3. Unit propagation: přiřazení poslední nepřiřazené proměnné v unit klauzuli.
4. Pure literal elimination: přiřazení proměnné, která se vyskytuje pouze v jedné polaritě.
5. Rekurzivní větvení na nejpřiřazenější proměnnou.

Metoda `isClauseSatisfied` kontroluje, zda je klauzule splněna.
Metoda `isUnitClause` identifikuje unit klauzule.
Metoda `findPureLiteral` hledá čisté literály.

=== Řešení problému HCYCLE

Solver `SolverHCYCLE` využívá backtrackingový algoritmus
procházející možné orientované cesty v grafu.

Algoritmus nejprve sestaví seznam sousednosti pro rychlé vyhledávání.
Počáteční vrchol je libovolně zvolen jako první vrchol grafu.
Algoritmus se rekurzivně pokouší rozšířit aktuální cestu o nepoužité sousední vrcholy.

Po návratu z rekurze algoritmus backtrackuje,
tj. odstraňuje poslední vrchol z cesty a zkouší jiného souseda.

Po úspěšném nalezení cesty obsahující všechny vrcholy
algoritmus kontroluje, zda poslední vrchol má hranu zpět do počátečního vrcholu.

=== Řešení problému HCIRCUIT

Solver `SolverHCIRCUIT` využívá modifikovaný backtrackingový algoritmus
pro neorientované grafy.

Algoritmus se liší od řešení HCYCLE tím, že hrany jsou neorientované,
tj. graf je možné procházet oběma směry.

=== Řešení problému SSP

Solver `SolverSSP` využívá dynamické programování.

Algoritmus nejprve inicializuje tabulku `dp`
mapující dosažitelné součty na indexy použitých čísel.
Základní případ nastavuje součet 0 jako dosažitelný.

V každé iteraci algoritmus prochází aktuálně dosažitelné součty
a zkouší přidat aktuální číslo.
Pokud nový součet ještě není dosažitelný, je přidán do tabulky.

Po vyčerpání všech čísel algoritmus kontroluje, zda je cílový součet dosažitelný.
Pokud ano, rekonstruuje nalezenou podmnožinu zpětným procházením tabulky.

=== Řešení problému TSP

Solver `SolverTSP` využívá bitmaskový dynamický programování.

Algoritmus nejprve sestaví matici vzdáleností z vah hran grafu.
Následně inicializuje tabulku `dp` pro dynamické programování,
kde `dp[mask][last]` reprezentuje minimální cenu cesty
procházející vrcholy specifikované maskou `mask` a končící ve vrcholu `last`.

Algoritmus iterativně rozšiřuje cesty přidáváním nových vrcholů.
Po naplnění tabulky nalezne minimální cenu uzavřené cesty
a rekonstruuje nalezenou cestu pomocí tabulky rodičů.

=== Řešení problému 3-CG

Solver `Solver3CG` využívá backtrackingový algoritmus přiřazující barvy vrcholům.

Algoritmus nejprve sestaví seznam sousednosti grafu.
Následně rekurzivně prochází vrcholy a pro každý vrchol zkouší tři barvy.
Před přiřazením barvy kontroluje, zda žádný sousední vrchol nemá stejnou barvu.

Po neúspěchu algoritmus backtrackuje a zkouší jinou barvu.


== Dekódování řešení

Dekódování řešení slouží k převodu certifikátu výstupní instance
zpět na certifikát vstupní instance.
Každý dekoder implementuje rozhraní `Decoder` definované jako:

```
export interface Decoder<O extends ProblemInstance, OC extends Certificate, IC extends Certificate> {
    decode(outInstance: O, outCert: OC): IC;
}
```

=== Dekódování řešení HCYCLE na 3-SAT

Dekoder `DecoderHCYCLEto3SAT` analyzuje nalezený hamiltonovský cyklus
a rekonstruuje ohodnocení booleovských proměnných.

Algoritmus prochází vrcholy v nalezené cestě.
Pokud vrchol začíná prefixem `NODE_ID_PREFIX_TRUE`,
je příslušná proměnná nastavena na hodnotu pravda.
Pokud vrchol začíná prefixem `NODE_ID_PREFIX_FALSE`,
je příslušná proměnná nastavena na hodnotu nepravda.

Název proměnné je extrahován odstraněním příslušného prefixu
a následné části identifikátoru obsahující pořadové číslo vrcholu.

=== Dekódování řešení SSP na 3-SAT

Dekoder `DecoderSSPto3SAT` analyzuje nalezenou podmnožinu čísel
a rekonstruuje ohodnocení booleovských proměnných.

Proměnná je nastavena na pravdu, pokud je v podmnožině přítomno
odpovídající číslo $nu_T$.
Proměnná je nastavena na nepravdu, pokud je v podmnožině přítomno
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


== Použité technologie

Implementace je napsána v jazyce TypeScript,
který rozšiřuje JavaScript o statické typování.
TypeScript umožňuje lepší kontrolu nad strukturou dat
a snižuje pravděpodobnost vzniku chyb při vývoji.

Aplikace je postavena na frameworku SvelteKit,
který poskytuje komponentově orientovaný přístup k tvorbě uživatelského rozhraní
a podporu pro routing a serverovou renderaci.

Pro vizualizaci grafových struktur je využita knihovna Cytoscape.js,
která nabízí rozsáhlé možnosti konfigurace vykreslování grafů.

Matematické výrazy jsou vykreslovány pomocí knihovny KaTeX,
která převádí LaTeX syntaxi na HTML reprezentaci.
Toto umožňuje prezentovat formální popisy redukcí
včetně matematických vzorců přímo ve webovém prohlížeči.

Pro sestavení aplikace je využit nástroj Vite,
který poskytuje rychlý vývojový server a optimalizovanou produkční sestavení.
