#import "/lib/global.typ": * 
#load-bib(main: false)
#set heading(numbering: "1.")

== Redukce 3-SAT na SSP <sec-redukce-3sat-ssp>

Tato redukce vychází z myšlenek prezentovaných v @three-sat-to-ssp-yt.

V této redukci převádíme booleovskou formuli $Phi$ ve 3-KNF na instanci problému součtu množiny, 
tedy na množinu čísel $S$ a cílovou hodnotu $tau$.

Nechť $lr(|cal(V)|)$ značí počet proměnných a $lr(|cal(K)|)$ počet klauzulí formule $Phi = (cal(V), cal(K))$.
Maximální počet číslic výsledných čísel i jejich celkový počet závisí právě na těchto dvou parametrech.

Maximální počet číslic každého čísla označme jako $k$, přičemž:
$
  k = lr(|cal(V)|) + lr(|cal(K)|),
$
a velikost množiny $S$ je:
$
  lr(|S|) = 2lr(|cal(V)|) + 2lr(|cal(K)|).
$

#let indexing = [
  // AGENT: uprav toto
  V této práci jsou číslice čísel indexována zleva doprava od $0$. 
  Např. pro číslo $3452$, první číslice s indexem $0$ je $3$, číslice na indexu $2$ je $5$, apod.
]

Cílovou hodnotu $tau$ zvolíme jako číslo, jehož:
- prvních #footnote(indexing) $|cal(V)|$ číslic (odpovídajících proměnným) je rovno jedné,
- následujících $|cal(K)|$ číslic (odpovídajících klauzulím) je rovno třem.

Formálně tedy:
$
 tau = sum_(i = 0)^(lr(|cal(V)|) - 1) 1 dot 10^(lr(|cal(K)|) + i) + 
       sum_(j = 0)^(lr(|cal(K)|) - 1) 3 dot 10^(j).
$

Například pro $lr(|cal(V)|) = 5$ a $lr(|cal(K)|) = 3$ dostáváme:
$
  tau = 11111333.
$

=== Reprezentace ohodnocení proměnných

Každé proměnné $x_i in cal(V)(Phi)$, kde $0 <= i < lr(|cal(V)|)$, 
přiřadíme dvě čísla, $x_i^((T))$ a $x_i^((F))$.
Výběr právě jednoho z těchto čísel do finální podmnožiny $S'$ 
reprezentuje přiřazení pravdivostní hodnoty proměnné $x_i$ 
-- 
výběr čísla $x_i^((T))$ odpovídá ohodnocení proměnné $x_i$ hodnotou $T$ 
a výběr čísla $x_i^((F))$ odpovídá ohodnocení proměnné $x_i$ hodnotou $F$.  // AGENT: uprav

Obě tato čísla mají na $i$-té pozici 
číslici rovnou jedné, 
zatímco všechny ostatní číslice jsou prozatím nulové.

Tím je zajištěno, že v libovolné podmnožině $S' subset.eq S$, jejíž součet má být roven $tau$, 
musí být pro každou proměnnou vybráno právě jedno z čísel $x_i^((T))$ nebo $x_i^((F))$.
Kdyby nebylo vybráno žádné, příslušná číslice by byla v součtu množiny $S'$ nulová. 
Kdyby byla vybrána obě, vznikla by číslice $2$. 
V obou případech by se součet lišil od $tau$, 
kde je na dané pozici právě $1$.

Výběr podmnožiny tedy jednoznačně odpovídá volbě pravdivostního ohodnocení proměnných.

Jako příklad uvažujme formuli:
$ 
  (alpha or beta or gamma) and (not alpha or not beta or gamma),
$ 

kterou lze v množinovém zápisu vyjádřit jako:

$
  cal(V)(Phi) &= {alpha, beta, gamma} \
  cal(K)(Phi) &= {{alpha, beta, gamma}, {not alpha, not beta, gamma}}.
$

Klauzule si označme jako $kappa_0 = {alpha, beta, gamma}$ a $kappa_1 = {not alpha, not beta, gamma}$.

Maximální počet číslic každého čísla bude:

$
  k = |cal(V)(Phi)| + |cal(K)(Phi)| = 3 + 2 = 5.
$

První tři číslice odpovídají proměnným $alpha, beta$ a $gamma$ 
(poslední dvě odpovídají klauzulím $kappa_0$ a $kappa_1$, těm věnujeme pozornost v @repre-clause[podkapitole]).

Čísla reprezetujicí ohodnocení proměnných by měla podobu:

$
  alpha^((T)) &= 10000 \
  alpha^((F)) &= 10000 \
  beta ^((T)) &= 01000 \
  beta ^((F)) &= 01000 \
  gamma^((T)) &= 00100 \
  gamma^((F)) &= 00100.
$

// AGENT: say that here the leading zeros are only for prehlednost, and don't mean anything, for example 00100 is the same number as 100. 

První tři číslice cílové hodnoty $tau = 11133$ odpovídají proměnným $alpha, beta, gamma$ a jsou rovny jedné.
To vynucuje, aby bylo do podmnožiny $S'$ vybráno právě jedno číslo z každé dvojice $x_i^((T))$ a $x_i^((F))$, 
tedy právě jedno číslo odpovídající každé proměnné.

=== Reprezentace splnění klauzulí <repre-clause>

Nechť $kappa_j in cal(K)(Phi)$, kde $0 <= j < lr(|cal(K)|)$, je klauzule formule.
Pro každou klauzuli rezervujeme číslici na pozici $|cal(V)| + j$.

Pokud se proměnná $x_i in cal(V)(Phi)$ vyskytuje v klauzuli $kappa_j$:

- jako neznegovaný literál, nastavíme číslici na pozici $|cal(V)| + j$ rovnu 1 v čísle $x_i^((T))$,
- jako negovaný literál, nastavíme tutéž číslici rovnu 1 v čísle $x_i^((F))$.

Například pro klauzuli $kappa_0 = {alpha, beta, gamma}$
nastavíme příslušnou číslici v číslech $alpha^((T))$, $beta^((T))$ a $gamma^((T))$, 
zatímco pro klauzuli $kappa_1 = {not alpha, not beta, gamma}$
ji nastavíme v číslech $alpha^((F))$, $beta^((F))$ a $gamma^((T))$.

$
  alpha^((T)) &= 10010 \
  alpha^((F)) &= 10001 \
  beta ^((T)) &= 01010 \
  beta ^((F)) &= 01001 \
  gamma^((T)) &= 00111 \
  gamma^((F)) &= 00100.
$

// AGENT: uprav
Nyni vyber cisla s cislici 1 na pozici $lr(|cal(V)|) + j$ zpusobi, ze finalni soucet podmnoziny $S'$ bude mit na pozici $lr(|cal(V)|) + j$ cislici kladnou (vetsi nez 0).
a tedy klauzule $k_j$ bude reprezentována jako splněná.

=== Vyrovnávací čísla

Cílová hodnota $tau$ však vyžaduje, aby každá klauzulová číslice byla rovna třem.
Výběrem ohodnocení proměnných může být na dané pozici 
dosaženo hodnoty 0, 1, 2 nebo 3 -- 
podle toho, kolik literálů klauzule je splněno, 
pricemz klauzule se povazuje za splnenou, pokud je dosazena hodnota alespon 1 (to odpovida tomu ze je klauzule splnena jednim svym literalem). // AGENT: uprav

Aby bylo možné vždy dosáhnout přesně hodnoty 3, v pripadech kdy je dosazena hodnota alespon 1,
(pokud je klauzule splněna alespoň jedním literálem), 
přidáme pro každou klauzuli $kappa_j$ dvě tzv. _vyrovnávací čísla_.

Každé z těchto čísel má na pozici $lr(|cal(V)|) + j$ číslici rovnu 1 a na všech ostatních pozicích číslici 0.

Pokud je tedy součet na pozici $lr(|cal(V)|) + j$ po výběru proměnných roven 1 nebo 2, 
lze pomocí těchto vyrovnávacích čísel dosáhnout přesně hodnoty 3.
Jestliže je součet na příslušné pozici roven nule, 
což znamená, že klauzule není splněna žádným literálem, 
nelze ani s využitím vyrovnávacích čísel dosáhnout požadované hodnoty 3.

Pro klauzuli $kappa_0$ zavedeme dvě vyrovnávací čísla:
$
  kappa_(0,0) = 00010 \
  kappa_(0,1) = 00010,
$
která mají jednotku na pozici odpovídající této klauzuli a na ostatních pozicích nuly.

Analogicky pro klauzuli $kappa_1$ definujeme:
$
  kappa_(1,0) = 00001 \
  kappa_(1,1) = 00001
$
opět s jedinou nenulovou číslicí na pozici příslušné klauzule.

Tato konstrukce tedy zajišťuje, 
že existuje podmnožina $S' subset.eq S$ se součtem rovným $tau$ právě tehdy, 
když je původní formule $Phi$ splnitelná.

