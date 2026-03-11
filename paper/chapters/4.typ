// = Návrh webové aplikace 
//
// *Purpose:* 
// - Explain how theory is transformed into a teaching tool
//
// == Analýza požadavků
//
// - Functional requirements (based directly on assignment)
// - Non-functional requirements (clarity, usability, educational value)
//
// == Architektura systému
//
// - Client only model 
// - Technologies used (frameworks, languages)
// - Data flow overview
//
// == Návrh uživatelského rozhraní
//
// - How users:
//   - Select problems
//   - Enter instances
//   - View reductions step by step
// - Emphasis on didactic clarity
//
// Diagrams are strongly recommended here.

= Návrh webové aplikace

== Účel aplikace

Cílem navrhované webové aplikace je převést teoretické poznatky z oblasti
výpočetní složitosti, konkrétně problematiku polynomiálních redukcí mezi
rozhodovacími problémy, do interaktivního výukového nástroje.

Aplikace umožňuje studentům nejen pasivně studovat formální důkazy,
ale aktivně pracovat s konkrétními instancemi problémů. Uživatel může
zadávat vlastní vstupy, sledovat konstrukci redukce krok za krokem
a vizuálně porovnávat vstupní a výslednou instanci. Tím dochází
k propojení formální matematické teorie s názornou vizualizací,
což podporuje hlubší porozumění probírané látce.

#v(1em)

== Analýza požadavků

=== Funkční požadavky

Na základě zadání práce musí aplikace splňovat následující funkční požadavky:

- umožnit výběr konkrétní redukce mezi rozhodovacími problémy
  (například převod problému HCIRCUIT na problém obchodního cestujícího),
- umožnit zadání instance vstupního problému,
- automaticky provést konstrukci odpovídající instance cílového problému,
- vizualizovat vstupní i výsledný graf,
- zvýraznit strukturální odpovídající prvky (například hrany určité váhy),
- umožnit zobrazení nalezeného řešení v cílovém problému.

Dále je požadováno, aby aplikace podporovala krokové zobrazení procesu
redukce, včetně textového vysvětlení jednotlivých transformačních kroků.

=== Nefunkční požadavky

Kromě funkčních požadavků musí aplikace splňovat také následující
nefunkční požadavky:

*Přehlednost a srozumitelnost*

- grafické rozhraní musí být jednoznačné a vizuálně konzistentní,
- barevné rozlišení musí nést významovou informaci,
- jednotlivé kroky redukce musí být jasně odděleny.

*Použitelnost*

- ovládání aplikace musí být intuitivní,
- reakce systému musí být okamžitá,
- rozhraní musí být použitelné bez nutnosti studia podrobné dokumentace.

*Didaktická hodnota*

- aplikace musí podporovat pochopení principu redukce,
- uživatel musí být schopen sledovat vztah mezi vstupní a výstupní instancí,
- jednotlivé kroky musí být doplněny vysvětlujícím komentářem.

#v(1em)

== Architektura systému

=== Architektonický model

Aplikace je navržena jako klientská webová aplikace bez serverové části.
Veškerá aplikační logika je vykonávána na straně klienta
v prostředí webového prohlížeče.

Tento přístup přináší následující výhody:

- jednoduché nasazení,
- absence potřeby backendové infrastruktury,
- okamžitá odezva při interakci s uživatelem.

=== Použité technologie

Implementace aplikace předpokládá využití standardních webových technologií:

- HTML pro strukturu dokumentu,
- CSS pro vizuální styl,
- JavaScript nebo TypeScript pro implementaci aplikační logiky,
- knihovnu pro vizualizaci grafů (například založenou na SVG nebo Canvas).

Volba konkrétních nástrojů je motivována požadavkem na dynamickou
manipulaci s grafovou strukturou a možnost vizuálního zvýrazňování
jednotlivých prvků.

=== Tok dat v systému

Z hlediska toku dat lze proces zpracování rozdělit do následujících kroků:

1. Uživatel zadá instanci vstupního problému.
2. Instance je převedena do interní reprezentace grafu.
3. Modul redukce vytvoří odpovídající instanci cílového problému.
4. Vizualizační modul vykreslí obě instance.
5. Výsledek je prezentován uživateli prostřednictvím grafického rozhraní.

#v(1em)

== Návrh uživatelského rozhraní

Uživatelské rozhraní je navrženo s důrazem na didaktickou přehlednost
a logickou strukturu.

=== Výběr problému

V horní části rozhraní se nachází modul pro výběr konkrétní redukce.
Součástí této části může být i stručné teoretické shrnutí daného problému.

=== Zadání instance

Uživatel má možnost:

- interaktivně vytvářet graf,
- zadat seznam hran,
- načíst předdefinovaný příklad.

Zadaná instance je okamžitě vizualizována, což umožňuje kontrolu správnosti vstupu.

=== Krokové zobrazení redukce

Proces redukce je prezentován sekvenčně.
Každý krok transformace je:

- graficky zvýrazněn,
- doplněn textovým vysvětlením,
- oddělen od ostatních kroků.

Tím je zajištěno, že uživatel rozumí nejen výsledku,
ale i samotnému konstrukčnímu postupu.

=== Zobrazení řešení

Po provedení redukce může aplikace zobrazit řešení cílového problému
a vyznačit odpovídající strukturu v grafu.
V případě redukce na problém obchodního cestujícího je například
zobrazen hamiltonovský cyklus a jeho celková cena.

#v(1em)

== Shrnutí návrhu

Navržená aplikace propojuje formální teorii redukcí s interaktivní
vizualizací. Důraz je kladen nejen na správnost implementace,
ale především na didaktickou hodnotu nástroje.

Cílem není pouze automatizovat konstrukci redukce,
ale umožnit studentovi pochopit její princip a strukturu.

