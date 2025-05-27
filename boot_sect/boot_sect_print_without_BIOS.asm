[bits 32] ;tell nasm to produce 32bit protected mechine code

VIDEO_MEMORY equ 0xB8000 ;equ is for nasm use, to replace value
WHITE_ON_BLACK equ 0x0f

print_string_pm:
    pusha ; push eax, ecx, edx, ebx, esp, ebp, esi, edi
    mov edx, VIDEO_MEMORY 

print_string_pm_loop:
    mov al, [ebx] ;todo bit not equal? ans: store a address which point to a byte
    mov ah, WHITE_ON_BLACK
    

    cmp al, 0
    je print_string_pm_done


    mov [edx], ax ;store ax value to VIDEO_MEMORRY. al=charactor ah=attrebute

    add ebx, 1 ;point to next char
    add edx, 2 ;point to next video memory

    jmp print_string_pm_loop

print_string_pm_done:
    popa
    ret






