mov bx, 40 

cmp bx, 4
jle label_a
cmp bx, 40
jl label_b
mov al, 'C'
jmp finish



label_b:
    mov al, 'B'
    jmp finish ;Must jmp when code flows
label_a:
    mov al, 'A'
    jmp finish

finish:

mov ah, 0x0e
int 0x10

jmp $

times 510-($-$$) db 0
dw 0xaa55
