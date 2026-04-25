#import "/lib/global.typ": *

== Reprezentace instancí problémů

Interní reprezentace instancí je založena na abstraktní třídě `ProblemInstance`,
která definuje společné rozhraní pro všechny typy problémů.
Každá konkrétní reprezentace rozšiřuje tuto abstraktní třídu
a implementuje specifické metody pro práci s daným typem problému.

Toto řešení umožňuje jednotné zpracování různých typů problémů
v rámci systému redukcí,
přičemž každá instance si zachovává specifické vlastnosti svého typu.

=== Třídní hierarchie

Následující diagram znázorňuje třídní hierarchii použitou pro reprezentaci instancí problémů.

#figure(
  image("../assets/instance-class-diagram.svg"),
  caption: [Třídní hierarchie datových struktur]
)

=== Reprezentace formule 3-SAT

Booleovská formule v 3-KNF je reprezentována třídou `CNF3`.
Tato třída obsahuje množinu proměnných a množinu klauzulí.
Každá klauzule je reprezentována třídou `Clause`,
která obsahuje trojici literálů.
Literál je reprezentován třídou `Literal`, jež obsahuje název proměnné a příznak negace.

Třída `CNF3` poskytuje statickou metodu `fromString` pro parsování textového vstupu.
Tato metoda očekává vstup ve formě víceřádkového textu,
kde každý řádek reprezentuje jednu klauzuli.
Literály jsou odděleny mezerou a negace je označena prefixem `!` (vykřičník).

// AGENT: toto uprav tyto vety at navazuji
// AGENT: i should put the #sourcecode blocks and the corresponding math blocks into a #figure somehow, please do it the best way
Příklad vstupního formátu:

#sourcecode[```txt
  a !b c
  !x y z
  x !b !c
  a y z
```]

Toto je příklad instance
$
  (a or not b or c) and 
  (not x or y or z) and 
  (x or not b or not c) and 
  (a or y or z)
$

Lze taky zadavat literaly jako LaTeX
#sourcecode[```txt
  \alpha \beta \gamma  
  \alpha_1 \alpha_2 \beta_3
```]

Toto je
$
  (alpha or beta or gamma  ) and
  (alpha_1 or alpha_2 or beta_3)
$


=== Reprezentace grafů

Grafové problémy využívají třídu `Graph`, 
která poskytuje reprezentaci orientovaných i neorientovaných grafů.
Graf je reprezentován jako množina vrcholů a množina hran.
Každý vrchol obsahuje identifikátor, popisek, pozici pro vizualizaci a volitelnou barvu.
Hrana obsahuje identifikátor, počáteční vrchol, cílový vrchol a volitelnou váhu.

Pro parsování vstupu poskytuje třída `Graph` statickou metodu `fromString`.
Vstupní formát umožňuje specifikovat vrcholy a hrany.
Jednotlivé řádky mohou obsahovat:

- pouze název vrcholu pro definici izolovaného vrcholu,
- dva názvy vrcholů oddělené mezerou pro definici hrany,
- dva názvy vrcholů a celé číslo pro definici hrany s váhou.

Příklad vstpuního formátu (bez ohodnocení hran):
#sourcecode[```txt
  0
  1
  2
  3
  4
  0 1 
  1 2 
  2 3 
  3 4 
  4 0 
```]
// TODO: pridat odpovidajici graf

Příklad vstpuního formátu (s ohodnocením hran):
#sourcecode[```txt
  0
  1
  2
  3
  4
  0 1  1
  0 2  2
  0 3  2
  0 4  1
  1 2  1
  1 3  2
  1 4  2
  2 3  1
  2 4  2
  3 4  1
```]
// TODO: pridat odpovidajici graf

Lze zadavat (tak jako u 3-SAT) LaTeX jmena.
#sourcecode[```txt
  \alpha \beta
  \alpha \gamma
  \beta \beta_1
  \beta \beta_2
  \gamma \gamma_1
  \gamma \gamma_2
  \gamma \gamma_3
```]

// TODO: pridat odpovidajici graf


Třída `Graph` poskytuje metodu `copy` pro vytvoření hluboké kopie grafu
a metodu `labelSolved` pro označení hran náležících k nalezenému řešení.


=== Reprezentace problému SSP

Problém podmnožinového součtu je reprezentován třídou `SSP`.
Tato třída obsahuje seznam čísel a cílovou hodnotu.
Každé číslo je reprezentováno jako pole cifer, 
což umožňuje práci s velkými čísly,
která by přesáhla maximální hodnotu standardního celočíselného typu.

Parsování vstupu
- Každý řádek vstupu reprezentuje jedno číslo.
- nejprve se cílová hodnota (je na prvnim radku) 
- poté se parsuje ostatni jednotlivá čísla

Příklad vstupu:
#sourcecode[```txt
11111133

10000010
10000000
1000010
1000000
100010
100000
10001
10000
1001
1000
101
100
10
10
1
1
```]

Toto je
$
tau = 11111133 \

S = 
{ 10000010 , 10000000 , 1000010 , 1000000 , 100010 , 100000 , \ 
  10001 , 10000 , 1001 , 1000 , 101 , 100 , 10 , 10 , 1 , 1 }
$



=== Validace vstupu

Validace vstupních dat probíhá ve dvou fázích.
První fáze kontroluje syntaktickou správnost vstupu během parsování.
V této fázi jsou odmítnuty vstupy obsahující neplatné znaky nebo porušující základní syntaktická pravidla.

Druhá fáze validace probíhá po úspěšném parsování vstupu prostřednictvím metody `isEmpty`.
Tato metoda kontroluje, zda instance obsahuje všechny potřebné prvky.
Například pro problém 3-SAT kontroluje, zda formule obsahuje alespoň jednu proměnnou a jednu klauzuli.

Chybové zprávy jsou vraceny jako typ `ErrorMessage`,
který v případě chyby obsahuje textový popis problému
a v případě úspěchu je hodnota `null`.

