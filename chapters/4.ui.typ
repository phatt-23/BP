== Návrh uživatelského rozhraní <ui-chapter>

Tato kapitola se věnuje návrhu uživatelského rozhraní aplikace. 
Nejprve je popsána celková struktura rozhraní a následně jednotlivé komponenty.

=== Struktura rozhraní

Webová aplikace má navigační lištu, 
v níž jsou umístěny odkazy na domovskou stránku a na jednotlivé stránky redukcí. 
Z navigační lišty má uživatel přístup ke všem součástem aplikace. 
Domovská stránka obsahuje obecné informace o aplikaci 
a stručné definice problémů vyskytujících se v převodech.

Každá stránka redukce se skládá ze tří hlavních částí: 
- editační oblasti pro zadávání vstupní instance, 
- vizualizace vstupní instance a 
- vizualizace výstupní instance. 
Toto rozdělení umožňuje uživateli sledovat celý proces převodu instance z jednoho problému na jiný.

#figure(
  image("../assets/drawio/struktura_ui.svg"), 
  caption: [Wireframe model struktury rozhraní]
)

=== Komponenty stránky redukce

Následující podkapitoly podrobněji popisují jednotlivé komponenty stránky redukce.

==== Editační oblast

Editační oblast slouží k zadávání vstupní instance. 
Obsahuje textové vstupní pole a kontrolní panel. 
V horní části se nachází výběr ukázkových instancí. 
Při syntaktické chybě vstupu je uživatel informován chybovou hláškou.

Kontrolní panel obsahuje tři hlavní prvky. 
Tlačítko "Reduce" zahajuje převod vstupní instance na výstupní instanci. 
Tlačítko "Solve" spouští hledání řešení výstupní instance 
a v případě úspěchu provádí dekódování řešení zpět na řešení vstupního problému. 
Přepínač "Show Steps" zobrazuje jednotlivé kroky redukce.

Editor dále obsahuje instrukce a nápovědu k formátu vstupních dat, 
aby uživatel věděl, jak správně zadat instanci problému.

#figure(
  image("../assets/drawio/editor.svg"), 
  caption: [Wireframe model editační oblasti]
)

==== Vizualizace instance

Vizualizační oblast zobrazuje grafickou reprezentaci instance. 
Obě vizualizace, vstupní i výstupní instance, mají shodné rozložení. 
Hlavička obsahuje název problému. 
Hlavní část obsahuje grafickou reprezentaci instance. 
Zápatí obsahuje nalezené řešení nebo informaci o jeho neexistenci. 
Zadaná instance je průběžně vizualizována, 
což umožňuje okamžitou kontrolu správnosti vstupu.

#figure(
  image("../assets/drawio/vizualizace_instance.svg"), 
  caption: [Wireframe model vizualizace instance]
)

==== Zobrazení řešení

Po aktivaci funkce "Solve" se aplikace pokusí nalézt řešení cílového problému. 
V případě úspěchu je nalezené řešení zobrazeno 
a následně dekódováno na řešení vstupního problému, 
které je rovněž prezentováno uživateli. 
Obě řešení jsou zobrazena v zápatí příslušných sekcí 
a v případě vhodnosti jsou také graficky zvýrazněna.

U problému obchodního cestujícího jsou zvýrazněny hrany Hamiltonovského cyklu. 
U problému barvení grafu jsou vrcholy obarveny třemi barvami. 
U problému 3-SAT je řešení prezentováno textově.

==== Krokové zobrazení redukce

Přepínač "Show Steps" umožňuje zobrazit jednotlivé kroky redukce. 
Proces redukce je prezentován sekvenčně, 
přičemž každý krok transformace je graficky znázorněn a doplněn textovým vysvětlením. 
Uživatel může mezi jednotlivými kroky přecházet pomocí tlačítek "Next" a "Previous". 
Tento přístup umožňuje uživateli pochopit samotný konstrukční postup.

#figure(
  image("../assets/drawio/kroky_redukce.svg"), 
  caption: [Wireframe model krokového zobrazení redukce]
)

