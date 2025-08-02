STEPS = step0_repl 

all: $(STEPS)

%.o: %.S
	riscv64-elf-as -o $@ $<

%: %.o
	riscv64-elf-gcc -o $@ $<
.PHONY: clean
clean:
	rm -f $(STEPS) $(STEPS:%=%.o)
