print_hex:
    pusha
    mov cx, 0   ;loop 4 times

back:
    cmp cx, 4
    je end_loop
    
    mov ax, dx
    shr dx, 4 ;right shift 4 bits to dx
    and ax, 0x000F ;take last 4 bits
    cmp al, 9 ; if < 9, add 48, else add 55
    jle less_9
    add al, 55
    jmp storage
less_9:
    add al, 48
storage:   ;store to HEX_OUT
    mov bx, HEX_OUT 
    add bx, 5 ;bx point to the last "0" in HEX_OUT
    sub bx, cx ;define which byte should write this time
    mov byte [bx], al ;store al to where bx point to
    add cx, 1
    jmp back
    
end_loop:
    mov bx, HEX_OUT ;print HEX_OUT
    call print_string 
    popa
    ret

HEX_OUT: ;reserve a space for output
    db "0x0000", 0
