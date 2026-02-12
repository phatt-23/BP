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
