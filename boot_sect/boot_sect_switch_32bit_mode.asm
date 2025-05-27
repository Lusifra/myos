[bits 16]
; Switch to protected mode

switch_to_pm:
    cli                     ;turn off interrupt vector
    lgdt [gdt_descriptor]   ;load GDT

    mov eax, cr0    ; switch to protected mode
    or eax, 0x1     ; set first bit to 1(control register)
    mov cr0, eax    ; set cr0

    jmp CODE_SEG:init_pm    ; far jump
                            ; CPU load descriptor(in GDT, offset=CODE_SEG 0x08) to cs(code descriptor)
                            ; refresh eip. set init_pm to eip (base 0x00000000 + init_pm)
                            ; flush CPU pipeline to our 32-bit code
                            

[bits 32]
; Init registers, stack once in PM

init_pm:
    mov ax, DATA_SEG    ; load GDT to segment registers
    mov ds, ax
    mov ss, ax
    mov es, ax
    mov fs, ax
    mov gs, ax

    mov ebp, 0x9000     ; update stack poistion to the top of
    mov esp, ebp        ; the free space

    call BEGIN_PM
