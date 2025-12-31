// Without title (automatic)

- psát v 1. pádu množném 
  - Nyní se podíváme na NP problémy a vysvětlíme si jejich význam v teoretické informatice.
- dostat čtenáře do kontextu, aby vědel o každém termínu co znamená

- co jsou to problémy?
  - řešitelné, existuje alg, a neřešitelné problémy, neexistuje alg
  - co to je rozhodovací problém
    - jak lze problémy vyjádřit jako rozhodovací problémy
- třídy složitosti, krátký popis, příklady
  - podle času i podle paměti potřebné k řešení problému
    - T(f) třída rozhodovacích problémů s O(f) časovou složitostí
    - S(f) třída rozhodovacích problémů s O(f) prostorovou složitostí
    - rozlišujeme xTIME a xSPACE třídy
      - PTIME a PSPACE, LOGTIME a LOGSPACE, EXPTIME a EXPSPACE
      - v této práci nám jde o NPTIME-úplné problémy
- definice třídy NP a její význam
  - nepolynomiální alg pro nalezení řešení, jsou exponencionální
  - poly čas ověřovací alg
  - co to je svědek
- co jsou NP-těžké a NP-úplné třídy
  - ne každý NP-těžký problém je v NP, je těžší
  - kažký NP problém lze redukovat na NP-těžké problémy
  - NP-úplný problém P je: 
    - NP-těžký, tedy lze na něj redukovat jakýkoliv NP problém
    - P je zároveň ve třídě NP 
    - NP-úplné problémy lze redukovat mezi sebou
- v této práci:
  - zaměření na určité redukce
    - 3-SAT na HCYCLE, SSP, 3-CG
    - HCYCLE na HCIRCUIT, orientovaný graf na neorientovaný graf
    - HCIRCUIT na TSP, neorientovaný neohodnocený graf na neorientovaný ohodnocený graf
  - skádá se z částí:
    - use case analýza
      - vybrat převod
      - napsat do editoru instanci problému v textovém formátu
        - kontrola formátu
        - upozornit uživatele na chybnost vstupu
      - převést problém
        - převede instanci problému A na instanci problému B
        - vytvoří kroky pro převod, které lze potom zobrazit
      - vyřesit problém
        - problém B se začne řešit
          - pokud má řešení, převede se toto řešení na řešení problému A
          - jinak oba problémy nemají řešení
      - zobrazit postup převodu
        - zobrait celý postup
        - krokovat posutupně jednotlivé kroky
      - načíst úkazkovou instanci
        - výběr z listu
      - zkopírovat instance problému
        - nezpracovný text takový jak se jeví v editoru
        - zformátovaný text
      - zkopírovat řešení problému (zformatovaný)
      - uložit si vlastní instance problémů
        - u editoru bude tlačitko "uložit"
        - u editoru bude list pro načtení ukázkových instancí a uložených (vlastních) instancí
    - UI wireframe, jak si to představuju, že budou vypadat:
      - stránky
      - UI komponenty
    - volba techonologií
      - proč Svelte a Typescript?
        - Typescript 
          - nadstavba JavaScriptu, skriptovací jazyk všech podstatných browserů
          - výhody:
            - má striktnější typovací systém
              - ukázky, v čem jsou si odlišné
            - má třídy, stále prototypově objektivně-orientované programování a ne klasiké OOP s třídami
            - pracuje se s ním velmi podobně jako s JavaScriptem
          - nevýhody:
            - nemá třídy jako C++, je to prototypový programovací jazyk
            - při posílání objektů musí být serializovány a deserealizovány
              - příkladový kód
            - jelikož se transpiluje do JavaScriptu, který je čistě JIT skriptovací jazyk, není možné aplikaci debuggovat krokovaním intrukcí
        - Svelte
          - moderní, mainstream, podobné Reactu a všem moderním webovým-frontend frameworkům
          - logika, rozložení stránky a styly jsou propojené v jednom souboru
            - lokální CSS styly
              - v Reactu jsou style globální
            - Svelte komponenta vypadá a píše se jako HTML stránka
              - logika se píše v <script> tagu
              - v Reactu jsou to funkce, které vrací HTML
          - umožňuje pracovat s UI komponenty jako s HTML tagy
          - je tranpilovaný do HTML a JS, podobně jako React
          - má stejné možnosti jako ostatní web-frameworky
            - ze všech mi příjde nejelegantnější
      - proč statická stránka a ne server-client přístup?
        - server-client se hodí, pokud data ukládáme v databázi, či jsou výpočty až moc náročné na to, aby běželi na klientských počítačích
        - server-client vyžaduje připojení k internetu
        - instance serveru by musela být v provozu jako proces na nějakém počítači
        - statická stránka umožňuje uživateli stránku celou stáhnout a použivat ji offline
      - knihovny
        - Cytoscape
          - vykreslování grafů
        - KaTeX
          - sazba textu založená na syntaxi TeX
          - pro vykreslování matematiky
        - Boostrap
          - stylizace CSS
        - Tailwind CSS
          - stylizace komponent
        - Sass CSS
          - nadstavba CSS, asi neni potreba
      
- struktura projektu
  - Svelte-Kit framework struktura
      - routes, lib, app.html, app.scss
  - struktura mého projektu 
    - solver, decoder, reducer, workers, ...




== 1. Introduction

*Purpose:* Context + motivation + clear goal

Typical content:

- Motivation: why NP-complete problems and reductions are hard for students
- Why an interactive educational web server makes sense
- Positioning within the existing teaching server (brief)
- *Goals of the thesis* (very explicit, ideally bullet points)
- Brief description of what was implemented (without details)

Example goals:

- Explain complexity classes and NP-completeness
- Design and implement an educational web component
- Implement at least 3 polynomial-time reductions
- Enable step-by-step visualization and explanation

---

== 2. Theoretical Background

*Purpose:* Show you understand the theory behind what you implement

=== 2.1 Computational Complexity

- Decision problems
- Time complexity (P, NP)
- Polynomial-time algorithms

=== 2.2 Class NP and NP-Completeness

- Definition of NP
- Verifiers vs solvers
- Definition of NP-complete problems
- Importance of reductions

=== 2.3 Polynomial-Time Reductions

- Formal definition
- Properties (transitivity, correctness preservation)
- Why reductions are used to prove NP-completeness
- Educational perspective (intuition over formalism)

👉 *No implementation details here* — pure theory.

---

== 3. Selected NP-Complete Problems

*Purpose:* Define the concrete problems your system works with

Create *one subsection per problem*, e.g.:

=== 3.1 Problem A (e.g. SAT)

- Formal definition
- Input format
- Question being answered (YES/NO)
- Small illustrative example

=== 3.2 Problem B (e.g. 3-SAT)

=== 3.3 Problem C (e.g. Vertex Cover)

Only include problems that:

- Appear in your reductions
- Are supported by the web application

---

== 4. Reductions Between Problems

*Purpose:* Core theoretical contribution of the thesis

Create *one subsection per reduction*, e.g.:

=== 4.1 Reduction from SAT to 3-SAT

- High-level idea of the reduction
- Step-by-step conceptual explanation
- Proof sketch of correctness:

  - If original instance is YES ⇒ reduced instance is YES
  - If reduced instance is YES ⇒ original instance is YES
- Time complexity argument (polynomial)

⚠️ Important:

- Match this *1:1 with what the web app visualizes*
- Focus on *understanding*, not minimal formal proofs

---

== 5. Design of the Educational Web Application

*Purpose:* Explain how theory is transformed into a teaching tool

=== 5.1 Requirements Analysis

- Functional requirements (based directly on assignment)
- Non-functional requirements (clarity, usability, educational value)

=== 5.2 System Architecture

- Client–server model (if applicable)
- Technologies used (frameworks, languages)
- Data flow overview

=== 5.3 User Interface Design

- How users:

  - Select problems
  - Enter instances
  - View reductions step by step
- Emphasis on didactic clarity

Diagrams are *strongly recommended* here.

---

== 6. Implementation

*Purpose:* Show that the system actually works

=== 6.1 Representation of Problem Instances

- How instances are encoded internally
- Validation of user input

=== 6.2 Implementation of Reductions

- How each reduction is implemented
- Mapping of theoretical steps to code steps
- How intermediate steps are stored and displayed

⚠️ Emphasize:

> “The goal was clarity, not optimal performance.”

=== 6.3 Solving the Problems

- How answers (YES/NO) are computed
- How explanations are generated for positive instances

---

== 7. Example Instances and Demonstration

*Purpose:* Fulfill assignment requirement + show usability

- At least *5 example instances per problem*
- Explanation of why these instances were chosen
- Screenshots or walkthroughs of:

  - Instance input
  - Reduction visualization
  - Final answer and justification

---

== 8. Evaluation

*Purpose:* Reflect on results and limitations

Possible angles:

- Educational value
- Clarity of reductions
- Limitations of the current approach
- Comparison to static teaching materials

Optional:

- Informal feedback from users (students)

---

== 9. Conclusion and Future Work

*Purpose:* Proper academic closure

- Summary of achieved goals
- What works well
- What could be extended:

  - More NP-complete problems
  - More reductions
  - Better visualization
  - Integration into courses

---

== Appendices (if needed)

- Detailed algorithms
- Full input grammars
- Additional screenshots

---

== Key Supervisor Expectations (Important)

- *Strong alignment between theory and implementation*
- Clear didactic motivation
- Reductions explained in a way students can understand
- Not just a “web app thesis” — theory must be visible

---

If you want, next we can:

- Map *your chosen 3 reductions* directly into chapters
- Help you write *exact thesis objectives*
- Review your *chapter titles in Czech*
- Help with *formal Czech academic phrasing*

Just tell me 👍

