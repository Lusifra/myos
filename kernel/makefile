CC = i386-elf-gcc
LD = i386-elf-ld

all: os-image kernel.dis

os-image: boot_sect.bin kernel.bin
	cat $^ > $@

boot_sect.bin: boot_sect.asm
	nasm -fbin $< -o $@

kernel.bin: kernel_entry.o kernel.o
	$(LD) -o $@ -Ttext 0x1000 --oformat binary $^

kernel.o: kernel.c
	$(CC) -ffreestanding -c $< -o $@

kernel_entry.o: kernel_entry.asm
	nasm $< -f elf -o $@

clean:
	rm *dis *.o *.bin os-image

kernel.dis: kernel.bin
	ndisasm -b 32 $< > $@

run: os-image
	qemu-system-x86_64 -fda $<
