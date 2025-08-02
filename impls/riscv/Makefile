STEPS = step0_repl 

CC_FLAGS=-nolibc -ffreestanding -nostartfiles

all: $(STEPS)

%.o: %.S
	riscv64-elf-as -o $@ $<

%: %.o
	riscv64-elf-gcc -o $@ $< $(CC_FLAGS)
.PHONY: clean
clean:
	rm -f $(STEPS) $(STEPS:%=%.o)
