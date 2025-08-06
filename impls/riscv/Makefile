STEPS=step0_repl step1_read_print

CC_FLAGS=-nolibc -ffreestanding -nostartfiles

ADDITIONALS_ASM_FILES=alloc.S reader.S printer.S
STEPS_ASM_FILES=$(STEPS:%=%.S)
ALL_ASM_FILES=$(STEPS_ASM_FILES) $(ADDITIONALS_ASM_FILES)

ADDITIONALS_OBJ_FILES=$(ADDITIONALS_ASM_FILES:%.S=%.o)
STEPS_OBJ_FILES=$(STEPS_ASM_FILES:%.S=%.o)
ALL_OBJ_FILES=$(ALL_ASM_FILES:%.S=%.o)


all: $(STEPS)

$(ALL_OBJ_FILES): $(ALL_ASM_FILES)
	riscv64-elf-as -o $@ $(@:%.o=%.S)

$(STEPS): $(ALL_OBJ_FILES)
	riscv64-elf-gcc $(CC_FLAGS) -o $@ $@.o $(ADDITIONALS_OBJ_FILES)

.PHONY: clean
clean:
	rm -f $(STEPS) $(ALL_OBJ_FILES)
