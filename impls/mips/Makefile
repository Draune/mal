STEPS = step0_repl 

COMPONENTS =


all: $(STEPS)

%: %.mips $(COMPONENTS)
	mips-linux-gnu-ld -o $@ $<

.PHONY: clean
clean:
	rm -f $(STEPS) $(STEPS:%=%.o)