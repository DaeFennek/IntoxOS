; tutorial bootloader based off of: http://osdever.net/tutorials/brunmar/tutorial_03.php
; -- lazyear, 03/23/08

[BITS 16]       ; 16 bit instructions

[ORG 0x7C00]

jmp word load

                db "ONYXDISK"           ; OEM Label String
                dw 512                  ; Bytes per sector
                db 1                    ; Sectors per FAT cluster
                dw 36                   ; Resered sector count
                db 2                    ; number of FATs
                dw 224                  ; Root dir entries
                dw 2880                 ; Total Sectors
                db 240                  ; Double sided, 18 sectors per track
                dw 9                    ; Sectors per FAT
                dw 18                   ; Sectors per track
                dw 2                    ; Head count (double sided)
                dd 0                    ; Hidden sector count 
        
load:
        mov ah, 0               ; floppy drive reset command
        int 13h                 ; bios floppy interrupt
        or ah, ah               ; check for error code
        jnz load                ; repeat if error

        mov ax, 0
        mov es, ax
        mov bx, 0x1000          ; destination address of kernel = 0000:1000

        mov ah, 02h             ; floppy read sector command
        mov al, 02h             ; number of sectors to read
        mov ch, 0               ; cylinder
        mov cl, 02h             ; sector
        mov dh, 0               ; head
        int 13h                 ; bios floppy interrupt
        or ah, ah               ; check for error code
        jnz load                ; repeat if error

        cli                     ; Disable interrupts

        xor ax, ax
        mov ds, ax              ; Set DS-register to 0 - used by lgdt

        lgdt [gdt_desc]         ; Load the GDT descriptor

        mov eax, cr0            ; Copy the contents of CR0 into EAX
        or eax, 1               ; Set bit 0
        mov cr0, eax            ; Copy the contents of EAX into CR0

        jmp 08h:kernel_seg      ; Jump to code segment, offset clear_pipe


[BITS 32]
kernel_seg:
        mov ax, 10h             ; save data segment
        mov ds, ax              ; setup data segment
        mov ss, ax              ; setup stack segment
        mov esp, 090000h        ; move the stack pointer to 090000h

        jmp 08h:01000h          ; jump to our kernel


gdt:                    ; address for the GDT

gdt_null:               ; null Segment
        dd 0
        dd 0

gdt_code:               ; code segment, read/execute, nonconforming
        dw 0FFFFh
        dw 0
        db 0
        db 10011010b
        db 11001111b
        db 0

gdt_data:               ; data segment, read/write, expand down
        dw 0FFFFh
        dw 0
        db 0
        db 10010010b
        db 11001111b
        db 0

gdt_end: 

gdt_desc: 
        dw gdt_end - gdt - 1    ; limit (size)
        dd gdt                  ; address of the GDT

times 510-($-$$) db 0           ; fill up the file with zeros

        dw 0AA55h               ; boot sector identifier