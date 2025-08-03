	# Function list/tree (to keep track of things):
	# - rep
	# 	- READ
	#		- readline
	#		- read_str
	#	- EVAL
	#	- PRINT
	#		- printline
	#		- pr_str
	# 	- write_prompt
	# Utilities (at the end):
	# - exit
	# - strlen
	# - alloc_item
	# - free_item
	# - alloc_list
	# - free_list
	# - string_to_list
	# - list_to_string

	# List will be linked forward and backward
	# (simplier in the ways things can be done)
	# The memory management sheme will be the following:
	# | item 1 | item 2 | item 3 |
	# We add item 4:
	# | item 1 | item 2 | item 3 | item 4 |
	# We remove item 2:
	# | item 1 | item 4 | item 3 |
	# It is done by following the number of items and
	# by updating links between the items.
	# We allocate the buffer containing the lists with mmap
	# When there is not enough space, we allocate another one
	# We use munmap to free the space

	# We well use list to store everything like strings
	# (a string will be a list of chars)
	# It will be easier since like that we will not need another memory scheme
	
	.section .text

	.equiv SIZE_INPUT, 1024
	.equiv SIZE_PROMPT, 6
	.equiv SYSCALL_READ, 63
	.equiv SYSCALL_WRITE, 64
	.equiv SYSCALL_EXIT, 93
	.equiv STDIN, 0
	.equiv STDOUT, 1

	.global _start
_start:
	call rep
	
rep:
	call write_prompt
	call READ
	call PRINT
	call EVAL
	j rep
	
	# ret: input string converted into a "list" structure in a0
READ:
	addi sp, sp, -8*1
	sw ra, 0(sp)

	call readline
	call read_str

	lw ra, 0(sp)
	addi sp, sp, 8*1
	ret
	
	# ret: input string in a0
readline:	
	addi sp, sp, -8*4
	sw s0, 0(sp)
	sw s1, 8(sp)
	sw s2, 16(sp)
	sw s3, 24(sp)
	
	la s0, input
	mv s1, s0
	li s2, 0xa # '\n' char
	la s3, input_end
	addi s3, s3, -1

	li a7, SYSCALL_READ
	li a0, STDIN
	mv a1, s1
	li a2, SIZE_INPUT-1
	ecall
	ble a0, x0, READ_exit
	
	add s1, s1, a0
	sb x0, 0(s1)
	mv a0, s0
	lw s0, 0(sp)
	lw s1, 8(sp)
	lw s2, 16(sp)
	lw s3, 24(sp)
	addi sp, sp, 8*4
	ret
readline_exit:
	mv a0, x0
	call exit

	
	# param: input string in a0
	# ret: input string converted into a "list" structure in a0
read_str:
	
	
	# param: input string converted into a "list" structure in a0
	# ret: output "list" structure that will be converted to a string in a0
EVAL:
	ret

	# param: output "list" structure that will be converted to a string in a0
PRINT:
	addi sp, sp, -8*1
	sw ra, 0(sp)

	call pr_str
	call printline

	lw ra, 0(sp)
	addi sp, sp, 8*1
	ret

	# param: output string in a0
printline:	
	addi sp, sp, -8*2
	sw ra, 0(sp)
	sw s0, 8(sp)

	mv s0, a0
	call strlen

	li a7, SYSCALL_WRITE
	mv a2, a0
	li a0, STDOUT
	mv a1, s0
	ecall

	lw ra, 0(sp)
	lw s0, 8(sp)
	addi sp, sp, 8*2
	ret

	# param: output "list" structure that will be converted to a string in a0
	# ret: output string in a0
pr_str:
	ret

write_prompt:
	li a7, SYSCALL_WRITE
	li a0, STDOUT
	la a1, prompt
	li a2, SIZE_PROMPT
	ecall
	ret

	# param: error code in a0
exit:
	li a7, SYSCALL_EXIT
	ecall

	# param: string addr in a0
	# ret: size in a0
strlen:
	li t0, -1
	mv t1, x0
strlen_loop:
	addi t0, t0, 1
	add t2, a0, t0
	lb t1, 0(t2)
	bne t1, x0, strlen_loop
	mv a0, t0
	ret

alloc:

free:
	
	.section .rodata

prompt:	
	.ascii "user> "

	.section .data
input:
	.skip SIZE_INPUT
input_end:	
