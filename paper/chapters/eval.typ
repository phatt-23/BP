= Zhodnocení

V této kapitole jsou shrnuty dosažené výsledky, diskutována omezení navrženého řešení
a nastíněny možnosti budoucího rozvoje.

== Shrnutí výsledků

Cílem této práce bylo navrhnout a implementovat interaktivní výukovou aplikaci
pro vizualizaci polynomiálních redukcí mezi NP-úplnými problémy.
V rámci práce byla tato aplikace realizována.

Konkrétně byla implementována webová aplikace umožňující:
    
#list(//indent: 1.2em,
  [Zadávání vlastních instancí vstupních problémů a automatické provádění redukcí mezi problémy.],
  [Krokové zobrazení procesu redukce s vysvětlením jednotlivých operací.],
  [Vizualizaci vstupních a výstupních instancí v podobě grafů, logických výrazů a tabulek.],
  [Nalezení řešení výstupní instance pomocí implementovaných algoritmů.],
  [Dekódování řešení zpět na řešení vstupní instance.],
  [Zobrazení nalezených certifikátů řešení.],
)

== Výuková hodnota

Navržená aplikace přináší několik výhod oproti tradičním statickým výukovým materiálům:

+ #[
  Uživatel může pracovat s libovolnou vlastní instancí problému.
  Na rozdíl od předpřipravených animací tak může experimentovat
  a ověřovat si své pochopení na konkrétních příkladech.
]
+ #[
  Krokové zobrazení redukce umožňuje sledovat,
  jakým způsobem je instance transformována.
  Každý krok je doplněn o textové vysvětlení. // využívající matematické zápisy.
]
+ #[
  Možnost dekódování řešení demonstruje,
  jakým způsobem lze z řešení výstupní instance odvodit řešení instance vstupní.
  Toto propojení je klíčové pro pochopení korektnosti redukcí.
]


== Omezení

Navržené řešení má několik omezení, která je třeba vzít v úvahu.

=== Rozsah podporovaných problémů
Podporované problémy a redukce jsou omezeny na množinu definovanou v rámci práce.
Přidání nových problémů nebo redukcí vyžaduje implementaci nových tříd
a může vyžadovat úpravu stávající architektury.

=== Výkon řešících algoritmů
Řešící algoritmy jsou implementovány na klientské straně v JavaScriptu.
Pro velmi rozsáhlé instance může být výpočet časově náročný
a může vést ke snížení odezvy aplikace.

=== Vizualizace grafů a srozumitelnost výstupu
Vizuální reprezentace grafů je založena na automatickém rozložení,
které nemusí být vždy optimální.
I když byly manuálně napsány algoritmy pro umísťování vrcholů
pro některé převody za účelem zlepšení čitelnosti výsledných grafů,
u složitějších instancí může být výsledný graf stále obtížně čitelný.
Stejně tak platí i u vizualizací v TeX -- ne vždy je text rozložen nejčitelněji.

=== Uživatelské rozhraní
UI je navrženo primárně pro desktopové prostředí.
Při vývoji nebyl brán zřetel na responzivní chování pro přenosná zařízení s menším displejem.

== Možnosti rozšíření

Navržené řešení lze rozšířit v několika směrech.

=== Rozšíření o další problémy
Podpora dalších NP-úplných problémů a redukcí, 
například redukce 3-SAT na problém maximálního řezu (Max-Cut) 
nebo redukce na problém nezávislé množiny (Independent Set), 
by umožnila demonstraci širší škály převodů.

=== Export a ukládání dat
Uživateli by mohla být nabídnuta možnost exportovat grafové instance jako obrázky
či exportovat výsledky do TeX formátu pro snadné vložení do dokumentace.
Dále by bylo užitečné umožnit ukládání vlastních instancí přímo na stránce,
například s využitím `localStorage`.

