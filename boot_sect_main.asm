[org 0x7c00]
    
    ;mov dl, 0x00 ; qemu didn't set dl to 0 without -fda option so set manually here
    ;mov [BOOT_DRIVE], dl ;BIOS stores boot drive in dl
    ;mov dx, 0x0000
    ;call print_hex
    


    mov bp, 0x8000 ;set stack address
    mov sp, bp
    
    mov bx, 0x9000 ; BIOS requires es:bx, so es default is 0, bx set to 0x9000, this is where we store the data we read
    mov dh, 5 ;read 5 sectors from disk store to es:bx
    ;mov dl, [BOOT_DRIVE]
    call disk_load

    mov dx, [0x9000] ;print the loaded first byte in first sector
    call print_hex

    mov dx, [0x9000 + 512] ;print the first byte in second sector
    call print_hex

    jmp $

%include "boot_sect_read_disk.asm"
%include "boot_sect_print_string.asm"
%include "boot_sect_print_hex.asm"


BOOT_DRIVE:
    db 0

times 510-($-$$) db 0
dw 0xaa55

times 256 dw 0xdada
times 256 dw 0xface
