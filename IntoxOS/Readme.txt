IntoxOS

Todo:

25.03.2014 - Kevin

1. Wie .bin <-> .elf  assemblys unterscheiden? --> �ber seperate makefiles (l�uft)
|
--> 2. Make all und Make clean sauber implementieren - l�uft
	|
	--> 3. Source Code von Builder in Projekt einf�gen - ? -> l�uft


05.04.2014 - Kevin 

- 1. Stage Bootloader implementiert - l�dt 2. Stage Bootloader
- Create GDT

Todo:
	1. Load GDT - l�uft
	2. Enable A20 Gate - l�uft
	3. Run in 32 Bit Protected Mode - l�uft
	4. Buildscript aktualisieren - l�uft �ber makefile
--------------------------------------------------------------------------------------------------

12.04.14 - Kevin - 1. Meileinstein

- build / makefile �berarbeitet
- Projektstrukur aufger�umt

Todo
	- Console sauber implementieren (print methode, cls, cursor, keyboard driver, ..)
		- print -> l�uft
		- cls -> l�uft
		- cursor -> l�ft
		- int to string parser -> l�uft (noch �berarbeiten?)
		- malloc, strlen, memset, strcpy, memcopy etc. implementieren
		- tastatur treiber


Potenzelle Fehler:
	- falsche .o reihenfolge an linker �bergeben
	- .c nicht dem linker bekannt
	








