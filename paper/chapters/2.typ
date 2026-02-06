#import "/lib/global.typ": *
#import "/czech-declension/out.typ": inflected as inf

#set math.equation(numbering: "1.")

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


== 3-SAT

Mějme booleovskou fomuli $Phi = (Nu, Kappa)$, 
kde $Nu$ je množina proměnných 
a $Kappa$ je množina klauzulí v 3-konjunktivní normální formě, 
tj. každá klauzule má přesně 3 literály.

Formule $Phi$ je splitelná, pokud existuje ohodnocení proměnných, takové, že se $Phi$ vyhodnotí na True (Ano, Pravda).
Tedy, každá klauzule $kappa in Kappa$ musí být splněna.

Vstup: Booleovská formule $Phi = (Nu, Kappa)$ v 3-KNF.

Otázka: Je fomule $Phi$ splitelná?


== HCYCLE

Mějme orientovaný graf $G = (V,E)$, kde $V$ je množina vrcholů a $E$ je množina orientovaných hran.
V grafu $G$ je hamiltonovký cyklus, jestliže existuje cesta $P$ taková, že:

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1) \
  (P_i, P_(i+1)) in E text("pro") 0 <= i < |V|\
$

Grafu, který má hamiltonovský cyklus, říkáme hamiltonovký graf.

Vstup: Orientovaný graf $G$.

Otázka: Je $G$ hamiltonovký graf?


== HCIRCUIT

Mějme neorientovaný graf $G = (V,E)$, kde $V$ je množina vrcholů a $E$ je množina neorientovaných hran.
V grafu $G$ je hamiltonovký cyklus, jestliže existuje cesta $P$ taková, že: 

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1) \
  {P_i, P_(i+1)} in E text("pro") 0 <= i < |V|\
$

Vstup: Neorientovaný graf $G$.

Otázka: Je $G$ hamiltonovký graf?



== TSP

Mějme ohodnocený neorientovaný graf $G = (V,E)$, 
kde $V$ je množina vrcholů a $E$ je množina ohodnocených neorientovaných hran
a funkci $w$ přířazující každé hraně váhu (ohodnocení). 
Omezíme se na přírozená čísla.

$
  w : E -> NN 
$


Cílem TSP je najít hamiltonovský cyklus s minimální cenou.
TSP je příklad optimalizačního problému. 
Můžeme, jako každý optimalizační problém, jej zformulovat jako rozhodovací.

V grafu $G$ je hamiltonovký cyklus s cenou $k in NN$, 
jestliže existuje cesta $P$ taková, že:

$
  P = (v_1, v_2, ..., v_(|V| - 1), v_(|V|), v_1) \
  {P_i, P_(i+1)} in E text("pro") 0 <= i < |V|\
  k = sum_(i = 0)^(|V|) w({P_i, P_(i+1)})
$

Vstup: Ohodnocený neorientovaný graf $G$ a konstanta $k in NN$.

Otázka: Obsahuje graf $G$ hamiltonovský cyklus s cenou nejvýše $k$?


== SSP

Mějme množinu přirozených čísel $S$ a cílovou hodnotu $tau in NN$.
V problému SSP je cílem nalézt podmnožinu $S' subset.eq S$ 

Vstup: Množina přírozených čísel $S$ a cílová hodnota $tau in NN$.

Otázka: Existuje $S' subset.eq S$ taková, že:

$
  tau = sum_(s in S') s
$

== 3-CG

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