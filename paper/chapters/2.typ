#import "/lib/global.typ": *
#import "/czech-declension/out.typ": inflected as inf
#import "@preview/diagraph:0.3.6": *

#set math.equation(numbering: "1.")

#let rozhod-forma = heading(level: 3, outlined: false, numbering: none)[Vyjádření problému jako rozhodovacího]
#let kladna-odpo = heading(level: 3, outlined: false, numbering: none)[Instance s kladnou odpovědí]
#let zaporna-odpo = heading(level: 3, outlined: false, numbering: none)[Instance se zápornou odpovědí]
#let opt-pr-instance = heading(level: 3, outlined: false, numbering: none)[Příklady instancí problému]

= Vybrané NP-úplné problémy

Tato kapitola představuje vybrané NP-úplné problémy, 
se kterými pracuje navržený systém. 
Pro každý problém je uvedena 
jeho formální definice, 
popis vstupu 
a formulace rozhodovací otázky. 
Ukážeme si také konkrétní  
  instance těchto problémů s kladnou odpovědí 
  i instance se zápornou odpovědí. 

#let ham_cyklus_kruznice = [
  Obecně se pojem hamiltonovský cyklus vztahuje jak na orientované, tak na neorientované grafy.
  Pro zachování přehlednosti a terminologické jednoznačnosti 
  však budeme v této práci používat následující konvenci:
  - pojem hamiltonovský cyklus bude používán výhradně pro orientované grafy,
  - pojem hamiltonovská kružnice bude používán výhradně pro neorientované grafy.

  V obou případech budeme o grafu říkat, že je hamiltonovský, 
  pokud obsahuje hamiltonovský cyklus (v případě orientovaného grafu), 
  resp. hamiltonovskou kružnici (v případě grafu neorientovaného).
]

V této práci se zaměřujeme na následující NP-úplné problémy:
- 3-SAT -- splnitelnost booleovské formule v 3-konjunktivní normální formě,
- HCYCLE -- existence hamiltonovského cyklu v orientovaném grafu,
- HCIRCUIT -- existence hamiltonovské kružnice #footnote[#ham_cyklus_kruznice] v neorientovaném grafu,
- TSP -- problém obchodního cestujícího v rozhodovací verzi,
- SSP -- problém podmnožinového součtu,
- 3-CG -- 3-obarvitelnost vrcholů grafu.

Tyto problémy slouží jako základní stavební kameny 
pro demonstraci redukcí a jejich vizualizaci.


== 3-SAT

Problém splnitelnosti booleovské formule v 3-konjunktivní normální formě 
(3-Satisfiability, 3-SAT) 
je definován následovně.

Uvažujeme booleovskou formuli 
$
  Phi = (cal(V), cal(K)),
$
kde $cal(V)$ je množina booleovských proměnných 
a $cal(K)$ je množina klauzulí v 3-konjunktivní normální formě (3-KNF), 
tedy takové, že každá klauzule obsahuje právě tři literály.

Každou klauzuli $kappa in cal(K)$ 
lze chápat jako množinu obsahujicí právě 3 literály 
#footnote[
  Literál představuje výskyt booleovské proměnné ve formuli. 
  Proměnná se může vyskytovat buď v neznegované, nebo v negované podobě.
]. 
Klauzuli budeme značit 
$
  kappa = {alpha, beta, gamma},
$ 
kde $alpha$, $beta$ a $gamma$ jsou literály 
odpovídajicí booleovským proměnným $a$, $b$ a $c$ v tomto pořadí, 
přičemž každý z literálu může být případně znegován.

Pro ilustraci uvažujme následujcí instanci problému: 
$
  (a or b or c) and (x or y or z) and (not x or not b or c).
$

V tomto případě mají množiny $cal(V)$ a $cal(K)$ následujicí podobu:
$
  cal(V) &= {a,b,c,x,y,z} \
  cal(K) &= {{a,b,c},{x,y,z},{not x,not b,c}}
$

Zaměřme se na poslední klauzuli $(not x or not b or c)$.
Tato klauzule odpovídá prvku ${not x, not b, c}$ v množině $cal(K)$, kde
literály $not x$, $not b$ a $c$ představují výskyty booleovských proměnných 
a $x$, $b$ a $c$ v dané klauzuli.

Zápis $cal(V)(Phi)$ označuje množinu všech booleovských proměnných formule $Phi$,
zatímco $cal(K)(Phi)$ označuje množinu jejích klauzulí.

Pravdivostní hodnoty jsou v této práci vyjadřovány různými způsoby: 
  pravdivá hodnota je značena jako Pravda, True, $T$ nebo $1$, 
  zatímco nepravdivá hodnota je značena jako Nepravda, False, $F$ nebo $0$.

Formule $Phi$ se nazývá splitelná, 
pokud existuje ohodnocení booleovských proměnných, 
při němž se celá formule vyhodnotí jako pravdivá.
Ekvivalentně lze říci, že splnitelnost nastává tehdy, 
je-li splněna každá klauzule z množiny $cal(K)$.

#rozhod-forma

/ Vstup: 
  Booleovská formule $Phi = (cal(V), cal(K))$ ve 3-KNF.

/ Otázka: 
  Je fomule $Phi$ splitelná?

#kladna-odpo

Mějme booleovský výraz ve 3-KNF
$
  (x or y or z) and (not x or not y or not z).
$

V množinovém zápise by tento výraz vypadal následovně

$
  Phi = (cal(V), cal(K)) quad cal(V) = {x,y,z} quad cal(K) = {{x,y,z},{not x, not y, not z}}.
$

Jedno z možných ohodnocení, které splňuje formuli $Phi$, je
$
  x = 1, y = 0, z = 0.
$

#zaporna-odpo

Mějme booleovký výraz
$
  (!x or !x or !x) and
  (!y or !y or x) and
  (!x or !x or y) and
  (x or x or x).
$

Jeho podoba v množinovém zápise je

$
  Phi = (cal(V), cal(K)) \
  cal(V) = {x,y} \
  cal(K) = {{not x, not x, not x}, {not y, not y, x}, {not x, not x, y}, {x, x, x}}.
$

Tento výraz je kontradikcí, protože pro libovolné ohodnocení jeho proměnných nebude nikdy splňen.
Výraz $Phi$ je nesplnitelný.

#figure(
  table(
    columns: 3,
    row-gutter: (2pt, auto),
    [$x$], [$y$], [$Phi$],
    [0], [0], [0],
    [0], [1], [0],
    [1], [0], [0],
    [1], [1], [0],
  ), 
  caption: [Všechny možné ohodnocení proměnných - vede ke kontradikci]
) <bool-assignment-contradiction>


== HCYCLE

Uvažujme orientovaný graf
$
  G = (V,E),
$
kde $V$ je množina vrcholů a $E subset.eq V times V$ je množina orientovaných hran.

Problém hamiltonovského cyklu (Hamiltonian Cycle Problem, HCYCLE) spočívá v určení, 
zda graf $G$ obsahuje hamiltonovský cyklus, 
tj. posloupnost vrcholů

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1)
$

která splňuje následující podmínky:

- každý vrchol z množiny $V$ se v posloupnosti $P$ vyskytuje právě jednou 
  (s výjimkou počátečního a koncového vrcholu $v_1$),

- pro každé $1 <= i < |V|$ platí $(v_i,v_(i+1)) in E$

Jinými slovy, hamiltonovský cyklus je orientovaná uzavřená cesta, 
která prochází všemi vrcholy grafu právě jednou.
Graf, který hamiltonovský cyklus obsahuje, nazýváme hamiltonovský graf.

#rozhod-forma
/ Vstup: 
  Orientovaný graf $G = (V,E)$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovký cyklus?

#kladna-odpo

Mějme graf $G = (V,E)$, kde

$
  V = {A,B,C,D,E,F} \
  E = {
    {A , C},
    {B , D},
    {C , E},
    {A , B}, 
    {B , C}, \
    {C , D}, 
    {D , E}, 
    {E , F}, 
    {F , A}
  }.
$

#figure(
  raw-render(```dot
    digraph CycleWithExtraEdges {
      layout=neato
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -> C
      B -> D
      C -> E

      edge [color=red penwidth=2]
      A -> B 
      B -> C 
      C -> D 
      D -> E 
      E -> F 
      F -> A 
    }
  ```),
  caption: [Instance problému HCYCLE se kladnou odpovědí],
)

Graf $G$ je hamiltonovský, protože obsahuje hamiltonovský cyklus popsán uzavřenou cestou
$
  P = (A,B,C,D,E,F,A).
$

#zaporna-odpo

Mějme graf stromu

#figure(
  raw-render(```dot
    digraph Tree {
      layout=dot
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -> B
      A -> C
      B -> D
      B -> E
      C -> F
    }
  ```),
  caption: [Instance problému HCYCLE se zápornou odpovědí],
)

Tento graf neobsahuje hamiltonovský cyklus, 
protože je acyklický.


== HCIRCUIT

Problém hamiltonovské kružnice (Hamiltonian Circuit, HCIRCUIT) 
je obdobou problému HCYCLE definováný pro neorientované grafy.

Uvažujme neorientovaný graf
$
  G = (V,E),
$

kde $V$ je množina vrcholů 
a $E subset.eq {{u,v} | u,v in V and u eq.not v}$
je množina neorientovaných hran,
přičemž každá hrana spojuje dva různé vrcholy.

Řekneme, že graf $G$ obsahuje hamiltonovskou kružnici, 
pokud v něm existuje uzavřená cesta, 
která prochází každým vrcholem grafu právě jednou.

#rozhod-forma
/ Vstup: 
  Neorientovaný graf $G = (V,E)$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovskou kružnici? 

// #kladna-odpo
// #zaporna-odpo




== TSP

Uvažujme ohodnocený neorientovaný graf 
$
  G = (V,E),
$ 
kde $V$ je množina vrcholů a $E subset.eq {{u,v} | u,v in V and u eq.not v}$
je množina neorientovaných hran
Každé hraně je přiřazena nezáporná váha pomocí funkce

$
  w : E -> NN.
$

Problém obchodního cestujicího (Traveling Salesman Problem, TSP) je optimalizační problém,
jehož cílem je nalézt hamiltonovskou kružnici v grafu $G$ 
s minimální celkovou cenou, kde cena kružnice je dána součtem vah jejích hran.

Stejně jako každý optimalizační problém lze i TSP převést na odpovídající problém rozhodovací.

Řekneme, že graf $G$ obsahuje hamiltonovskou kružnici s cenou nejvýše $k in NN$, 
pokud existuje posloupnost vrcholů

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1),
$

která splňuje:
- každý vrchol z množiny $V$ se v posloupnosti $P$ vyskytuje právě jednou 
  (s výjimkou počátečního a koncového vrcholu $v_1$),
- pro každé $i$, kde $1 <= i < |V|$, platí ${v_i,v_(i+1)} in E$,

- celková cena kružnice splňuje $sum_i^(|V|) w({v_i, v_(i+1)}) <= k$

Abychom získali optimální řešení, 
  kterou je uzavřená cesta s nejnižší cenou splňující zmíněné podmínky, 
budeme hodnotu $k$ snižovat do té doby, než bude odpověď záporná.
V tu chvíli víme, že cena optimální cesty je $k + 1$ a žádná jiná cesta s nižší cenou neexistuje.

#rozhod-forma

/ Vstup: 
  Ohodnocený neorientovaný graf $G$ a konstanta $k in NN$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovskou kružnici s cenou nejvýše $k$?

#opt-pr-instance

Mějme graf $G = (V,E)$

#figure(
  raw-render(```dot
    graph {
      rankdir=LR
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      edge [label="2"]
      A -- F
      B -- D 
      C -- E

      edge [label="1"]
      A -- B 
      B -- C 
      C -- D 
      D -- E 
      E -- F 
      F -- A 
    }
  ```),
  caption: [Instance problému TSP - ohodnocený neorientovaný graf],
)

Pro $k = 8$ existuje možné řešení 
a odpověď na rozhodovací otázku je kladná.

#figure(
  raw-render(```dot
    graph {
      rankdir=LR
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -- F [label="2"]
      B -- D [color=red penwidth=2 label="2"]
      C -- E [color=red penwidth=2 label="2"]
      A -- B [color=red penwidth=2 label="1"]
      B -- C [label="1"]
      C -- D [color=red penwidth=2 label="1"]
      D -- E [label="1"]
      E -- F [color=red penwidth=2 label="1"]
      F -- A [color=red penwidth=2 label="1"]
    }
  ```),
  caption: [Řešení problému TSP pro $k = 8$],
)

Pro $k = 6$ existuje také možné řešení. Odpověď na rozhodovací otázku je kladná.

#figure(
  raw-render(```dot
    graph {
      rankdir=LR
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A -- F [label="2"]
      B -- D [label="2"]
      C -- E [label="2"]
      A -- B [color=red penwidth=2 label="1"]
      B -- C [color=red penwidth=2 label="1"]
      C -- D [color=red penwidth=2 label="1"]
      D -- E [color=red penwidth=2 label="1"]
      E -- F [color=red penwidth=2 label="1"]
      F -- A [color=red penwidth=2 label="1"]
    }
  ```),
  caption: [Řešení problému TSP pro $k = 6$],
) <tsp-opt-reseni>

Pro $k = 5$ žádné řešení neexistuje, tudíž odpověď na rozhodovací otázku je záporná
a nejnižší dosažitelná cena je $k + 1 = 5 + 1 = 6$.
Cesta $(A,B,C,D,E,F,A)$ zobrazená na @tsp-opt-reseni[obrázku] je optminálním řešením.



== SSP

Problém SSP (Subset Sum Problem, SSP) spočívá v určení, zda pro danou konečnou množinu přirozených čísel
$
  S subset.eq NN
$ 
a cílovou hodnotu $tau in NN$ existuje podmnožina $S' subset.eq S$, 
jejíchž součet prvků je roven dané cílové hodnotě $tau$.

$
  sum_(s in S') s = tau
$

#rozhod-forma

/ Vstup:
  Konečná množina přirozených čísel $S subset.eq NN$ a cílová hodnota $tau in NN$.

/ Otázka:
  Existuje podmnožina $S' subset.eq S$ taková, 
  že součet jejích prvků je roven $tau$?

#kladna-odpo

Mějme množinu čísel
$
  S = {3,7,10,5}
$
a cílovou hodnotu $tau = 15$.

Validním řešením je $S' = {10,5}$, protože $10 + 5 = 15$.
Dalším možným je $S'' = {3,7,5}$, protože $3 + 7 + 5 = 15$.


#zaporna-odpo

Mějme množinu čísel
$
  S = {3,5,11}
$
a cílovou hodnotu $tau = 10$.

Tato instance nemá řešení. 
Ať už vybereme jakoukoli kombinaci prvků z množiny $S$, 
nikdy nebude součet těchto prvků roven $10$.

$
  S' subset.eq S \
  S' in {emptyset, {3}, {5}, {11}, {3,5}, {3,11}, {5,11}, {3,5,11}} \
  sum_(s in S') s != 10
$


== 3-CG

Uvažujme neorientovaný graf
$G = (V,E)$,
kde kde $V$ je množina vrcholů
a $E subset.eq {{u,v} | u,v in V and u eq.not v}$.
Nechť $K = {R,G,B}$ je množina tří barev, například červené, zelené a modré.

Problém barvení grafu třemi barvami (3-Coloring, 3-CG) spočívá v určení, 
zda existuje zobrazení
$
  kappa : V -> K,
$
které každému vrcholu přiřadí právě jednu barvu tak, 
aby žádné dva sousední vrcholy neměly stejnou barvu.

Formálně požadujeme, aby pro každou hranu ${u,v} in E$ platilo 
$kappa(u) eq.not kappa(v)$.

#rozhod-forma

/ Vstup: Neorientovaný graf $G = (V,E)$.

/ Otázka: Lze vrcholy grafu obarvit 3 barvami tak, aby žádné dvě sousední nesdíleli stejnou barvu?

#kladna-odpo

Mějme neorientovaný graf $G = (V,E)$, kde
$
  V = {A,B,C,D,E} \
  E = {{A,B}, {A,C}, {B,C}, {B,D}, {C,E}, {D,E}}.
$

#figure(
  raw-render(```dot
    graph {
      layout=neato
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]
    
      A -- B
      A -- C
      B -- C
      B -- D
      C -- E
      D -- E
    }
  ```),
  caption: [Instance problému 3-CG s kladnou odpovědí],
)

Pro tento graf existuje řešení, existuje validní předpis funkce $kappa : V -> K$

$
  A -> R \
  B -> G \
  C -> B \
  D -> R \
  E -> G. \
$


#figure(
  raw-render(```dot
    graph {
      layout=neato
      
      node [
        shape=circle 
        width=0.1
        penwidth=2
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]

      A [color=red]
      B [color=green]
      C [color=blue]
      D [color=red]
      E [color=green]
    
      A -- B
      A -- C
      B -- C
      B -- D
      C -- E
      D -- E
    }
  ```),
  caption: [Validní obarvení grafu třemi barvami],
)


#zaporna-odpo

Mějme neorientovaný graf $G = (V,E)$, kde
$
  V = {A,B,C,D} \
  E = {{A,B}, {A,C}, {A,D}, {D,C}, {B,D}, {B,C}}.
$


#figure(
  raw-render(```dot
    graph {
      layout=neato
      
      node [
        shape=circle 
        width=0.1
      ]

      edge [
        color=gray30
        penwidth=1
        style=solid
      ]
    
      node [penwidth=2]
      A [color=red]
      B [color=blue]
      C [color=green]

      node [penwidth=1]
      D [xlabel="nezbývá žádná barva"]

      A -- B
      A -- C
      A -- D
      B -- C
      B -- D
      C -- D
    }
  ```),
  caption: [Instance problému 3-CG se zápornou odpovědí],
)

Pokud obarvíme vrcholy $A$, $B$ a $C$ každý jinou barvou, 
nezbyde nám žádná barva pro vrchol $D$.
Nemůžeme jej nabarvit žadnou ze 3 barev, 
protože je incidentní ke všem ostatním vrcholům.

