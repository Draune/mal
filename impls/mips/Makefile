STEPS = step0_repl 

all: $(STEPS)

%.o: %.mips
	mips-linux-gnu-as -o $@ $<

%: %.o
	mips-linux-gnu-gcc -o $@ $< -static 
.PHONY: clean
clean:
	rm -f $(STEPS) $(STEPS:%=%.o)