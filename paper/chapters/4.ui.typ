// TODO: přidat wireframe diagramy

== Návrh uživatelského rozhraní <ui-chapter>

Tato kapitola se věnuje návrhu uživatelského rozhraní aplikace. 
Nejprve je popsána celková struktura rozhraní a následně jednotlivé komponenty.

=== Struktura rozhraní

Webová aplikace má navigační lištu, v níž jsou umístěny odkazy na domovskou stránku a na jednotlivé stránky redukcí. Z navigační lišty má uživatel přístup ke všem součástem aplikace. Domovská stránka obsahuje obecné informace o aplikaci a stručné definice problémů vyskytujících se v převodech.

Každá stránka redukce se skládá ze tří hlavních částí: editační oblasti pro zadávání vstupní instance, vizualizace vstupní instance a vizualizace výstupní instance. Toto rozdělení umožňuje uživateli sledovat celý proces převodu instance z jednoho problému na jiný.

#figure(
  image("../assets/drawio/struktura_ui.svg"), 
  caption: [
    Wireframe model obecné struktury rozhraní aplikace // sounds complicated
  ]
)

=== Komponenty stránky redukce

Následující podkapitoly podrobněji popisují jednotlivé komponenty stránky redukce.

==== Editační oblast

Editační oblast slouží k zadávání vstupní instance. Obsahuje textové vstupní pole a kontrolní panel. V horní části se nachází výběr ukázkových instancí. Při syntaktické chybě vstupu je uživatel informován chybovou hláškou. Kontrolní panel obsahuje tlačítka "Reduce" a "Solve" a přepínač "Show Steps".

// toto uprav do vet
// nevim jestli je to uplne potreba to zase psat
// takze se rozhodni na tom jestli je vubec nutne
// inkludovat tyto nasledne veci
tlacitko "Reduce" - zacne prevadet/redukovat vstupni instanci na vystpni
tlacitko "Solve" - zacne nalezat vystupni instanci, v pripade nalezu dekoduje
tlacitko "Show Steps" - ukaze kroky


#figure(
  image("../assets/drawio/editor.svg"), 
  caption: [
    Wireframe model editační oblasti
  ]
)

==== Vizualizace instance

Vizualizační oblast zobrazuje grafickou reprezentaci instance. Obě vizualizace, vstupní i výstupní instance, mají shodné rozložení. Hlavička obsahuje název problému. Hlavní část obsahuje grafickou reprezentaci instance. Zápatí obsahuje nalezené řešení nebo informaci o jeho neexistenci. Zadaná instance je průběžně vizualizována, což umožňuje okamžitou kontrolu správnosti vstupu.

#figure(
  image("../assets/drawio/vizualizace_instance.svg"), 
  caption: [
    Wireframe model vizualizace instance
  ]
)

==== Krokové zobrazení redukce

Přepínač "Show steps" umožňuje zobrazit jednotlivé kroky redukce. 
Proces redukce je prezentován sekvenčně, přičemž každý krok transformace je graficky znázorněn a doplněn textovým vysvětlením. Tento přístup umožňuje uživateli pochopit nejen výslednou instanci, ale i samotný konstrukční postup.

#figure(
  image("../assets/drawio/kroky_redukce.svg"), 
  caption: [
    Wireframe model editační oblasti
  ]
)

==== Zobrazení řešení

Po aktivaci funkce "Solve" se aplikace pokusí nalézt řešení cílového problému. V případě úspěchu je nalezené řešení zobrazeno a následně dekódováno na řešení vstupního problému, které je rovněž prezentováno uživateli. Obě řešení jsou zobrazena v zápatí příslušných sekcí a v případě vhodnosti jsou také graficky zvýrazněna.

U problému obchodního cestujícího jsou zvýrazněny hrany Hamiltonovského cyklu. U problému barvení grafu jsou vrcholy obarveny třemi barvami. U problému 3SAT je řešení prezentováno textově.
