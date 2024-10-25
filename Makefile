# Makefile for compiling and linking assembly files

# Compiler and linker
ASM = nasm -f elf
LD = ld -m elf_i386

# File extensions
ASM_SRC = $(wildcard **/*.asm)
OBJ = $(patsubst src/%.asm, obj/%.o, $(ASM_SRC))


# Create obj directory if it doesn't exist
.PHONY: all run clean

all: build

build: $(OBJ)
	@$(LD) -o main $^

obj/%.o: src/%.asm | obj
	@$(ASM) -o $@ $<

obj:
	@mkdir -p $@


run: build
	@./main

clean:
	rm -r obj main

