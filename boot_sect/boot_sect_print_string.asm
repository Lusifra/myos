print_string:
    pusha
next_print:
    cmp byte [bx], 0
    je finish_print
    mov al, [bx]
    mov ah, 0x0e
    int 0x10
    add bx, 1
    jmp next_print
finish_print:
    mov al, 0x0A
    int 0x10
    mov al, 0x0D
    int 0x10
    popa
    ret
