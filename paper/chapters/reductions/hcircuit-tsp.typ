== Redukce HCIRCUIT na TSP

Vrcholy ze vstupního grafu $G = (V_G,E_G)$ problému HCIRCUIT
zkopírujeme do grafu $H = (V_H,E_H)$ a přidáme hranu mezi každým z nich.
Tím vytvoříme kompletní graf. 
Poté všechny hrany ohodnotíme. 
Pokud pro hranu $e = {x,y} in E_H$ existuje odpovídajicí hrana ${x,y} in E_G$,
bude hrana $e$ ohodnocena vahou 1, 
jinak bude mít váhu větší než 1 (v našem případě 2).

