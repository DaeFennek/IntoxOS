###########################################################################
#
# -------------------------------------------------------------------------
#  File name:   makefile
#  Version:     v1.00
#  Created:     29/3/2014 by Kevin.
#  Description: This makefile will compile the kernel
# -------------------------------------------------------------------------
#  History:
#
###########################################################################


CC=i586-elf-gcc
CFLAGS=-Wall -O -fstrength-reduce -fomit-frame-pointer -nostdinc -fno-builtin -fno-strict-aliasing -fno-common -fno-stack-protector -I$(SRC)
SRC=./Source
ASM=nasm
ASMELF=elf
ASMFLAGS=-O32 -f

all:
	$(CC) $(CFLAGS) -c $(SRC)/*.c
	$(ASM) $(ASMFLAGS) $(ASMELF) $(SRC)/gdt_setup.asm
	$(ASM) $(ASMFLAGS) $(ASMELF) $(SRC)/interrupts.asm
	mv $(SRC)/*.o $(shell pwd)

clean:
	rm -f *.o