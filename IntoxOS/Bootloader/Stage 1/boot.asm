;
; -------------------------------------------------------------------------
;  File name:   boot.asm
;  Version:     v1.00
;  Created:     29/3/2014 by Kevin.
;  Description: Stage 1 Bootloader - loads Kernel to memory
;  Todo:
;       + 01.06.14 - Kevin - currently kernel load only 20 sector -> 10 KB
; -------------------------------------------------------------------------


BITS 16
org 0x7C00 ; first address will be first segment (0000), adress: 7C00h

[SECTION .text]

main:
	
	.setupStack: ; 
		mov ax, 0x9000 ; address of segment -> 36864 - 31744 = 5120 Byte stack
		mov ss, ax   ; set stack segment to ax (0x9000)
		xor sp, sp   ; set stack pointer to 0 - mov sp, 0x00 
		; test
		;mov ax, 07C0h
		;mov ds, ax
		; test end


	.printFoundBootloader:
		mov si, initBootloader
		call print_String

	mov [bootdrive], dl ; set bootdrive by dl
	call load_Kernel_From_Floppy; 

	;jmp 0x1000:0x0000 ; jmp to kernel - should be segmet:offset
	; test data segment problem
	;jmp $;
	;test end
	
	jmp kernelSpace ; jmp to kernel

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

endless_Loop:
	jmp short $


load_Kernel_From_Floppy:
	mov dl, [bootdrive] ; load drive into dl
	xor ax, ax ; clear ax -> ah would be enaugh!
	int 0x13 ; reset -> set cf to 1 if error
	jc .resetFailed ; if error (cf = 1) then print error and try again
	jmp short .done
	.resetFailed:
		mov si, resetDriveFailed
		call print_String
		jmp short load_Kernel_From_Floppy
	.done:

	load_Kernel:
		;mov ax, 0x1000 ; will load the kernel to 0x10000																	
		;mov es, ax ; mov es, 0x1000
		;xor bx, bx ; mov bx, 0
		mov bx, [kernelSpace] ; copy kernel to 0x8000

		mov ah, 2  ; function "read"
		mov al, 20 ; read 20 sectors
		mov ch, 0  ; cylinder = 0
		mov cl, 2  ; sector = 2
		mov dh, 0  ; head = 0
		mov dl, [bootdrive] ; load drive again into dl
		int 0x13 
		jc .readSectorsFailed ; if cf then print error and try again 
		jmp short .done
		.readSectorsFailed:
			mov si, readSectorsFromDriveFailed
			call print_String
			jmp short load_Kernel

		.done:
			.printLoadKernel:
				mov si, loadKernel
				call print_String
			ret ; return


initBootloader db "Found Bootloader .." , 13, 10, 0 ; linefeed db 13, 10
loadKernel db "Loading Kernel ..", 13, 10, 0
resetDriveFailed db "Reset Disk Drive - Try again", 13, 10, 0
readSectorsFromDriveFailed db "Read Sectors from Drive failed - Try again", 13, 10, 0
bootdrive db 0
kernelSpace dw 0x8000

times 510-($-$$) db 0	; Pad remainder of boot sector with 0s
db 0x55
db 0xAA


;dw 0xAA55		; The standard PC boot signature