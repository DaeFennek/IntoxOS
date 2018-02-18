###########################################################################
#
# -------------------------------------------------------------------------
#  File name:   makefile
#  Version:     v1.00
#  Created:     11/4/2014 by Kevin.
#  Description: This makefile will compile 16 Bit Stage 1 Bootloader
# -------------------------------------------------------------------------
#  History:
#
###########################################################################

ASM=nasm
ASMBIN=bin
ASMFLAGS=-O32 -f

all:
	$(ASM) $(ASMFLAGS) $(ASMBIN) boot.asm -o boot.bin
	
clean:
	rm -f *.bin