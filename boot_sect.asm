[org 0x7c00]
mov ah, 0x0e

mov al, the_secret
int 0x10

mov al, [the_secret]
int 0x10

mov bx, the_secret
;add bx, 0x7c00
mov al, [bx]
int 0x10

mov al, [0x7c19]
int 0x10


jmp $ ; jump to current address = infinite loop

the_secret:
    db "X"

; padding and magic number
times 510 - ($-$$) db 0
dw 0xaa55 
