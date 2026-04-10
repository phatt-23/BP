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
výpočetní složitosti, 
konkrétně problematiku polynomiálních redukcí mezi rozhodovacími problémy, 
do interaktivního výukového nástroje.

Aplikace umožňuje studentům nejen pasivně studovat formální důkazy,
ale aktivně pracovat s konkrétními instancemi problémů. 
Uživatel může zadávat vlastní vstupy, 
sledovat konstrukci redukce krok za krokem
a vizuálně porovnávat vstupní a výslednou instanci včetně jejích odpovědí. 

Dochází tím k propojení formální matematické teorie s názornou vizualizací, 
což podporuje hlubší porozumění probírané látce.


== Analýza požadavků

Aplikace musí splňovat následující funkční požadavky:

- umožnit výběr konkrétní redukce mezi rozhodovacími problémy,
- umožnit zadání libovolné instance vstupního problému,
- provést redukci vstupní instance na instanci cílového problému,
- vizualizovat vstupní a výslednou instanci,
- umožnit výběr z ukázkových vstupních instancí
- pokud je odpověď na rozhodovací otázku kladná, 
  umožnit zobrazení nalezeného řešení ve vstupním i cílovém problému,
- krokové zobrazení procesu redukce, 
  včetně textového vysvětlení jednotlivých transformačních kroků.

=== Nefunkční požadavky

- zvýraznit konstrukční prvky v zobrazení cílových instancí,
- umožnit uživateli interaktivně manipulovat se vstupním grafem


== Architektura systému

=== Architektonický model

Aplikace je navržena jako klientská webová aplikace bez jakékoli serverové části.
Veškerá aplikační logika je vykonávána na straně klienta v prostředí webového prohlížeče.
Jsou to jen statické stránky.

=== Použité technologie

```
"dependencies": {
        "@types/cytoscape": "^3.21.9",
        "cytoscape": "^3.33.1",
        "cytoscape-canvas": "^3.0.1",
        "katex": "^0.16.27",
}
```

Zvolil jsem webový framework Svelte. 
Je to framework, ktery efektivne spojuje technologie HTML, CSS a JavaScript do jednoho.
Ve frameworku svelte jsem pracoval v jazyce TypeScript. 
Nepouzil jsem cisty JavaScript, protoze nema striktni typovani. 
Pri praci nad vetsim projektem se vzdy hodi vedet typy a tak.

Pro vizualizaci grafů jsem použil knihovnu Cytoscape.
Je to jedna ze standardnich knihoven pro praci s grafy.

Pro zobrazení notace v LaTeX stylu jsem použil knihovnu Katex.
Tato knihovna umoznuje psat vyrazy v LaTeXu, ktere se potom konvertuji na HTML.


// nevim jestli to co rikam je uplne pravda, takze to over.


=== Tok dat v systému

Z hlediska toku dat lze proces zpracování rozdělit do následujících kroků:

1. Uživatel zadá instanci vstupního problému.
+ Tato instance je převedena do interní reprezentace systému.
+ Redukční modul transformuje vstupní instanci na odpovídající instanci cílového problému.
+ Solver se pokusí najít řešení cílové instance.
+ V případě úspěchu dekodér převede řešení zpět na řešení původní vstupní instance.

// 

== Návrh uživatelského rozhraní

=== Výběr redukce 

V horní části rozhraní se nachází modul pro výběr konkrétní redukce.
// Součástí této části může být i stručné teoretické shrnutí daného problému.

=== Zadání instance

Uživatel má možnost:

- zadat (seznam vrcholu a hran, seznam klauzuli),
- načíst předdefinovaný příklad,
- interaktivně vytvářet graf (pouze v případě grafu),

Zadaná instance je vizualizována, 
což umožňuje kontrolu správnosti vstupu.

=== Rozložení stránky

Stránka se skládá z karet:
- editor 
- vstupní instance 
- výstupní instace.

V kartě editor se nachází samotný editor s textovým vstupem a kontrolní panel.

Editor slouží pro zadavání vstupní instance.
Na levém horním rohu se nachází dropdown s ukázkovými instancemi.
Při chybe syntaxe vstupu se v levem dolnim rohu zobrazi cervene chybova hlaska.

Kontronlní panel má tlačítka "Reduce" a "Solve" a přepínač "Show steps".

Karty vstupní instance a výstupní instace mají stejné rozložení.
V hlavicce maji nazev problemu,
v tele je graficke zobrazeni instance
a zapati je misto pro certifikat / nalezene reseni pripadne text rikajici ze reseni neexistuje.


=== Krokové zobrazení redukce

Prepinac "Show steps" zobrazi kroky, 
jinak zustavaji skryte.

Proces redukce je prezentován sekvenčně.
Každý krok transformace je graficky zvýrazněn a doplněn textovým vysvětlením.

Tím je zajištěno, že uživatel rozumí nejen výsledku,
ale i samotnému konstrukčnímu postupu.


=== Zobrazení řešení

Zmacknuti tlacitka "Solve" se aplikace pokusi najit reseni pro vystupni problem.
Pokud jej najde, zobrazi jej a dekoduje ho na reseni vstupniho problemu, ktery se taktez zobrazi, 
a to v zapati karet vstupní instance a výstupní instace.

Řešení problému jsou take vyznacene v grafickem zobrazeni instanci, 
pokud je to vhodne - u grafu a problemu SSP, u problemu 3SAT se to nehodi.
Například v případě nalezeni reseni na problém obchodního cestujícího jsou 
zobrazeny hrany hamiltonovkeho cyklu cervene, 
u problemu barveni grafu jsou vybarvene vrcholy.


