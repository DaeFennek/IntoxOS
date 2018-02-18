###########################################################################
#
# -------------------------------------------------------------------------
#  File name:   makefile
#  Version:     v1.00
#  Created:     29/3/2014 by Kevin.
#  Description: This makefile will compile and link the IntoxOS
# -------------------------------------------------------------------------
#  History:
#
###########################################################################

LD=i586-elf-ld
LINKERFILE=kernel.ld
OBJDIR="./object_files"
BOOTLOADER=./Bootloader
STAGE1="$(BOOTLOADER)/Stage 1"
STAGE2="$(BOOTLOADER)/Stage 2"
KERNEL="./Kernel"
BOCHS="./Bochs"

BOOT=$(OBJDIR)/SecondStageLoader.o


OBJ=$(OBJDIR)/gdt_setup.o \
	$(OBJDIR)/interrupts.o \
	$(OBJDIR)/kmain.o \
	$(OBJDIR)/video.o \
	$(OBJDIR)/io.o \
	$(OBJDIR)/string.o \
	$(OBJDIR)/gdt.o \
	$(OBJDIR)/idt.o \
	$(OBJDIR)/isr.o \
	$(OBJDIR)/irq.o \
	$(OBJDIR)/timer.o \
	$(OBJDIR)/keyboard.o



all: clean stage1 stage2 krnl copy link buildos 

stage1:
	make -C $(STAGE1) all

stage2:
	make -C $(STAGE2) all

krnl:
	make -C $(KERNEL) all		

cleanobj:
	rm -f  $(OBJDIR)/*.o
	rm -f  $(OBJDIR)/*.bin
	
cleantmp:
	make -C $(STAGE1) clean
	make -C $(STAGE2) clean
	make -C $(KERNEL) clean
	rm -f $(BOCHS)/*.bin

copy:
	mv $(STAGE1)/boot.bin ./$(OBJDIR)
	mv $(STAGE2)/*.o ./$(OBJDIR)
	mv $(KERNEL)/*.o ./$(OBJDIR)

link:
	$(LD) -Map stage2.map -T $(LINKERFILE) $(BOOT) $(OBJ)

buildos:
	mv a.out ./$(OBJDIR)/kernel.bin
	
clean: cleantmp cleanobj