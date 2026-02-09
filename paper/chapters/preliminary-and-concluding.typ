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
    #lorem(20)

    #lorem(40)
  ],
  cs: [
    #lorem(40)

    #lorem(60)
  ]
)

// Keywords are put in a list. If the list is empty the page won't be rendered.
#let keywords = (
  en: (
    ..lorem(20).split(" "),
  ),
  cs: (
    ..lorem(20).split(" "),
  )
)

// Thanks. Is optional so I added `want-to-include` switch.
#let thanks = (want-to-include: true, body: [
  #lorem(30)
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
  ([Demo appendix], 
  [
    Bla Bla popis.

    #sourcecode(```txt
      bla bla
    ```)
  ]),
)
