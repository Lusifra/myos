[org 0x7c00]

    mov bp, 0x9000      ;set the stack
    mov sp, bp

    mov bx, MSG_REAL_MODE
    call print_string   ; uses BIOS int 0x10

    call switch_to_pm   ; switch to 32-bit mode

    jmp $               ; this will never run if everything works

%include "boot_sect_print_string.asm"
%include "boot_sect_print_without_BIOS.asm"
%include "boot_sect_switch_32bit_mode.asm"
%include "boot_sect_define_GDT.asm"


[bits 32]

BEGIN_PM:

    mov ebx, MSG_PROT_MODE
    call print_string_pm    ; use 32-bit print

    jmp $   ; Hang

; Global Variables
MSG_REAL_MODE:
    db "Started in 16-bit Real Mode", 0
MSG_PROT_MODE:
    db "Successfully landed in 32-bit Protected Mode", 0

; Bootsector padding
times 510-($-$$) db 0
dw 0xaa55
