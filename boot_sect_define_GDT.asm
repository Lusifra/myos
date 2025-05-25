gdt_start:

gdt_null: ;define null descriptor
    ;dd 0x00000000
    ;dd 0x00000000
    dq 0x0

gdt_code: ;code segment descriptor
    ; base=0x0, limit=0xfffff
    ; 1st flags: (preesent: real memory)1 
    ;            (DPL, descriptor privilege level: 0 is the highest)00 
    ;            (descriptor type: 1 for code or data segment, 0 for traps)1 -> 1001b
    ; type flags: (code: 1 for code, 0 for data)1 
    ;             (conforming: 0 means lower privilege may not call code in this segment)0 
    ;             (readable: allows us read constants defined in code)1 
    ;             (accessed: used for debugging or virtual memory)0 ->1010b
    ; 2nd flags: (granularity: sets segment expanded to 4G 0xfffff000)1 
    ;            (32-bit default: 1 for 32 bit mode, 0 for 16 bit mode)1
    ;            (64-bit seg: used for 64 bit processor)0 
    ;            (AVL: avaliable for use by system software)0 ->1100b

    dw 0xffff   ; Limit(bits 0-15) limit segment size
    dw 0x0      ; Base(bits 16-31) where segment starts
    db 0x0      ; Base(bits 0-7)
    db 10011010b; P DPL S Type(bits 8-15)
    db 11001111b; G D/B L AVL Limit(bits 16-23)
    db 0x0      ; Base(bits 24-31)
 
gdt_data: ;data segment descriptor     Type flag is different from code sd
    ; base=0x0, limit=0xfffff
    ; 1st flags: (preesent: real memory)1 
    ;            (DPL, descriptor privilege level: 0 is the highest)00 
    ;            (descriptor type: 1 for code or data segment, 0 for traps)1 -> 1001b
    ; type flags: (code: 1 for code, 0 for data)0 TODO 
    ;             (Expand down: allows segment to expand down)0 TODO
    ;             (writeable: allow us to write to data segment)1 TODO
    ;             (accessed: used for debugging or virtual memory)0 ->0010b
    ; 2nd flags: (granularity: sets segment expanded to 4G 0xfffff000)1 
    ;            (32-bit default: 1 for 32 bit mode, 0 for 16 bit mode)1
    ;            (64-bit seg: used for 64 bit processor)0 
    ;            (AVL: avaliable for use by system software)0 ->1100b

    dw 0xffff   ; Limit(bits 0-15) limit segment size
    dw 0x0      ; Base(bits 16-31) where segment starts
    db 0x0      ; Base(bits 0-7)
    db 10010010b; P DPL S Type(bits 8-15)
    db 11001111b; G D/B L AVL Limit(bits 16-23)
    db 0x0      ; Base(bits 24-31)


gdt_end:    ;this label is used to calculate the size of GDT

gdt_descriptor:
    dw gdt_end - gdt_start - 1  ;size of GDT
    dd gdt_start                ;start of GDT

CODE_SEG equ gdt_code - gdt_start
DATA_SEG equ gdt_data - gdt_start
