= Redukce mezi vybranými problémy 

/*
*Purpose:* 
- Core theoretical contribution of the thesis.
- Create one subsection per reduction.

For each:
- High-level idea of the reduction
- Step-by-step conceptual explanation
- Proof sketch of correctness:
  - If original instance is YES -> reduced instance is YES
  - If reduced instance is YES -> original instance is YES
- Time complexity argument (polynomial)
- Focus on *understanding*, not minimal formal proofs
*/

V této práci jsem se rozhodl zaměřit se na následující převody mezi problémy:
- redukce problému 3-SAT na problémy HCYCLE, SSP a 3-CG
- redukce problému HCYCLE na problém HCIRCUIT
- redukce problému HCIRCUIT na problém TSP

Pro každý převod si popíšeme algoritmus s polynomialním časem, 
který převede každou instanci problému $A$ na instanci problému $B$. 
Nejprve si vyjádříme základní myšlenku algoritmu, 
potom konceptuálně popíšeme jeho kroky   
a dokážeme korektnost algorimu (zachovává odpověď pro obě instance).
Nakonec si ukážeme, že má polynomiální časovou složitost.

Téměř ve všech algoritmech, které si popíšeme, 
se používá tvz. gadget. 
Gadget 
  (česky jako přístroj, zařízení, 
  lidově a možná vystyžněji jako vychytávka, udělátko)
je část (podjednotka, podmnožina) instance problému, 
která simuluje chování nějaké jednotky instance jiného problému.
Pro převody na grafové problémy 
budou gadgety mít podobu podgrafů výsledného grafu, 
který je instancí grafového problému.
Pro převody na SSP 
budou gadgety přímo čísla vstupní množiny čísel a výsledná hodnota, 
které společně představují instanci problému SSP.

== Redukce 3-SAT na HCYCLE

Algoritmus pro převod instance problému 3-SAT na instanci problému HCYCLE
spočívá ve vykonstruování gadgetů pro proměnné a klauzule v podobě podgrafů,
které výsledně spojíme tak, aby se zachovala odpověď.

Výsledkem bude orientovaný graf, který obsahuje hamiltonovský cyklus
tehdy a pouze tehdy, je-li vstupní instance problému 3-SAT splitelná.

Gadgety proměnných mají podobu grafu cesty, který vede oběma směry. 
Má tedy podobu neorientovaného grafu cesty, 
ale, protože je výsledný graf je orientovaný, 
musíme poskytnout hrany do obou směrů.
Počet vrcholů těchto gadgetů musí být dostatečný na to, 
abychom je byly schopni správně spojit s gadgety klauzulí.

Tyto gadgety jsou spojeny v sérii. 
Průchod tímto grafem je nyní ekvivalentní k ohodnocení proměnných.
V našem případě si můžem např. zvolit, že průchod levou hranou bude znamenat
ohodnocení dané proměnné na `True` a pravou `False`.
Jakmile zvolíme jednou z hran, nemůžeme naše rozhodnutí vrátit.
Každá proměnná bude validním průchodem nastavená na právě jednu pravdivostní hodnotu.

Gadget klauzule má jeden jediný vrchol. 
Hrany vedou z a do gadgetů proměnných, 
vždy mezi dvěma sousedními vrcholy gadgetu proměnné,
a to na základě literálů vyskytujicích se ve vstupní formuli.
Vyskutuje-li se literál neznegovaný, 
přídáme hrany z gadgetu proměnné a tímto vrcholem tak,
že hrana, která směřuje k vrcholu klauzule bude nalevo od hrany 
směřující od vrcholu klauzule.
A naopak, je-li literál znegovaý, přidáme hrany tak, 
že hrana směřující do vrcholu klauzule bude napravo od hrany směřující od něj.

Touto konstrukcí zaručíme to, že vrchol klauzule je dosažitelný, 
je-li alespoň jeden literál ze tří splněn.

== Redukce 3-SAT na SSP

V této redukci chceme převést booleovskou formuli $Phi$ ve 3-KNF 
na množinu čísel $S$ a cílovou hodnotu $tau$.
Maximální počet cifer čísel $k$ a jejich počet $|S|$
záleží na jak počtu klauzulí $v$, tak na počtu proměnných $c$ ve formuli $Phi$.

$
  k &= v + c \
  |S| &= 2(v + k)
$

Cílovou hodnotu $tau$ nastavíme na 
$sum_(i=0)^(v)(1 dot 10^(i+c)) + sum_(i=0)^(c)(3 dot 10^(i))$.
Pro $v = 5, c = 3$ bude $tau = 11111333$. 
Prvních $v$ cifer jsou všechny rovny jedné. Zbylé jsou rovny třema.

Ohodnocení proměnných na jednu z pravdivostních hodnot
lze reprezentovat jako čísla, pokud pro každou proměnnou $nu_i in Phi$ pro $0 <= i < v $
budeme mít dvě čísla, $nu_i^T$ a $nu_i^F$, která mají i-tou cifru rovnou jedné.
Tím zaručíme, že ve finální podmnožině $S'$  musí být právě jedno z těchto čísel, 
aby suma čísel ve $S'$ měla i-tou číslici rovnou jedné tak, jak je to v $tau$.
Tyto čísla mají prozatím všechny ostatní cifry nulové.

Splnění klauzule $kappa_j in Phi, 0 <= j < c$ reprezentujeme následovně.
Je-li proměnná $nu$ přítomná v klauzuli $kappa_j$,
nastavíme cifru na pozici $v + j$ na jedna
pro číslo $nu^T$, pokud v klauzuli není znegovaná, 
jinak jej nastavíme pro číslo $nu^F$.
Máme-li klauzuli $kappa_j = (not alpha, beta, gamma)$, 
vybráním alespoň jednoho z čísel $alpha^F$, $beta^T$ nebo $gamma^T$
docílíme toho, že klauzule bude splněná.
Neboť pokud vybereme alespoň jedno z těchto čísel do finální podmnožiny $S'$,
bude cifra finální sumy na pozici $v + j$ větší než 0.

Pokud vybereme jedno, dvě nebo tři čísla, cifra bude rovna jedné, dvěma nebo třema v tomto pořadí.
Ve cílové hodnotě $tau$ jsou však tyto cifry rovny třema. 
Musíme proto zajistit, že pokud je tato cifra v sumě podmnožiny $S'$ větší nule, 
musí být možné vybrat (další) čísla tak, že cifra bude rovna třema.
Nejjednodušším řešením je přidat dvě "vyrovnávací" čísla pro každou klauzuli $kappa_j$.
Cifry těchto čísel jsou na pozici $v + j$ rovny jedné a všechny ostatní cifry jsou rovny nule.
V případě, že cifra sumy podmnožiny $S'$ na pozici $[v, k)$ je větší nule 
(je rovna buď jedné, dvěma, nebo třema), bude díky vyrovnávacím číslum 
možné dosáhnout hodnoty tři pro danou cifru.




== Redukce 3-SAT na 3-CG

Převod vstupní instance problému 3-SAT, 
booleovská formule $Phi$ ve 3-KNF, 
na instanci problému 3-CG, neorientovaný graf $G$,
vyžaduje konstrukci několika typů gadgetů:
- jádrový gadget,
- gadgety proměnných a
- gadgety klauzulí.

Jádrový gadget se skládá ze tří vrcholů: $T$, $F$ a $B$.
Vrcholy jsou propojeny do cyklu hranami: 
${T,B}$, ${F,B}$ a ${T,F}$.

Gadget proměnné se vytvoří pro každou proměnnou $x$ formule $Phi$ a 
skláda se ze tří vrcholů: $x$, $not x$ a $B$ vyskytujicí se v jádrovém gadgetu.
Tyto vrcholy tvoří cyklus, tedy jsou propojeny hranami: 
${x, not x}$, ${x, B}$ a ${not x, B}$.

Gadget klauzule se vytvoří pro každou klauzuli $kappa in Phi$.
Klauzule $kappa$ obsahuje tří literály proměnných,
$kappa = {Alpha, Beta, Gamma}$, kde $Alpha$, $Beta$ a $Gamma$, 
jsou literály proměnných $alpha$, $beta$ a $gamma$, v tomto pořadí.
Literály, značené velkými řeckými písmeny, 
mohou být v jednom ze dvou možných stavů - neznegované, nebo znegované.
Např. pod literálem $Alpha$ může být buď $alpha$, nebo $not alpha$.
Gadget klauzule obsahuje 
6 vlastních vrcholů,  
3 vrcholy z gadgetů proměnných a
2 vrcholy z jádra:

$
  kappa_0,
  kappa_1,
  kappa_2,
  kappa_3,
  kappa_4,
  kappa_5,
  Alpha, Beta, Gamma, 
  T,
  F.
$

Tyto vrcholy jsou spojeny hranami:

$
  &{Alpha, kappa_0},
  {Beta, kappa_1},
  {Gamma, kappa_2}, \
  &{kappa_0, kappa_3},
  {kappa_1, kappa_4},
  {kappa_2, kappa_5},
  {kappa_3, kappa_4},
  {kappa_4, kappa_5}, \
  &{T, kappa_0},
  {T,kappa_1},
  {T,kappa_2},
  {T,kappa_3},
  {kappa_5, F}.
$

== Redukce HCYCLE na HCIRCUIT

Pro každý vrchol ve vstupním orientovaném grafu $G$, 
vykonstrujujeme podgraf skládajicí se ze tří vrcholů ($v_i$, $v_b$, $v_o$), které spojíme do podoby cesty.

Pro každou hranu $(x,y) in E(G)$, spojíme vrcholy 
$x_o$ a $y_i$.

== Redukce HCIRCUIT na TSP

Vrcholy ze vstupního grafu $G = (V_G,E_G)$ problému HCIRCUIT
zkopírujeme do grafu $H = (V_H,E_H)$ a přidáme hranu mezi každým z nich.
Tím vytvoříme kompletní graf. 
Poté všechny hrany ohodnotíme. 
Pokud pro hranu $e = {x,y} in E_H$ existuje odpovídajicí hrana ${x,y} in E_G$,
bude hrana $e$ ohodnocena vahou 1, 
jinak bude mít váhu větší než 1 (v našem případě 2).






