#import "/lib/global.typ": *

// Note that if any section gets too long you can always create new files and
// separate it out into multiple files. And then just import or include them in here.

// Titles shown in the title page. 
// You should do this manually and not just getting the string from the lang-database.yml, 
// because, if the title is long, it's will break in weird uncontrollable ways.
//
// #linguify("title", lang: "cs")
// #linguify("title", lang: "en")
#let title = (
  cs: (
    main: [
      Komponenta výukového serveru TI \ // -- \ 
      NP-úplné problémy 2
    ],
    sub: [
      Komponenta výukového serveru TI \ //-- \ 
      NP-úplné problémy 2
    ],
  ),
  en: (
    main: [
      Component of Learning Server for \
      Theoretical~Computer~Science \ // -- \
      NP-complete~problems~2
    ],
    sub: [
      Component of Learning Server for \
      Theoretical~Computer~Science \ // -- \
      NP-complete~problems~2
    ],
  )
)

// Abstracts. Are mandatory.
#let abstract = (
  en: [
    This thesis deals with the complexity theory of algorithms with focus on NP-complete problems.
    A key tool for studying these problems are polynomial reductions,
    which allow transforming instances of one problem to another.
    Understanding reductions is often challenging due to their abstract nature
    and the lack of interactive tools.

    The goal of this thesis is to design and implement a web application
    that enables interactive visualization of polynomial reductions
    between selected NP-complete problems.
    The application allows users to input their own problem instances,
    perform reductions, view step-by-step explanations,
    and visualize solutions.

    The result is an interactive educational tool
    that connects theoretical concepts with practical implementation.
  ],
  cs: [
    Tato práce se zabývá teorií výpočetní složitosti algoritmů se zaměřením na NP-úplné problémy.
    Klíčovým nástrojem pro studium těchto problémů jsou polynomiální redukce,
    které umožňují převod instancí jednoho problému na problém jiný.
    Pochopení redukcí je často náročné kvůli jejich abstraktní povaze
    a nedostatku interaktivních nástrojů.

    Cílem této práce je navrhnout a implementovat webovou aplikaci
    umožňující interaktivní vizualizaci polynomiálních redukcí
    mezi vybranými NP-úplnými problémy.
    Aplikace umožňuje uživatelům zadávat vlastní instance problémů,
    provádět redukce, zobrazovat kroky s vysvětlením
    a vizualizovat řešení.

    Výsledkem je interaktivní výuková pomůcka
    spojující teoretické koncepty s praktickou implementací.
  ]
)

// Keywords are put in a list. If the list is empty the page won't be rendered.
#let keywords = (
  en: (
    "NP-complete problems",
    "polynomial reductions",
    "computational complexity",
    "interactive visualization",
    "educational tool",
    "3-SAT",
    "Hamiltonian cycle",
    "graph coloring",
  ),
  cs: (
    "NP-úplné problémy",
    "polynomiální redukce",
    "výpočetní složitost",
    "interaktivní vizualizace",
    "výuková pomůcka",
    "3-SAT",
    "hamiltonovský cyklus",
    "barvení grafu",
  )
)

// Thanks. Is optional so I added `want-to-include` switch.
#let thanks = (want-to-include: true, body: [
  Rád bych poděkoval vedoucímu práce za cenné rady a připomínky během celého procesu tvorby.
  Dále děkuji všem, kteří poskytli zpětnou vazbu k raným verzím aplikace.
])

// List of symbols and abbreviations.
#let symbols-and-abbrevs = (
  ([EXP, EXPTIME], [Exponentional Time]),
  ([P, PTIME], [Polynomial Time]),
  ([NP, NPTIME], [Non-deterministic Polynomial Time]),
  ([3-SAT], [3-Satisfiability]),
  ([TSP], [Traveling Salesman Problem]),
  ([HCYCLE], [Hamiltonian Cycle Problem]),
  ([HCIRCUIT], [Hamiltonian Circuit Problem]),
  ([SSP], [Subset Sum Problem]),
  ([3-CG], [3-Coloring Problem]),
  ([DPLL], [Davis-Putnam-Logemann-Loveland]),
)

// Intro. Is mandatory.
#let intro = [
  #include "/chapters/intro.typ"
]

// Conclusion. Is mandatory.
#let conclusion = [
  #include "/chapters/outro.typ"
]

// Appnedices. Is optional, if you leave an empty list it won't render anything.
#let appendices = (
  // ([Demo appendix], 
  // [
  //   Bla Bla popis.
  //
  //   #sourcecode(```txt
  //     bla bla
  //   ```)
  // ]),
)
