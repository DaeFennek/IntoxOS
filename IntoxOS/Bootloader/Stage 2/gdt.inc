;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Global Description Table (GDT)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

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