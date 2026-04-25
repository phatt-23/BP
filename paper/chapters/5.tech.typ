== Použité technologie

Aplikace je implementována pomocí frameworku Svelte
#footnote[
  https://svelte.dev/
],
který poskytuje komponentově orientovaný přístup
k tvorbě uživatelského rozhraní.
// Aplikace je postavena na frameworku SvelteKit,
// který poskytuje komponentově orientovaný přístup k tvorbě uživatelského rozhraní
// a podporu pro routing a serverovou renderaci.

Vývoj probíhal v jazyce TypeScript,
který rozšiřuje jazyk JavaScript o statické typování.
To umožňuje lepší kontrolu nad strukturou dat,
zvyšuje čitelnost kódu a snižuje pravděpodobnost vzniku chyb.
// Implementace je napsána v jazyce TypeScript,
// který rozšiřuje JavaScript o statické typování.
// TypeScript umožňuje lepší kontrolu nad strukturou dat
// a snižuje pravděpodobnost vzniku chyb při vývoji.

Pro vizualizaci grafových struktur je využita knihovna Cytoscape
#footnote[
  https://js.cytoscape.org/
],
která představuje jedním ze standardních nástrojů pro práci s grafy ve webovém prostředí.
// Pro vizualizaci grafových struktur je využita knihovna Cytoscape.js,
// která nabízí rozsáhlé možnosti konfigurace vykreslování grafů.

Pro vykreslování matematických výrazů v LaTeX syntaxi
je použita knihovna KaTeX #footnote[https://katex.org/],
která převádí LaTeX zápis do HTML reprezentace vhodné pro zobrazení v prohlížeči.
// Matematické výrazy jsou vykreslovány pomocí knihovny KaTeX,
// která převádí LaTeX syntaxi na HTML reprezentaci.
// Toto umožňuje prezentovat formální popisy redukcí
// včetně matematických vzorců přímo ve webovém prohlížeči.

Pro sestavení aplikace je využit nástroj Vite,
který poskytuje rychlý vývojový server a optimalizovanou produkční sestavení.


