;
; -------------------------------------------------------------------------
;  File name:   loader2.asm
;  Version:     v1.00
;  Created:     29/3/2014 by Kevin.
;  Description: Handle video things
;  Todo:
;       + 05.04.2014 - Kevin - Implement check A20
;		+ 05.04.2014 - Kevin - Setup A20 the slow way
; -------------------------------------------------------------------------
 



BITS 16
;org 0x8000 ; org has to be absolute addresses | org only works in binary file but for the c Kernel we need a elf file so the linker will have to do it
[global RealMode] ; for linker

[SECTION .text]

; We are in the same segment then loader.asm --> 0x0000:0x0000
;mov ax, 0x1000 ; update segment (data and extra)
;mov ds, ax
;mov es, ax

RealMode:
	;xor ax, ax
	;mov ds, ax
	;mov es, ax
	;mov ax, 0x9000
	;mov ss, ax
	;mov sp, 0xFC00

	mov si, kernelLoaded 
	call print_String

	call clr_Screen
	call load_gdt
	jmp short enable_a20

	;jmp short holdt


print_Char:
	mov ah, 0eh
	int 10h
	ret

print_String:
	.do:
		lodsb ; move byte from si to al and increment si
		cmp al, 0 ; if char = 0
		jz .done; then jump to done
		call print_Char; print byte
		jmp short .do; 
	.done:
		ret


clr_Screen:
	mov ax, 0x06	
	xor cx, cx
	mov dx, 0x174F
    mov bh, 0x07
    int 0x10	
	Set_Cursor_To_Top:
		mov ax, 0x2
		xor dx, dx ; first row, first column
		xor bx, bx
		int 0x10
		ret
  

load_gdt:
	mov si, loadGDT
	call print_String
	cli
	lgdt [gdtr] ; load gdt
	ret



; TODO Implement Check a20
check_a20:
	

enable_a20:
	.check_if_fast:
		in al, 0x92 ; switch A20 gate via fast A20 port 92
		cmp al, 0xff 
		je .enable_a20_slow ; if al is 0xff we need to do it slow
		
		.enable_20_fast:
			or al, 2
			and al, 0xFE
			out 0x92, al
			jmp short .a20_enabled
			
		; TODO: 05.04.2014 - Kevin - Setup A20 the slow way 
		; begin
		;****************************************
		.enable_a20_slow:
			mov si, slowA20Exeption
			call print_String			
			jmp short holdt
		; end
		;****************************************

	.a20_enabled:
		mov si, setA20
		call print_String		
		
	
switch_to_protected_mode:
	mov si, setupProtectedMode
	call print_String
	mov eax, cr0
	or eax, 1
	mov cr0, eax	
	jmp 0x8:ProtectedMode
	

holdt:
	cli
	hlt

section .data
kernelLoaded db "Kernel sucessfully loaded ..", 13, 10, 0
loadGDT db "Load GDT ..", 13, 10, 0
setA20 db "Setup A20 sucessfull ..",13, 10, 0
slowA20Exeption db "Load A20 slow is not implemented ..", 13, 10, 0
setupProtectedMode db "Try to switch to protected mode ..", 13, 10, 0

;%include "gdt.inc"
; Implement gdt directly 

NULL_Desc: ; 8 Byte
	dd 0
	dd 0

CODE_Desc: ; 8 Byte
	dw 0xFFFF    ; segment limit
	dw 0         ; segment base
	db 0         ; segment base
	db 10011010b ; access byte
	db 11001111b ; bits 7 -4 flags, 0 - 3 limit
	db 0         ; segment base

DATA_Desc: ; 8 Byte
	dw 0xFFFF    ; segment limit
	dw 0         ; segment base
	db 0		 ; segment base
	db 10010010b ; access byte
	db 11001111b ; bits 7 -4 flags, 0 - 3 limit
	db 0		 ; segment base

gdtr:
	Limit dw 24 ; For limit storage
	Base dd NULL_Desc ; For base storage

;gdt end

section .text
[BITS 32]
[extern main] ; c main

ProtectedMode:
	
	.main:	
		mov ax, 0x10
		mov ds, ax
		mov ss, ax 
		mov es, ax
		xor eax, eax
		mov fs, ax
		mov gs, ax
		mov esp, 0x200000 ; set stack below 2 MB limit
				
		;call clrscr_32

		;mov esi, runningProtectedMode
		;call PutStr_32
		; jump to c main
		call main 


PutStr_32:      
    mov edi, [PutStr_Ptr]
.nextchar:
    lodsb
    test al, al          
    jz .end      
    stosw
    jmp .nextchar  
  .end:
    mov [PutStr_Ptr], edi
    ret 

clrscr_32:
    mov edi, 0xb8000
    mov [PutStr_Ptr], edi
    mov ecx, 40 * 25
    mov eax, 0x07200720 ; two times: 0x07 => white text & black background 0x20 => Space
    rep stosd
    ret
;;

section .data
PutStr_Ptr dd 0xb8000
runningProtectedMode db "Running in 32 Bit ..", 0