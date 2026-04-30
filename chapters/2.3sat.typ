#import "./2.common.typ": *

#set math.equation(numbering: "(1)")

== 3-SAT

Problém splnitelnosti booleovské formule v 3-konjunktivní normální formě 
(3-Satisfiability, 3-SAT) 
je definován následovně.

Uvažujeme booleovskou formuli:
$
  Phi = (cal(V), cal(K)),
$
kde $cal(V)$ je množina booleovských proměnných 
a $cal(K)$ je množina klauzulí,
z nichž každá obsahuje právě tři literály
#footnote[
  Literál představuje výskyt booleovské proměnné ve formuli. 
  Proměnná se v ní může vyskytovat buď v neznegované, nebo v znegované podobě.
]. 

Každou klauzuli $kappa in cal(K)$ 
lze chápat jako množinu obsahující právě 3 literály.
Klauzuli budeme tedy značit:
$
  kappa = {alpha, beta, gamma},
$ 
kde $alpha$, $beta$ a $gamma$ jsou literály 
odpovídající booleovským proměnným $a$, $b$ a $c$ v tomto pořadí, 
přičemž každý z literálů může být případně znegován.

Pro ilustraci uvažujme následující instanci problému: 
$
  (a or b or c) and (x or y or z) and (not x or not b or c).
$

V tomto případě mají množiny $cal(V)$ a $cal(K)$ následující podobu:
$
  cal(V) &= {a,b,c,x,y,z} \
  cal(K) &= {{a,b,c},{x,y,z},{not x,not b,c}}
$

Zaměřme se na poslední klauzuli $(not x or not b or c)$.
Tato klauzule odpovídá prvku ${not x, not b, c}$ v množině $cal(K)$, kde
literály $not x$, $not b$ a $c$ představují výskyty booleovských proměnných 
$x$, $b$ a $c$ v dané klauzuli.

Zápis $cal(V)(Phi)$ označuje množinu všech booleovských proměnných formule $Phi$,
zatímco $cal(K)(Phi)$ označuje množinu jejích klauzulí.

Pravdivostní hodnoty jsou v této práci vyjadřovány zpravidla jako
$T$ pro pravdivou hodnotu a
$F$ pro nepravdivou hodnotu.

Formule $Phi$ se nazývá splnitelná, 
pokud existuje ohodnocení booleovských proměnných, 
při němž se celá formule vyhodnotí jako pravdivá.
Ekvivalentně lze říci, že splnitelnost nastává tehdy, 
je-li splněna každá klauzule z množiny $cal(K)$.

#rozhod-forma

/ Vstup: 
  Booleovská formule $Phi = (cal(V), cal(K))$ ve 3-KNF.

/ Otázka: 
  Je formule $Phi$ splnitelná?

#kladna-odpo

Mějme booleovský výraz ve 3-KNF:
$
  (x or y or z) and (not x or not y or not z),
$

který v množinovém zápise vypadá následovně:

$
  Phi = (cal(V), cal(K)) quad cal(V) = {x,y,z} quad cal(K) = {{x,y,z},{not x, not y, not z}}.
$

Jedno z možných ohodnocení, které splňuje formuli $Phi$, je:
$
  x &= T \ 
  y &= F \ 
  z &= F.
$

#zaporna-odpo

Mějme booleovský výraz:
$
  (not x or not x or not x) and
  (not y or not y or x) and
  (not x or not x or y) and
  (x or x or x).
$ <formula-contra>

Jeho podoba v množinovém zápise je:

$
  Phi = (cal(V), cal(K)) \
  cal(V) = {x,y} \
  cal(K) = {{not x, not x, not x}, {not y, not y, x}, {not x, not x, y}, {x, x, x}}.
$

Tento výraz je kontradikcí, 
protože pro libovolné ohodnocení jeho proměnných nebude nikdy splněn.
Výraz $Phi$ je nesplnitelný.

#figure(
  table(
    columns: 3,
    row-gutter: (2pt, auto),
    [$x$], [$y$], [$Phi$],
    [F], [F], [F],
    [F], [T], [F],
    [T], [F], [F],
    [T], [T], [F],
  ), 
  caption: [Všechna možná ohodnocení proměnných @formula-contra[formule] -- vede ke kontradikci]
) <bool-assignment-contradiction>


