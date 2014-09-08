global loader
extern kmain ;dmain
; GRUB Shit start
MODULEALIGN equ 1<<0
MEMINFO equ 1<<1
FLAGS equ MODULEALIGN | MEMINFO
MAGIC equ 0x1BADB002
CHECKSUM equ -(MAGIC + FLAGS)

section .text
;align 4
MultiBootHeader:
dd MAGIC
dd FLAGS
dd CHECKSUM

; GRUB Shit end

;STACKSIZE equ 4096;0x4000

loader:
mov esp, stack_end;stack+STACKSIZE
;push eax
;push ebx

call kmain
cli

jmp $

section .bss
stack_begin:
	resb 4096
stack_end:
