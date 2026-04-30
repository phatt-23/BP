= Zhodnocení

V této kapitole jsou shrnuty dosažené výsledky,
diskutována omezení navrženého řešení
a nastíněny možnosti budoucího rozšíření.

== Shrnutí výsledků

Cílem této práce bylo navrhnout a implementovat interaktivní výukovou aplikaci
pro vizualizaci polynomiálních redukcí mezi NP-úplnými problémy.
V rámci práce byla tato aplikace realizována.

Konkrétně byla implementována webová aplikace umožňující:

#list(//indent: 1.2em,
  [zadávání vlastních instancí vstupních problémů a automatické provádění redukcí,],
  [krokové zobrazení procesu redukce s vysvětlením jednotlivých operací,],
  [vizualizaci vstupních a výstupních instancí v podobě grafů, logických výrazů a tabulek,],
  [nalezení řešení pomocí implementovaných algoritmů,],
  [dekódování řešení zpět na řešení vstupní instance a],
  [zobrazení nalezených certifikátů řešení.],
)

== Výuková hodnota

Navržená aplikace přináší několik výhod oproti tradičním statickým výukovým materiálům:

+ #[
  Uživatel může pracovat s libovolnou vlastní instancí.
  Na rozdíl od předpřipravených animací tak může experimentovat
  a ověřovat si své pochopení na konkrétních příkladech.
]
+ #[
  Krokové zobrazení umožňuje sledovat transformaci instance.
  Každý krok je doplněn o textové vysvětlení.
]
+ #[
  Možnost dekódování řešení demonstruje,
  jak lze z řešení výstupní instance odvodit řešení instance vstupní.
  Toto propojení je klíčové pro pochopení korektnosti redukcí.
]

#pagebreak()

#let h3 = heading.with(level: 3, numbering: none, outlined: false)

== Omezení

Navržené řešení má několik omezení, která je třeba vzít v úvahu.


#h3[Rozsah podporovaných problémů]

Aplikace podporuje pouze problémy a redukce definované v rámci této práce.
Přidání nových problémů vyžaduje implementaci odpovídajících tříd
a může si vyžádat úpravu stávající architektury.

#h3[Výkon řešících algoritmů]

Řešící algoritmy běží na klientské straně v prostředí webového prohlížeče.
Pro rozsáhlé instance může být výpočet časově náročný,
což vede ke zpomalení odezvy aplikace.

#h3[Vizualizace grafů a srozumitelnost výstupu]

Grafy jsou rozloženy automaticky, což nemusí vždy vést k optimálnímu výsledku.
Ačkoliv byly pro některé redukce implementovány vlastní algoritmy pro umísťování vrcholů,
u složitějších instancí může být výsledný graf stále obtížně čitelný.
Totéž platí pro vizualizace v TeX -- text není vždy rozložen nejpřehledněji.

#h3[Uživatelské rozhraní]

Rozhraní je navrženo primárně pro desktopové prostředí.
Při vývoji nebylo řešeno responzivní chování pro zařízení s menším displejem.

== Možnosti rozšíření

Navržené řešení lze rozšířit v několika směrech.

#h3[Rozšíření o další problémy]

Přidání podpory pro další NP-úplné problémy a redukce,
například 3-SAT na problém maximálního řezu (Max-Cut)
nebo na problém nezávislé množiny (Independent Set),
by umožnilo demonstraci širší škály převodů.

#h3[Export a ukládání dat]

Aplikaci by bylo možné rozšířit o možnost exportu grafů jako obrázků
či exportu výsledků do formátu TeX pro vložení do dokumentace.
Dále by bylo užitečné umožnit ukládání vlastních instancí v prohlížeči,
například s využitím `localStorage`.

