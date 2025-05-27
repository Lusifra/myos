[org 0x7c00]

mov bx, HELLO_MSG
call print_string

mov bx, GOODBYE_MSG
call print_string

mov dx, 0xff1c
call print_hex

mov dx, 0x1cbf
call print_hex

jmp $

%include "boot_sect_print_hex.asm"
%include "boot_sect_print_string.asm"

HELLO_MSG:
    db 'Hello, world!', 0

GOODBYE_MSG:
    db 'Bye...', 0

times 510-($-$$) db 0
dw 0xaa55
