target ?= x86_64
linker_script := targets/$(target)/linker.ld
grub_cfg := targets/$(target)/grub.cfg
asm_source_files := $(wildcard src/boot/*.asm)
asm_object_files := $(patsubst src/boot/%.asm, build/$(target)/boot/%.o, $(asm_source_files))
c_source_files := $(wildcard src/kernel/*.c)
c_object_files := $(patsubst src/kernel/%.c, build/$(target)/kernel/%.o, $(c_source_files))

.PHONY: all iso run clean

all: build/$(target)/kernel.bin

iso: build/$(target)/kernel.iso

build/$(target)/kernel.bin: $(asm_object_files) $(c_object_files) $(linker_script)
	x86_64-elf-ld -n -T $(linker_script) -o build/$(target)/kernel.bin $(asm_object_files) $(c_object_files)

build/$(target)/kernel.iso: build/$(target)/kernel.bin $(grub_cfg)
	mkdir -p build/$(target)/isofiles/boot/grub
	cp build/$(target)/kernel.bin build/$(target)/isofiles/boot/kernel.bin
	cp $(grub_cfg) build/$(target)/isofiles/boot/grub/grub.cfg
	grub-mkrescue -o build/$(target)/kernel.iso build/$(target)/isofiles

build/$(target)/boot/%.o: src/boot/%.asm
	mkdir -p build/$(target)/boot
	nasm -felf64 $< -o $@

build/$(target)/kernel/%.o: src/kernel/%.c
	mkdir -p build/$(target)/kernel
	x86_64-elf-gcc -ffreestanding -fno-stack-protector -mno-red-zone -c $< -o $@

clean:
	rm -rf build
