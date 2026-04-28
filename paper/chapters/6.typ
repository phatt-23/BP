= Ukázkové instance a demonstrace

// AGENT: Say that the user can enter the instances themselves, but the system enables them to choose from a predefined set of examples, as so they don't have to do it all by themselves and can learn how the editor expects the syntax of format for instances to be.

Tato kapitola představuje vybrané ukázkové instance
pro všechny implementované redukce.
Na konkrétních příkladech je demonstrováno,
jak aplikace vizualizuje proces redukce krok za krokem.

Zvolené instance pokrývají:
- různé velikosti vstupních dat,
- případy s kladnou i zápornou odpovědí,
- různorodé struktury vstupních instancí (formule s různými kombinacemi literálů, grafy s různou hustotou hran).

Celkem kapitola obsahuje 20 ukázkových instancí (4 na každou redukci),
což poskytuje vyvážený pohled na funkčnost systému.

Pro každou redukci jsou vybrány příklady s kladnou i zápornou odpovědí
v poměru 2:2 (dvě kladné, dvě záporné).
U každé instance je vysvětleno, proč byla zvolena
a jaké poznatky může uživatel z jejího rozboru získat.

Tyto příklady slouží jako východisko pro výuku
a umožňují studentům experimentovat s vlastními instancemi.

== Redukce 3-SAT na HCYCLE

=== Instance 1 -- splnitelná formule (kladná odpověď)

Jako první ukázková instance byla zvolena formule:
$
  (x or y or z) and (not x or y or not z) and (x or not y or z)
$

Tato instance byla vybrána z následujících důvodů:
- obsahuje dostatečný počet proměnných pro demonstraci řetězce konstrukčních prvků,
- kombinuje neznegované i negované literály,
- je snadno ověřitelná ručním výpočtem.

#figure(
  image("../assets/screenshots/3sat-hcycle-ex1-input.png"),
  caption: [Zadání instance vstupního problému 3-SAT]
)

#figure(
  image("../assets/screenshots/3sat-hcycle-ex1-graph.png"),
  caption: [Výsledný orientovaný graf po redukci]
)

#figure(
  image("../assets/screenshots/3sat-hcycle-ex1-steps.png"),
  caption: [Krokové zobrazení redukce]
)

=== Instance 2 -- splnitelná formule s více proměnnými

Formule:
$
  (a or b or c) and (not a or b or c) and (a or not b or not c) and (not a or not b or c)
$

Instance demonstruje:
- konstrukci delšího řetězce konstrukčních prvků,
- vliv počtu proměnných na velikost výsledného grafu.

=== Instance 3 -- nesplnitelná formule (záporná odpověď)

Ukázková instance:
$
  (x or x or x) and (not x or not x or not x)
$

Tato instance je nesplnitelná, což demonstruje,
že výsledný graf neobsahuje hamiltonovský cyklus.
Instance je užitečná pro ilustraci toho, jak aplikace zpracovává negativní odpovědi.

=== Instance 4 -- nesplnitelná formule s více klauzulemi

Formule:
$
  (a or a or a) and (not a or not a or b) and (not b or not b or not b)
$

Demonstruje případ, kdy i přes přítomnost více proměnných
nelze nalezt ohodnocení splňující všechny klauzule.

== Redukce 3-SAT na SSP

=== Instance 1 -- splnitelná formule (kladná odpověď)

Formule:
$
  (a or b or c) and (not a or b or not c)
$

Instance demonstruje:
- reprezentaci proměnných pomocí dvojic čísel,
- vliv klauzulí na jednotlivé číslice,
- funkci vyrovnávacích čísel.

#figure(
  image("../assets/screenshots/3sat-ssp-ex1-input.png"),
  caption: [Zadání instance 3-SAT pro redukci na SSP]
)

#figure(
  image("../assets/screenshots/3sat-ssp-ex1-numbers.png"),
  caption: [Vygenerovaná množina čísel SSP]
)

=== Instance 2 -- splnitelná formule s třemi proměnnými

Formule:
$
  (x or y or z) and (not x or y or z) and (x or not y or not z)
$

Ukazuje reprezentaci složitější struktury klauzulí
a jak vyrovnávací čísla pomáhají dosáhnout cílové hodnoty.

=== Instance 3 -- nesplnitelná formule (záporná odpověď)

Formule:
$
  (x or x or x) and (not x or not x or not x)
$

Demonstruje případ, kdy nelze dosáhnout cílové hodnoty $tau$,
protože žádná podmnožina neumožňuje splnění všech klauzulí.

=== Instance 4 -- nesplnitelná formule s konfliktními literály

Formule:
$
  (a or b or c) and (not a or not b or not c) and (a or b or not c) and (not a or b or c)
$

Instance ukazuje, že i při větším počtu klauzulí
může být formule nesplnitelná.

== Redukce 3-SAT na 3-CG

=== Instance 1 -- splnitelná formule (kladná odpověď)

Formule:
$
  (alpha or beta or gamma) and (not alpha or beta or not gamma)
$

Instance ukazuje:
- jádrový konstrukční prvek a jeho obarvení,
- konstrukční prvky proměnných,
- propojení s konstrukčními prvky klauzulí.

#figure(
  image("../assets/screenshots/3sat-3cg-ex1-graph.png"),
  caption: [Výsledný graf pro problém 3-CG]
)

=== Instance 2 -- splnitelná formule s více klauzulemi

Formule:
$
  (x or y or z) and (not x or y or not z) and (x or not y or z)
$

Demonstruje postupné přidávání konstrukčních prvků klauzulí
a jejich vliv na výsledné 3-obarvení.

=== Instance 3 -- nesplnitelná formule (záporná odpověď)

Formule:
$
  (a or a or a) and (not a or not a or not a)
$

Demonstruje případ, kdy graf není 3-obarvitelný,
protože konflikt v klauzulích vynutí protichůdné podmínky pro obarvení.

=== Instance 4 -- nesplnitelná formule s více proměnnými

Formule:
$
  (x or y or z) and (not x or not y or not z) and (x or y or not z) and (not x or y or z)
$

Ukazuje, že i při více proměnných může dojít ke konfliktu
znemožňujícímu validní 3-obarvení.

== Redukce HCYCLE na HCIRCUIT

=== Instance 1 -- graf s hamiltonovským cyklem (kladná odpověď)

Orientovaný graf $G$ s hamiltonovským cyklem:
$
  V = \{A, B, C, D\}, 
  E = \{(A,B), (B,C), (C,D), (D,A), (A,C)\}
$

Instance ilustruje transformaci orientovaného grafu na neorientovaný
pomocí trojic vrcholů $v_i, v_b, v_o$.

#figure(
  image("../assets/screenshots/hcycle-hcircuit-ex1.png"),
  caption: [Transformace HCYCLE na HCIRCUIT]
)

=== Instance 2 -- složitější orientovaný graf s cyklem

Graf s více vrcholy a hranami:
$
  V = \{A, B, C, D, E\}, 
  E = \{(A,B), (B,C), (C,D), (D,E), (E,A), (A,C), (B,E)\}
$

Demonstruje, jak se zvyšující se počet hran projeví
v počtu trojic ve výsledném neorientovaném grafu.

=== Instance 3 -- acyklický graf (záporná odpověď)

Orientovaný strom:
$
  V = \{A, B, C, D, E\}, 
  E = \{(A,B), (A,C), (B,D), (B,E)\}
$

Demonstruje neexistenci hamiltonovského cyklu v acyklickém grafu
a jak aplikace zpracovává negativní odpověď.

=== Instance 4 -- graf s cyklem ale bez hamiltonovského

Graf, který obsahuje cyklus, ale ne hamiltonovský:
$
  V = \{A, B, C, D\}, 
  E = \{(A,B), (B,C), (C,A), (C,D)\}
$

Ukazuje rozdíl mezi existencí libovolného cyklu
a hamiltonovského cyklu procházejícího všemi vrcholy.

== Redukce HCIRCUIT na TSP

=== Instance 1 -- graf s hamiltonovskou kružnicí (kladná odpověď)

Neorientovaný graf obsahující hamiltonovskou kružnici:
$
  V = \{A, B, C, D, E, F\}, 
  E = \{\{A,B\}, \{B,C\}, \{C,D\}, \{D,E\}, \{E,F\}, \{F,A\}, \{A,C\}, \{B,E\}, \{B,F\}\}
$

Instance ukazuje přidání hran s vyšší vahou
a nastavení cílové hodnoty $k = |V|$.

#figure(
  image("../assets/screenshots/hcircuit-tsp-ex1-graph.png"),
  caption: [Kompletní graf s ohodnocením hran]
)

=== Instance 2 -- jednodušší graf s hamiltonovskou kružnicí

Graf s menším počtem vrcholů:
$
  V = \{A, B, C, D\}, 
  E = \{\{A,B\}, \{B,C\}, \{C,D\}, \{D,A\}, \{A,C\}\}
$

Demonstruje, že redukce funguje i pro menší instance
a jak se mění vizualizace s menším počtem vrcholů.

=== Instance 3 -- graf bez hamiltonovské kružnice (záporná odpověď)

Graf neobsahující hamiltonovskou kružnici:
$
  V = \{A, B, C, D\}, 
  E = \{\{A,B\}, \{B,C\}, \{C,A\}, \{C,D\}\}
$

Demonstruje případ, kdy neexistuje cesta s cenou $k = |V|$,
protože graf neobsahuje hamiltonovskou kružnici.

=== Instance 4 -- graf s vyšším počtem vrcholů bez cyklu

Graf s vrcholy:
$
  V = \{A, B, C, D, E\}, 
  E = \{\{A,B\}, \{B,C\}, \{C,D\}, \{D,E\}\}
$

Lineární řetězec vrcholů demonstruje,
že bez návratové hrany nelze vytvořit hamiltonovskou kružnici.


