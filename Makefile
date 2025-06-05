CC = i386-elf-gcc
LD = i386-elf-ld
C_SOURCES = $(wildcard kernel/*.c drivers/*.c)
HEADERS = $(wildcard kernel/*.h drivers/*.h)


OBJ = ${C_SOURCES:.c=.o}

all: os-image

run: os-image
	qemu-system-i386 -fda $<

os-image: boot_sect/boot_sect.bin kernel.bin
	cat $^ > os-image

kernel.bin: kernel/kernel_entry.o ${OBJ}
	$(LD) -o $@ -Ttext 0x1000 $^ --oformat binary

%.o: %.c ${HEADERS}
	$(CC) -ffreestanding -c $< -o $@

%.o: %.asm
	nasm $< -f elf -o $@

%.bin: %.asm
	nasm $< -f bin -I './boot_sect' -o $@

clean: 
	rm  *.bin *.dis *.o os-image kernel/*.o boot_sect/*.bin drivers/*.o

