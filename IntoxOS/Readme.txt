IntoxOS

Todo:

25.03.2014 - Kevin

1. Wie .bin <-> .elf  assemblys unterscheiden? --> über seperate makefiles (läuft)
|
--> 2. Make all und Make clean sauber implementieren - läuft
	|
	--> 3. Source Code von Builder in Projekt einfügen - ? -> läuft


05.04.2014 - Kevin 

- 1. Stage Bootloader implementiert - lädt 2. Stage Bootloader
- Create GDT

Todo:
	1. Load GDT - läuft
	2. Enable A20 Gate - läuft
	3. Run in 32 Bit Protected Mode - läuft
	4. Buildscript aktualisieren - läuft über makefile
--------------------------------------------------------------------------------------------------

12.04.14 - Kevin - 1. Meileinstein

- build / makefile überarbeitet
- Projektstrukur aufgeräumt

Todo
	- Console sauber implementieren (print methode, cls, cursor, keyboard driver, ..)
		- print -> läuft
		- cls -> läuft
		- cursor -> läft
		- int to string parser -> läuft (noch überarbeiten?)
		- malloc, strlen, memset, strcpy, memcopy etc. implementieren
		- tastatur treiber


Potenzelle Fehler:
	- falsche .o reihenfolge an linker übergeben
	- .c nicht dem linker bekannt
	








