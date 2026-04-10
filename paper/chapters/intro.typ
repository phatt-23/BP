// Uvést čtenáře do kontextu.
//
// - Vysvětlit stručně teorii složitosti algoritmů a v průběhu se zaměřit na termín NP-Complete.
//   
// Jaká je motivace téhle práce? Co je problémem, který se snaží vyřešit?
//
// - Studenti a vyučující TI, chtějí vizualizovat převody mezi problémy. 
// - Z vizualizací lze mnohem pochopit redukce, než ze čtení formálních textů.
// - Umožnit interaktivní zobrazení redukcí a jejich postup.
// - Zobecnění pro, každou instanci problému. Konec statických animací redukcí pro specifické vstupní instance.
//
// Jaké cíle má tahle práce? Co chce přínést, unsnadnit, v čem má pomoct?
//
// - Příjít s řešením pro satisfakci vylistovaných motivací.
// - Má za cíl, poskytnout interaktivní GUI pro zadavaní instancí. 
// #[ 
//   Vizualizace vstupních a výstupních instancí, ať už to jsou logické výrazy,
//   orientované/neorientované grafy s nebo bez ohodnocení hran, tabulky pro čísla
//   jako vstupní instance pro problém SSP. 
// ]
//
// - Zobrazit certifikáty k daným problémum, pokud existují. 
// - Zobrazit i certifikát pro vstupní instanci, pokud má certifikát výstupní instance.
// - Zobrazit postup pro jednotlivé redukce.
//
// Co bylo vytvořeno.
//
// - Webová aplikace, která funguje podobně jako online kalkulačky (např. integrální kalkulačky, zobrazujicí postup, atd...).

Tato práce se zabývá problematikou výpočetní složitosti algoritmů
se zaměřením na třídu NP-úplných problémů.
Výpočetní složitost představuje jednu ze základních disciplín informatiky,
která studuje množství zdrojů potřebných k vyřešení algoritmického problému.
Mezi tyto zdroje patří především čas potřebný k výpočtu
a paměť nutná k uložení mezivýsledků.

Zvláštní postavení v teorii složitosti zaujímají takzvané NP-úplné problémy.
Jedná se o problémy, pro které není znám algoritmus řešící je v polynomiálním čase,
avšak při nalezení takového algoritmu by bylo možné efektivně řešit všechny ostatní problémy
z této třídy.
Otázka, zda takový algoritmus existuje, zůstává jedním z největších nevyřešených problémů
moderní matematiky a informatiky.

Klíčovým nástrojem pro studium vztahů mezi problémy jsou polynomiální redukce.
Redukce umožňují převést instanci jednoho problému na instanci problému jiného
takovým způsobem, že řešení druhého problému lze využít k získání řešení problému prvního.
Tento koncept je fundamentální pro definici NP-úplnosti
a umožňuje hlubší pochopení struktury třídy NP.

Studium redukcí je však náročné.
Formální popisy redukcí jsou často abstraktní a obtížně představitelné.
Studenti i vyučující se při snaze pochopit principy převodů mezi problémy
setkávají s bariérou mezi teoretickým popisem a jeho vizuální reprezentací.
Existující výukové materiály a animace jsou navíc zpravidla statické
a omezené na konkrétní vstupní instance.
Neexistuje nástroj, který by umožnil interaktivní práci
s libovolnou instancí libovolného podporovaného problému.

Cílem této práce je navrhnout a implementovat webovou aplikaci,
která tuto mezeru vyplní.
Aplikace bude fungovat jako interaktivní výuková pomůcka
umožňující zadávání vlastních instancí problémů,
provádění polynomiálních redukcí mezi nimi
a vizualizaci celého procesu včetně jednotlivých kroků.

Práce je strukturována následovně.
První kapitola zavádí základní pojmy z teorie výpočetní složitosti
nezbytné pro další části práce.
Druhá kapitola představuje vybrané NP-úplné problémy,
se kterými systém pracuje, včetně jejich formálních definic a příkladů instancí.
Třetí kapitola tvoří teoretické jádro práce
a obsahuje detailní popis polynomiálních redukcí mezi těmito problémy.
Čtvrtá kapitola se věnuje návrhu webové aplikace
z hlediska architektury a uživatelského rozhraní.
Pátá kapitola popisuje implementaci systému
včetně reprezentace dat a algoritmů.
Šestá kapitola představuje ukázkové instance a demonstraci funkcionality.
Závěrečná kapitola shrnuje dosažené výsledky a diskutuje možná rozšíření.
