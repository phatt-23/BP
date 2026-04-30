#import "@preview/diagraph:0.3.6": *
#import "./dot-graphs.typ": *

#import "/lib/global.typ": *
#load-bib(main: false)

== Redukce 3-SAT na HCYCLE <sec-redukce-3sat-hcycle>

Tato redukce vychází z myšlenek prezentovaných v @three-sat-to-hcycle-anim.

Algoritmus pro převod instance problému 3-SAT na instanci problému HCYCLE
spočívá ve vytvoření speciálních konstrukčních prvků pro proměnné a klauzule vstupní formule.
Tyto konstrukční prvky mají podobu vhodně navržených podgrafů, 
které jsou následně propojeny tak, aby byla zachována odpověď původní instance.

Výsledkem konstrukce je orientovaný graf, 
který obsahuje hamiltonovský cyklus právě tehdy, 
je-li vstupní instance problému 3-SAT splnitelná.

=== Konstrukční prvky proměnných

Konstrukční prvek odpovídající jedné booleovské proměnné má podobu grafu cesty, 
který je průchozí v obou směrech. 
Strukturálně tedy odpovídá neorientované cestě, 
avšak vzhledem k tomu, 
že výsledný graf je orientovaný, 
jsou jednotlivé hrany nahrazeny dvojicemi protisměrných orientovaných hran.

#figure(
  raw-render(```dot
    digraph VarGadget {
      rankdir=LR

      node [shape=circle fixedsize=true]
      
      T -> 0 
      0 -> T

      0 -> 1
      1 -> 0

      1 -> elips 
      elips -> 1

      a -> b
      b -> a

      elips -> a
      a -> elips

      b -> F
      F -> b

      // a [label="n - 1"]
      // b [label="n"]
      elips [penwidth=0 label="..."]
      // 0 [label="x_1"]
      // 1 [label="x_2"]
    }
  ```, 
    width: 100%, 
    labels: (
      "T": $x^((1))$,
      "F": $x^((n))$,
      "0": $x^((2))$,
      "1": $x^((3))$,
      "a": $x^((n - 2))$,
      "b": $x^((n - 1))$,
    )),
  caption: [Konstrukční prvek proměnné $x$],
)

Počet vrcholů tohoto konstrukčního prvku je zvolen tak, 
aby umožňoval jeho korektní propojení s konstrukčními prvky klauzulí. 
Tento prvek obsahuje alespoň dva vrcholy, 
přičemž jeho krajní vrcholy slouží k reprezentaci ohodnocení příslušné booleovské proměnné.

Konstrukční prvky proměnných jsou ve výsledném grafu uspořádány sériově do jednoho řetězce. 
Na jeho začátku, 
mezi jednotlivými konstrukčními prvky 
i na jeho konci se nacházejí speciální vrcholy, 
které budeme dále označovat jako _mezi-vrcholy_. 
Tyto mezi-vrcholy slouží jako spojovací uzly 
a jsou vždy napojeny na krajní vrcholy příslušných konstrukčních prvků proměnných, 
přičemž tyto krajní vrcholy jsou propojeny s následujícím mezi-vrcholem.
Poslední mezi-vrchol je spojen s prvním mezi-vrcholem řetězce, 
čímž se uzavře cyklus.

#figure(
  raw-render(
    var-gadget-chain, 
    width: 100%,
  ),
  caption: [Řetězec konstrukčních prvků proměnných $x$, $y$ a $z$],
)

Průchod tímto řetězcem jednoznačně odpovídá volbě ohodnocení jednotlivých proměnných. 
Lze například stanovit,
že průchod levou větví konstrukčního prvku reprezentuje přiřazení pravdivostní hodnoty $T$ dané proměnné,
zatímco průchod pravou větví odpovídá přiřazení hodnoty $F$.
Tato konvence bude uplatňována i v následujících podkapitolách.

Jakmile je při průchodu zvolena jedna z větví, 
není již možné toto rozhodnutí změnit.
Pokud jsme do konstrukčního prvku vstoupili levou větví, 
jedinou možností dalšího postupu je projít celý prvek směrem doprava.
Naopak, pokud jsme vstoupili pravou větví, 
můžeme pokračovat pouze směrem doleva.
Tím je zajištěno, 
že každá proměnná je v rámci libovolného hamiltonovského cyklu 
ohodnocena právě jednou pravdivostní hodnotou.

=== Konstrukční prvky klauzulí

Konstrukční prvek odpovídající jedné klauzuli je tvořen jediným vrcholem. 
Tento vrchol je propojen s příslušnými konstrukčními prvky proměnných, 
a to vždy mezi dvěma sousedními vrcholy jejich cesty. 
Konkrétní způsob propojení závisí na literálech, 
které se v dané klauzuli vyskytují.

Jako příklad uvažujme booleovskou formuli:
$
  (x or not y or z) and (not x or x or y).
$
Pro každou klauzuli vytvoříme konstrukční prvek -- 
klauzuli $(x or not y or z)$ přiřadíme vrchol $kappa_1$, 
a klauzuli $(not x or x or y)$ vrchol $kappa_2$.
Tyto vrcholy budou propojeny 
s příslušnými konstrukčními prvky proměnných 
podle výskytu literálů. 
Jak by takové propojení mohlo vypadat, je znázorněno na @clause-gadgets-conn-to-var-gadgets[obrázku].

#figure(
  raw-render(
    clause-gadget,
    width: 100%,
  ),
  caption: [Konstrukční prvek klauzulí $(x or not y or z)$ a $(not x or x or y)$],
) <clause-gadgets-conn-to-var-gadgets>

Pokud se v klauzuli vyskytuje neznegovaný literál, 
jsou hrany mezi konstrukčním prvkem proměnné a vrcholem klauzule přidány tak, 
že hrana směřující do vrcholu klauzule leží vlevo od hrany směřující z něj.
V případě negovaného literálu jsou hrany přidány opačně -- 
hrana směřující do vrcholu klauzule leží vpravo od hrany směřující z něj.

Platí, že mezi každou dvojicí vrcholů konstrukčního prvku proměnné
propojených s vrcholem klauzule musí zůstat alespoň jeden vrchol volný,
a samotné koncové vrcholy konstrukčního prvku proměnné nesmí být propojeny s vrcholem klauzule.
Tím je zajištěno, že v rámci hamiltonovského cyklu nemůže docházet k "přeskakování" mezi konstrukčními prvky proměnných, 
což by narušilo jednoznačné přiřazení pravdivostní hodnoty proměnné.

Příklad tohoto jevu je znázorněn na @preskakovani[obrázku], 
kde dochází k přeskoku z konstrukčního prvku proměnné $x$ na konstrukční prvek proměnné $y$.
Současně dochází ke změně směru průchodu konstrukčním prvkem proměnné, 
a tím se stává dosažitelným i vrchol klauzule, který by za korektního průchodu dosažitelný být neměl.

#figure(
  raw-render(
    non-valid-traversal,
    width: 100%,
  ),
  caption: [Průchod nevalidním konstrukčním prvkem proměnné $x$ -- přeskakování],
) <preskakovani>

Tomuto jevu zabráníme vložením alespoň jednoho volného vrcholu 
mezi každou dvojici vrcholů konstrukčního prvku proměnné,
jež jsou propojeny s vrcholem klauzule.
Pokus o přeskok by totiž vedl k tomu, 
že tento vložený vrchol zůstane nenavštíven, 
což znemožní existenci hamiltonovského cyklu.
Jakýkoli následný pokus o jeho dodatečné navštívení 
by nutně vedl do již navštíveného vrcholu.

#figure(
  raw-render(
    jumping-non-working,
    width: 100%,
  ),
  caption: [Prevence přeskakování přidáním volného vrcholu],
) 


Takto navržené propojení zaručuje, 
že vrchol klauzule je dosažitelný v rámci hamiltonovského cyklu právě tehdy, 
pokud je alespoň jeden z jejích literálů splněn.
Pokud je proměnným přiřazena hodnota $T$, procházíme konstrukčním prvkem proměnné zleva doprava,
což umožňuje navštívit vrchol klauzule obsahující neznegovaný literál a vrátit se zpět.
Přiřazením hodnoty $F$ procházíme konstrukčním prvkem zprava doleva,
čímž lze navštívit vrcholy klauzulí s negovaným literálem.

Tím je zachována ekvivalence mezi splnitelností původní formule 
a existencí hamiltonovského cyklu ve výsledném grafu.


