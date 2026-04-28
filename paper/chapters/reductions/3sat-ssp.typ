#import "../../lib/global.typ": * 
#load-bib(main: false)

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

Cílovou hodnotu $tau$ zvolíme jako číslo, jehož:
- prvních $|cal(V)|$ číslic (odpovídajících proměnným) je rovno jedné,
- následujících $|cal(K)|$ číslic (odpovídajících klauzulím) je rovno třem.

Formálně tedy:
$
 tau = sum_(i = 0)^(lr(|cal(V)|) - 1) 1 dot 10^i + 
       sum_(j = 0)^(lr(|cal(K)|) - 1) 3 dot 10^(lr(|cal(V)|) + j).
$

Například pro $lr(|cal(V)|) = 5$ a $lr(|cal(K)|) = 3$ dostáváme:
$
  tau = 11111333.
$

=== Reprezentace ohodnocení proměnných

Každé proměnné $nu_i in cal(V)(Phi)$, kde $0 <= i < v$, 
přiřadíme dvě čísla, $nu_i^T$ a $nu_i^F$.
Výběr právě jednoho z těchto čísel v podmnožině $S'$ 
reprezentuje přiřazení pravdivostní hodnoty proměnné $nu_i$ 
-- 
číslo $nu_i^T$ odpovídá hodnotě $T$ 
a číslo $nu_i^F$ hodnotě $F$.

Obě tato čísla mají na $i$-té pozici 
(odpovídající proměnné $nu_i$) číslici rovnou jedné, 
zatímco všechny ostatní číslice jsou zatím nulové.

Tím je zajištěno, že v libovolné podmnožině $S' subset.eq S$, jejíž součet má být roven $tau$, 
musí být pro každou proměnnou vybráno právě jedno z čísel $nu_i^T$ nebo $nu_i^F$.
Kdyby nebylo vybráno žádné, příslušná číslice by byla v součtu množiny $S'$ nulová. 
Kdyby byla vybrána obě, vznikla by číslice 2. 
V obou případech by se součet lišil od $tau$, 
kde je na dané pozici právě 1.

Výběr podmnožiny tedy jednoznačně odpovídá volbě pravdivostního ohodnocení proměnných.

Jako příklad uvažujme formuli 
$ 
  (alpha or beta or gamma) and (not alpha or not beta or gamma),
$ 

kterou lze v množinovém zápisu vyjádřit jako

$
  cal(V)(Phi) &= {alpha, beta, gamma} \
  cal(K)(Phi) &= {{alpha, beta, gamma}, {not alpha, not beta, gamma}}.
$

Klauzule si označme jako $kappa_0 = {alpha, beta, gamma}$ a $kappa_1 = {not alpha, not beta, gamma}$.

Počet číslic každého čísla bude

$
  k = |cal(V)(Phi)| + |cal(K)(Phi)| = 3 + 2 = 5.
$

První tři číslice odpovídají proměnným $alpha, beta$ a $gamma$ 
(poslední dvě odpovídají klauzulím $kappa_0$ a $kappa_1$, těm věnujeme pozornost v @repre-clause[podkapitole]).

Čísla reprezetujicí ohodnocení proměnných by měla podobu

$
  alpha^T &= 10000 \
  alpha^F &= 10000 \
  beta^T  &= 01000 \
  beta^F  &= 01000 \
  gamma^T &= 00100 \
  gamma^F &= 00100.
$

První tři číslice cílové hodnoty $tau = 11133$ odpovídají proměnným $alpha, beta, gamma$ a jsou rovny jedné.
To vynucuje, aby bylo do podmnožiny $S'$ vybráno právě jedno číslo z každé dvojice $nu_i^T$ a $nu_i^F$, 
tedy právě jedno číslo odpovídající každé proměnné.

=== Reprezentace splnění klauzulí <repre-clause>

Nechť $kappa_j in cal(K)(Phi)$, kde $0 <= j < c$, je klauzule formule.
Pro každou klauzuli rezervujeme číslici na pozici $v + j$.

Pokud se proměnná $nu_i in cal(V)(Phi)$ vyskytuje v klauzuli $kappa_j$:

- jako neznegovaný literál, nastavíme číslici na pozici $v + j$ rovnu 1 v čísle $nu_i^T$,
- jako negovaný literál, nastavíme tutéž číslici rovnu 1 v čísle $nu_i^F$.

Například pro klauzuli $kappa_0 = {alpha, beta, gamma}$
nastavíme příslušnou číslici v číslech $alpha^T$, $beta^T$ a $gamma^T$, 
zatímco pro klauzuli $kappa_1 = {not alpha, not beta, gamma}$
ji nastavíme v číslech $alpha^F$, $beta^F$ a $gamma^T$.

$
  alpha^T &= 10010 \
  alpha^F &= 10001 \
  beta^T  &= 01010 \
  beta^F  &= 01001 \
  gamma^T &= 00111 \
  gamma^F &= 00100.
$

Je-li alespoň jedno z těchto čísel vybráno do podmnožiny $S'$, 
bude číslice na pozici $v + j$ v součtu kladná, 
a tedy klauzule bude reprezentována jako splněná.

=== Vyrovnávací čísla

Cílová hodnota $tau$ však vyžaduje, aby každá klauzulová číslice byla rovna třem.
Výběrem ohodnocení proměnných může být na dané pozici 
dosaženo hodnoty 1, 2 nebo 3 -- 
podle toho, kolik literálů klauzule je splněno.

Aby bylo možné vždy dosáhnout přesně hodnoty 3 
(pokud je klauzule splněna alespoň jedním literálem), 
přidáme pro každou klauzuli $kappa_j$ dvě tzv. _vyrovnávací čísla_.

Každé z těchto čísel má na pozici $v + j$ číslici rovnu 1 a na všech ostatních pozicích číslici 0.

Pokud je tedy součet na pozici $v + j$ po výběru proměnných roven 1 nebo 2, 
lze pomocí těchto vyrovnávacích čísel dosáhnout přesně hodnoty 3.
Jestliže je součet na příslušné pozici roven nule, 
což znamená, že klauzule není splněna žádným literálem, 
nelze ani s využitím vyrovnávacích čísel dosáhnout požadované hodnoty 3.

Pro klauzuli $kappa_0$ zavedeme dvě vyrovnávací čísla
$
  kappa_(0,0) = 00010 \
  kappa_(0,1) = 00010,
$
která mají jednotku na pozici odpovídající této klauzuli a na ostatních pozicích nuly.

Analogicky pro klauzuli $kappa_1$ definujeme
$
  kappa_(1,0) = 00001 \
  kappa_(1,1) = 00001
$
opět s jedinou nenulovou číslicí na pozici příslušné klauzule.

Tato konstrukce tedy zajišťuje, 
že existuje podmnožina $S' subset.eq S$ se součtem rovným $tau$ právě tehdy, 
když je původní formule $Phi$ splnitelná.


/*

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
*/
