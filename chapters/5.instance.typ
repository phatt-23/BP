#import "../lib/global.typ": *
#import "@preview/diagraph:0.3.6": *

== Reprezentace instancí problémů

Interní reprezentace instancí je založena na abstraktní třídě `ProblemInstance`,
která definuje společné rozhraní pro všechny typy problémů.
Každá konkrétní reprezentace rozšiřuje tuto abstraktní třídu
a implementuje specifické metody pro práci s daným typem problému.

#figure(sourcecode[```ts
abstract class ProblemInstance {
    /*
    * Problem specific. Each problem has an empty state.
    */
    public abstract isEmpty(): boolean;

    /*
    * Serializes the problem instance.
    *
    * Each child class has a corresponding:
    * public static fromSerializedString(serialized: string): T;
    */
    public abstract toSerializedString(): string;

    /*
    * Formats the instance into a format that 
    * the editor component accepts.
    */
    public abstract asString(): string;
}
```], caption: [Abstraktní třída `ProblemInstance`])

Toto řešení umožňuje jednotné zpracování různých typů problémů
v rámci systému redukcí,
přičemž každá instance si zachovává specifické vlastnosti svého typu.

Následující diagram znázorňuje třídní hierarchii použitou pro reprezentaci instancí problémů.

#figure(
  image("../assets/plantuml/instance-class-diagram.svg"),
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

Následující příklad ukazuje vstupní formát a odpovídající matematickou reprezentaci:

#figure(
  sourcecode(```txt
    a !b c
    !x y z
    x !b !c
    a y z
  ```),
  caption: [Příklad vstupního formátu]
)

Matematická reprezentace:
$
  (a or not b or c) and 
  (not x or y or z) and 
  (x or not b or not c) and 
  (a or y or z)
$

Je také možné zadávat literály ve zjednodušené
#footnote[
  Validator pouze kontroluje, že vstup obsahuje povolené znaky.
  Nejedná se o plnohodnotnou podporu TeX -- systém pouze kontroluje,
  že text obsahuje pouze alfanumerické 
  a povolené speciální znaky jako `\`, `_`, `{`, `}`, `(`, `)`.
  Jelikož mezi povolenými znaky není znak `^`, superskripty nejsou podporovány.
]
syntaxi TeX:

#figure(
  sourcecode(```txt
    \alpha \beta \gamma  
    \alpha_1 \alpha_2 \beta_3
  ```),
  caption: [Příklad vstupu s TeX názvy]
)

Matematická reprezentace:
$
  (alpha or beta or gamma) and
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

Následující příklad ukazuje vstupní formát bez ohodnocení hran:
#figure(sourcecode[```txt
  X
  Y Y
  S U
  U N
  B C
  C N
  N R
  B R
```], caption: [ Příklad vstupu grafu bez ohodnocení hran ])

#figure(
  raw-render(```dot
    digraph {
      layout=fdp
      node [shape=circle fixedsize=true]

      X
      Y -> Y
      S -> U
      U -> N
      B -> C
      C -> N
      N -> R
      B -> R
    }
  ```),
  caption: [Vizualizace grafu bez ohodnocení hran]
)


Následující příklad ukazuje vstupní formát s ohodnocením hran:

#figure(sourcecode[```txt
  A B 1
  A C 2
  A D 3
  A E 1
  B C 1
  B D 4
  B E 2
  C D 7
  C E 2
  D E 1
```], caption: [ Příklad vstupu grafu s ohodnocením hran ])

#figure(
  raw-render(```dot
    digraph {
      node [shape=circle fixedsize=true]

      A -> B [label="1"]
      A -> C [label="2"]
      A -> D [label="3"]
      A -> E [label="1"]
      B -> C [label="1"]
      B -> D [label="4"]
      B -> E [label="2"]
      C -> D [label="7"]
      C -> E [label="2"]
      D -> E [label="1"]
    }
  ```),
  caption: [Vizualizace grafu s ohodnocením hran]
)


Je také možné zadávat názvy vrcholů ve zjednodušené 
syntaxi TeX:

#figure(
  sourcecode[```txt
    \alpha \beta
    \alpha \gamma
    \beta \beta_1
    \beta \beta_2
    \gamma \gamma_1
    \gamma \gamma_2
    \gamma \gamma_3
  ```],
  caption: [ Příklad vstupu grafu s TeX názvy ]
)

#figure(
  raw-render(```dot
    digraph {
      node [shape=circle fixedsize=true]

      "alpha" -> "beta"
      "alpha" -> "gamma"
      "beta" -> "beta_1"
      "beta" -> "beta_2"
      "gamma" -> "gamma_1"
      "gamma" -> "gamma_2"
      "gamma" -> "gamma_3"
    }
  ```),
  caption: [Vizualizace grafu s TeX názvy]
)

// Třída `Graph` poskytuje metodu `copy` pro vytvoření hluboké kopie grafu
// a metodu `labelSolved` pro označení hran náležících k nalezenému řešení.

=== Reprezentace problému SSP

Problém podmnožinového součtu je reprezentován třídou `SSP`.
Tato třída obsahuje seznam čísel a cílovou hodnotu.
Každé číslo je reprezentováno jako pole cifer, 
což umožňuje práci s velkými čísly,
která by přesáhla maximální hodnotu standardního celočíselného typu.

Parsování vstupu funguje následovně:
- Každý řádek vstupu reprezentuje jedno číslo.
- První řádek obsahuje cílovou hodnotu.
- Následující řádky obsahují jednotlivá čísla množiny.

Následující příklad ukazuje vstupní formát a odpovídající matematickou reprezentaci:

#figure(
  sourcecode(```txt
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
  ```),
  caption: [Příklad vstupu SSP]
)

Matematická reprezentace:
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
Tato fáze je důležitá zejména v redukčním modulu, kde zajišťuje validitu instancí před dalším zpracováním.

Chybové zprávy jsou vraceny jako typ `ErrorMessage`,
který v případě chyby obsahuje textový popis problému.


