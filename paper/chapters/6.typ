= Ukázkové instance a demonstrace

Tato kapitola představuje konkrétní ukázkové instance problému
a demonstruje, jak navržená aplikace provádí redukce mezi nimi.
Cílem je ilustrovat funkčnost systému na reálných příkladech
a ukázat, jak aplikace vizualizuje jednotlivé kroky redukce.

Pro každou redukci jsou vybrány instance s jasnou strukturou,
které dobře ilustrují princip převodu.
U každé instance je vysvětleno, proč byla zvolena
a jaké poznatky může uživatel z jejího rozboru získat.

== Redukce 3-SAT na HCYCLE

=== Instance s kladnou odpovědí

Jako ukázková instance byla zvolena formule:
$
  (x or y or z) and (not x or y or not z) and (x or not y or z)
$

Tato instance byla vybrána z následujících důvodů:
- obsahuje dostatečný počet proměnných pro demonstraci řetězce konstrukčních prvků,
- kombinuje neznegované i negované literály,
- je snadno ověřitelná ručním výpočtem.

/*
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
*/

=== Instance se zápornou odpovědí

Ukázková instance:
$
  (x or x or x) and (not x or not x or not x)
$

Tato instance je nesplnitelná, což demonstruje,
že výsledný graf neobsahuje hamiltonovský cyklus.
Instance je užitečná pro ilustraci toho, jak aplikace zpracovává negativní odpovědi.

== Redukce 3-SAT na SSP

=== Instance s kladnou odpovědí

Formule:
$
  (a or b or c) and (not a or b or not c)
$

Instance demonstruje:
- reprezentaci proměnných pomocí dvojic čísel,
- vliv klauzulí na jednotlivé číslice,
- funkci vyrovnávacích čísel.

/*
#figure(
  image("../assets/screenshots/3sat-ssp-ex1-input.png"),
  caption: [Zadání instance 3-SAT pro redukci na SSP]
)

#figure(
  image("../assets/screenshots/3sat-ssp-ex1-numbers.png"),
  caption: [Vygenerovaná množina čísel SSP]
)
*/

=== Instance se zápornou odpovědí

Formule:
$
  (x or x or x) and (not x or not x or not x)
$

Demonstruje případ, kdy nelze dosáhnout cílové hodnoty $tau$.

== Redukce 3-SAT na 3-CG

=== Instance s kladnou odpovědí

Formule:
$
  (alpha or beta or gamma) and (not alpha or beta or not gamma)
$

Instance ukazuje:
- jádrový konstrukční prvek a jeho obarvení,
- konstrukční prvky proměnných,
- propojení s konstrukčními prvky klauzulí.

/*
#figure(
  image("../assets/screenshots/3sat-3cg-ex1-graph.png"),
  caption: [Výsledný graf pro problém 3-CG]
)
*/

=== Instance se zápornou odpovědí

Formule:
$
  (a or a or a) and (not a or not a or not a)
$

Demonstruje případ, kdy graf není 3-obarvitelný.

== Redukce HCYCLE na HCIRCUIT

=== Instance s kladnou odpovědí

Orientovaný graf $G$ s hamiltonovským cyklem:
$
  V = \{A, B, C, D\}, 
  E = \{(A,B), (B,C), (C,D), (D,A), (A,C)\}
$

Instance ilustruje transformaci orientovaného grafu na neorientovaný
pomocí trojic vrcholů $v_i, v_b, v_o$.

=== Instance se zápornou odpovědí

Orientovaný strom (acyklický graf) demonstrující neexistenci hamiltonovského cyklu.

== Redukce HCIRCUIT na TSP

=== Instance s kladnou odpovědí

Neorientovaný graf obsahující hamiltonovskou kružnici.
Instance ukazuje přidání hran s vyšší vahou
a nastavení cílové hodnoty $k = |V|$.

/*
#figure(
  image("../assets/screenshots/hcircuit-tsp-ex1-graph.png"),
  caption: [Kompletní graf s ohodnocením hran]
)
*/

=== Instance se zápornou odpovědí

Graf neobsahující hamiltonovskou kružnici,
kde neexistuje cesta s cenou $k = |V|$.

== Shrnutí

Tato kapitola představila vybrané ukázkové instance
pro všechny implementované redukce.
Na konkrétních příkladech bylo demonstrováno,
jak aplikace vizualizuje proces redukce krok za krokem.

Zvolené instance pokrývají:
- různé velikosti vstupních dat,
- případy s kladnou i zápornou odpovědí,
- různorodé struktury vstupních instancí.

Tyto příklady slouží jako východisko pro výuku
a umožňují studentům experimentovat s vlastními instancemi.
