CC = i386-elf-gcc
LD = i386-elf-ld

all: os-image

os-image: boot_sect.bin kernel.bin
	cat $^ > $@

boot_sect.bin: boot_sect.asm
	nasm -fbin $< -o $@

kernel.bin: kernel.o
	$(LD) -o $@ -Ttext 0x1000 --oformat binary $<

kernel.o: kernel.c
	$(CC) -ffreestanding -c $< -o $@

clean:
	rm *.o *.bin os-image *.dis
