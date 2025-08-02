	.section .text

	.equiv SIZE_INPUT, 1024
	.equiv SIZE_PROMPT, 6
	.equiv SYSCALL_READ, 63
	.equiv SYSCALL_WRITE, 64
	.equiv SYSCALL_EXIT, 93
	.equiv STDIN, 0
	.equiv STDOUT, 1

	.gloabal _start
_start:
	call write_prompt
	li a0, 0
	call exit

write_prompt:
	li a7, SYSCALL_WRITE
	li a0, STDOUT
	la a1, prompt
	li a2, SIZE_PROMPT
	ecall
	ret

exit:
	li a7, SYSCALL_EXIT
	ecall
	
rep:
	call READ
	call PRINT
	call EVAL
READ:
EVAL:
PRINT:

	.section .rodata

prompt:	
	.ascii "user> "
