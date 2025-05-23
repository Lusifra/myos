disk_load:
    pusha
    push dx ;dx stores how many sectors we want to read

    mov ah, 0x02 ;tell BIOS we want to read sector
    mov al, dh ;sector number stored in dh, set to al
    mov ch, 0x00 ;select cylinder 0
    mov dh, 0x00 ;select head 0
    mov cl, 0x02 ;reading from second sector.(sector starts with 1, not 0)

    int 0x13 ;BIOS read disk interrupt

    jc disk_error ;jump if CF(carry flag) set to 1

    pop dx ;restore dx from stack
    cmp dh, al ;successfully readed sectors number will stored in al
               ;compare with how many we want to read at the begining
    jne sector_error ;jump if BIOS didn't read how we expected
    popa
    ret

disk_error:
    mov bx, DISK_ERROR_MSG
    call print_string
    jmp $

sector_error:
    mov bx, SECTOR_ERROR_MSG
    call print_string
    jmp $

DISK_ERROR_MSG:
    db "DISK READ ERROR!", 0

SECTOR_ERROR_MSG:
    db "READ WRONG SECTOR!", 0
