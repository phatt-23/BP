#import "/lib/global.typ": *
#import "/czech-declension/out.typ": inflected as inf

#set math.equation(numbering: "1.")

= Vybrané NP-úplné problémy

Tato kapitola představuje vybrané NP-úplné problémy, 
se kterými pracuje navržený systém. 
Pro každý problém je uvedena 
jeho formální definice, 
popis vstupu 
a formulace rozhodovací otázky. 
Ukážeme si také konkrétní 
  instance těchto problémů s kladnou odpověďí 
  i instance se zápornou odpověďí. 

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

// #table(
//   columns: (auto, auto, 1fr),
//   [3-SAT], [3-Satisfiability], [splnitelnost booleovské formule v 3-konjunktivní normální formě],
//   [ HCYCLE ], [Hamiltonian Cycle], [existence hamiltonovského cyklu v orientovaném grafu],
//   [ HCIRCUIT ], [Hamiltonian Circuit], [existence hamiltonovské kružnice #footnote[#ham_cyklus_kruznice] v neorientovaném grafu],
//   [ TSP ], [Traveling Salesman Problem], [problém obchodního cestujícího v rozhodovací verzi],
//   [ SSP ], [Subset Sum Problem], [problém podmnožinového součtu],
//     [ 3-CG ], [3-Coloring], [3-obarvitelnost vrcholů grafu],
// )


/*
= Vybrané NP-úplné problémy 

// *Purpose:* 
// - Define the concrete problems your system works with.
// - Create one subsection per problem.

// For each provide:
// - Formal definition
// - Input format
// - Question being answered (YES/NO)
// - Small illustrative example

V této práci jsem se zaměřil na tyto NP-úplné problémy:
- 3-SAT - splitelnost booleovské formule v 3-konjunktivní normální formě
- HCYCLE - nalezení hamiltonosvkého cyklu v orientovaném grafu
- HCIRCUIT - problém hamiltonovské kružnice, nalezení hamiltonovského cyklu v neorientovaném grafu
- TSP - problém obchodního cestujicího, nalezení hamiltonovského cyklu s minimální cenou v ohodnoceném neorientovaném grafu
- SSP - subset-sum problém, vybrat z (multi)množiny čísel čísla, tak aby byl součet roven cílové hodnotě  
- 3-CG - barvení vrcholy grafu 3 barvami tak, aby žádné dva sousední vrcholy nemají stejnou barvu 
*/

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

Formule $Phi$ se nazývá splitelná, 
pokud existuje ohodnocení booleovských proměnných, 
při němž se celá formule vyhodnotí jako pravdivá.
Ekvivalentně lze říci, že splnitelnost nastává tehdy, 
je-li splněna každá klauzule z množiny $cal(K)$.

Vyjádření jako rozhodovací problém.

/ Vstup: 
  Booleovská formule $Phi = (cal(V), cal(K))$ ve 3-KNF.

/ Otázka: 
  Je fomule $Phi$ splitelná?

Dále v textu budeme s touto formulací pracovat následovně.
Každá klauzule $kappa in cal(K)$ 
je chápána jako množina obsahujicí právě 3 literály 
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

/ Vstup: 
  Orientovaný graf $G = (V,E)$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovký cyklus?

/*

Mějme orientovaný graf $G = (V,E)$, kde $V$ je množina vrcholů a $E$ je množina orientovaných hran.
V grafu $G$ je hamiltonovký cyklus, jestliže existuje cesta $P$ taková, že:

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1) \
  (P_i, P_(i+1)) in E text("pro") 0 <= i < |V|\
$

Grafu, který má hamiltonovský cyklus, říkáme hamiltonovký graf.

Vstup: Orientovaný graf $G$.

Otázka: Je $G$ hamiltonovký graf?
*/


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

/ Vstup: 
  Neorientovaný graf $G = (V,E)$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovskou kružnici? 

/*
Uvažujme ne neorientovaný graf 
$
  G = (V,E),
$ 
kde $V$ je množina vrcholů a $E$ je množina neorientovaných hran. 
Tedy $E subset.eq {{u,v} | u,v in V}$.

Graf $G$ obsahuje hamiltonovký cyklus, pokud existuje posloupnost

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1),
$

která splňuje následujicí podmínky:
- každý vrchol z množiny $V$ se v posloupnosti $P$ vyskytuje právě jednou 
  (s výjimkou počátečního a koncového vrcholu $v_1$,
- pro každé $i$, kde $1 <= i < |V|$, platí ${v_i, v_(i+1)} in E$.

Vstup: Neorientovaný graf $G$.

Otázka: Je $G$ hamiltonovký graf?
*/



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

/ Vstup: 
  Ohodnocený neorientovaný graf $G$ a konstanta $k in NN$.

/ Otázka: 
  Obsahuje graf $G$ hamiltonovskou kružnici s cenou nejvýše $k$?


== SSP

Problém SSP (Subset Sum Problem, SSP) spočívá v určení, zda pro danou konečnou množinu přirozených čísel
$
  S subset.eq NN
$ 
a cílovou hodnotu $tau in NN$ existuje podmnožina $S' subset.eq S$, 
jejíchž součet prvků je roven dané cílové hodnotě $tau$.


*Vyjádření jako rozhodovací problém*


/ Vstup:
  Konečná množina přirozených čísel $S subset.eq NN$ a cílová hodnota $tau in NN$.

/ Otázka:
  Existuje podmnožina $S' subset.eq S$ taková, 
  že součet jejích prvků je roven $tau$?

Jelikož se jedná o rozhodovací problém, 
zajímá nás pouze existence takové podmnožiny, 
nikoli její konkrétní složení.

Formálně řekneme, že instance problému SSP má kladnou odpověď, 
pokud existuje množina 
$S' subset.eq S$
taková, že
$
  sum_(s in S') s = tau.
$

/*
Mějme množinu přirozených čísel $S$ a cílovou hodnotu $tau in NN$.
V problému SSP je cílem nalézt podmnožinu $S' subset.eq S$ 

Vstup: Množina přírozených čísel $S$ a cílová hodnota $tau in NN$.

Otázka: Existuje $S' subset.eq S$ taková, že:

$
  tau = sum_(s in S') s
$
*/

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

/ Vstup: Neorientovaný graf $G = (V,E)$.

/ Otázka: Lze vrcholy grafu obarvit 3 barvami tak, aby žádné dvě sousední nesdíleli stejnou barvu?


/*
Mějme neorientovaný graf $G = (V,E)$ a 3 barvy, např. červnenou, zelenou a modrou. 
Pro lepší organizaci si barvy přidáme do množiky $Kappa = {R,G,B}$.
V tomto problému jde o to, obarvit vrcholy $v in V$ tak, aby žádné dva sousední vrcholy neměli stejnou barvu.
Hledáme předpis funkce $kappa : V -> K$ tak, aby splňovala:

$
  {v_0,v_1} in E \
  kappa(v_0) eq.not kappa(v_1) 
$

Vstup: Neorientovaný graf $G = (V,E)$.

Otázka: Lze vrcholy grafu obarvit 3 barvami tak, aby žádné dvě sousední nesdíleli stejnou barvu?
*/
