###########################################################################
#
# -------------------------------------------------------------------------
#  File name:   makefile
#  Version:     v1.00
#  Created:     11/4/2014 by Kevin.
#  Description: This makefile will compile the Stage 2 Bootloader
# -------------------------------------------------------------------------
#  History:
#
###########################################################################

ASM=nasm
ASMELF=elf
ASMFLAGS=-O32 -f

all:
	$(ASM) $(ASMFLAGS) $(ASMELF) SecondStageLoader.asm -o SecondStageLoader.o

clean:
	rm -f *.o