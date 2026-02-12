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
