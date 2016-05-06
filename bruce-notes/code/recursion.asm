
## Bruce Emehiser
## 2016 04 25

.data

crlf: .asciiz "\n"

.text

.globl main

main:

	li, $t0, 0				# load an arbitrary value 5 into register t0
	addi $sp, $sp, -4		# move the stack pointer to point at the next stack address
	sw $t0, 0($sp)			# store data value into stack pointer (parameter)
	jal subroutine			# jump to subroutine
	# addi $sp, $sp, 4		# move stack pointer up to point at previous stack address
	
	addi $v0, $0, 10		#exit
	syscall

subroutine:				# subroutine signature

	#load the parameter from the stack pointer
	lw $t0, 0($sp)
	
	# print out current position
	add $a0, $0, $t0
	addi $v0, $0, 1
	syscall
	la $a0, crlf
	addi $v0, $0, 4
	syscall
	
	# recursive call
	beq $t0, 10, continue	# recursion escape clause
	
	add $t0, $t0, 1		# add one to the parameter to pass
	addi $sp, $sp, -12	# move stack pointer down far enough to accomidate return address and parameter
	sw $t0, 8($sp)		# store the current stack frame state onto the stack
	sw $ra, 4($sp)		# the return address stored +4 bytes
	sw $t0, 0($sp)		# the parameter being passed
	jal subroutine		# jump to the subroutine
	lw $t0, 8($sp)		# load the stack frame state
	lw $ra, 4($sp)		# load the return address
	addi $sp, $sp, 12	# move stack pointer up
	
	continue:
	
	# print the current stack frame state
	add $a0, $0, $t0
	addi $v0, $0, 1
	syscall
	la $a0, crlf
	addi $v0, $0, 4
	syscall
	
	jr $ra 				# jump return to return address
	