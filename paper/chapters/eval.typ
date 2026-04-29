= Zhodnocení

V této kapitole jsou shrnuty dosažené výsledky, diskutována omezení navrženého řešení
a nastíněny možnosti budoucího rozvoje.

== Shrnutí výsledků

Cílem této práce bylo navrhnout a implementovat interaktivní výukovou aplikaci
pro vizualizaci polynomiálních redukcí mezi NP-úplnými problémy.
Tento cíl byl splněn.

Byla implementována webová aplikace umožňující:

- Zadávání vlastních instancí problémů 3-SAT, HCYCLE, HCIRCUIT, TSP, SSP a 3-CG.
- Automatické provádění redukcí mezi těmito problémy.
- Krokové zobrazení procesu redukce s vysvětlením jednotlivých operací.
- Vizualizaci vstupních a výstupních instancí v podobě grafů, logických výrazů a tabulek.
- Nalezení řešení výstupní instance pomocí implementovaných algoritmů.
- Dekódování řešení zpět na řešení vstupní instance.
- Zobrazení nalezených certifikátů řešení.

Aplikace byla navržena s důrazem na přehlednost a srozumitelnost.
Kód reflektuje teoretický popis redukcí,
což usnadňuje pochopení souvislostí mezi formální teorií a její implementací.

== Výuková hodnota

Navržená aplikace přináší několik výhod oproti tradičním statickým výukovým materiálům.

Za prvé, uživatel může pracovat s libovolnou vlastní instancí problému.
Na rozdíl od předpřipravených animací tak může experimentovat
a ověřovat si své pochopení na konkrétních příkladech.

Za druhé, krokové zobrazení redukce umožňuje sledovat,
jakým způsobem je instance transformována.
Každý krok je doplněn o textové vysvětlení. // využívající matematické zápisy.

Za třetí, možnost dekódování řešení demonstruje,
jakým způsobem lze z řešení výstupní instance odvodit řešení instance vstupní.
Toto propojení je klíčové pro pochopení korektnosti redukcí.

Za čtvrté, vizualizace certifikátů řešení poskytuje konkrétní příklad
toho, jak vypadá řešení daného problému.
U grafových problémů je certifikát zobrazen přímo v grafu,
u problému 3-SAT je zobrazen nalezeném ohodnocení proměnných.

== Omezení

// AGENT: rewrite for better reading flow

Navržené řešení má několik omezení.

Podporované problémy a redukce jsou omezeny na množinu definovanou v rámci práce.
Přidání nových problémů nebo redukcí vyžaduje implementaci nových tříd
a může vyžadovat úpravu stávající architektury.

Řešící algoritmy jsou implementovány na klientské straně v JavaScriptu.
Pro velmi rozsáhlé instance může být výpočet časově náročný
a může vést ke snížení odezvy aplikace.

// AGENT: I added this, incorporate it better into the text
Vizuální reprezentace grafů je založena na automatickém rozložení,
které nemusí být vždy optimální.
// AGENT: I added this, incorporate it better into the text
I když byly manuálně napsany 
algoritmy pro umísťování vrcholů 
pro některé převody
za účelem zlepšení čitelnosti výsledných grafů,
i přesto u složitějších instancí může být výsledný graf stále obtížně čitelný.
// AGENT: I added this, incorporate it better into the text
Stejne tak plati i u vizualizacich v TeX.
Ne vzdy je text rozlozen nejcitelneji.

// AGENT: I added this, incorporate it better into the text
UI je navrzeno pro desktop, pri vyvoji se nemyslelo na prenosne zarizeni s mensim displejem.

== Možnosti rozšíření

Navržené řešení lze rozšířit v několika směrech.

Podpora dalších NP-úplných problémů a redukcí, 
například redukce 3-SAT na problém maximálního řezu (Max-Cut)
nebo redukce na problém nezávislé množiny (Independent Set),
by umožnila demonstraci širší škály převodů.

// AGENT: I added this, incorporate it better into the text
Možnost exportovat grafové instance jako obrázky, export do TeX textu.
Možnost ukládat si své vlastní instance přímo na stránce s využitím např. localStorage.


