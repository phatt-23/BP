== Řešení problémů

Pro nalezení odpovědi na rozhodovací otázku je využito rozhraní `Solver`,
které definuje metodu `solve` vracející buď certifikát řešení,
nebo konstantu `Unsolvable`.

Každý solver je navržen jako samostatná třída implementující toto rozhraní:

```
export interface Solver<
  I extends ProblemInstance, 
  C extends Certificate
> {
    instance: I;
    solve(): C | Unsolvable;
}
```

=== Řešení problému 3-SAT

Solver `Solver3SAT` využívá algoritmus DPLL #footnote[https://en.wikipedia.org/wiki/DPLL_algorithm].


=== Řešení problému HCYCLE

Solver `SolverHCYCLE` využívá backtrackingový algoritmus
procházející možné orientované cesty v grafu.

Algoritmus nejprve sestaví seznam sousednosti /*linked list*/ pro rychlé vyhledávání.
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
tj. je možné jimi procházet oběma směry.


=== Řešení problému SSP

Solver `SolverSSP` využívá dynamické programování.

Algoritmus nejprve inicializuje tabulku `dp`
mapující dosažitelné součty na indexy použitých čísel.
Základní případ nastavuje součet 0 jako dosažitelný.

V každé iteraci algoritmus prochází aktuálně dosažitelné součty
a zkouší přidat aktuální číslo.
Pokud nový součet ještě není dosažitelný, 
je přidán do tabulky.

Po vyčerpání všech čísel algoritmus kontroluje, 
zda je cílový součet dosažitelný.
Pokud ano, 
rekonstruuje nalezenou podmnožinu zpětným procházením tabulky.


=== Řešení problému TSP

Solver `SolverTSP` využívá bitmaskové dynamické programování.

Algoritmus nejprve sestaví matici vzdáleností z vah hran grafu.
Následně inicializuje tabulku `dp` pro dynamické programování,
přičemž `dp[mask][last]` reprezentuje minimální cenu cesty
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


