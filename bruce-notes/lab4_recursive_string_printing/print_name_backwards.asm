
# Bruce Emehiser
# 2016 04 26
#
# Prints name backwards

.data

name: .asciiz "Bruce Emehiser"

.text
.globl main

main:

	la $a1, name				# load word to print
	addi $sp, $sp -4			# move stack pointer down
	sw $a1, 0($sp)				# store variable in stack
	jal print					# jump to print statement
	addi $sp, $sp, 4			# move stack pointer up
	
	jal exit					# exit the program
	
print:

	lw $t0, 0($sp)				# load parameters from the stack
	lb $t1, 0($t0)				# load byte from memory
	
	beq $t1, $0, done			# base case, when we reach the null terminating character
	
	# else:
	
		# next recursive call
		addi $t2, $t0, 1		# move pointer to next location in char array name
		
		addi $sp, $sp, -12		# move stack pointer down
		sw $t0, 8($sp)			# store current value in stack
		sw $ra, 4($sp)			# store return address in stack
		sw $t2, 0($sp)			# store parameter value into stack
		jal print				# recursive call
		lw $t0, 8($sp)			# restore memory address value from stack
		lw $ra, 4($sp)			# restore return address from stack
		# lw $t0, 0($sp)			# load parameter from stack (not needed because it's the parameter we are passing)
		addi $sp, $sp, 12		# restore stack
		
	done:
		
		lb $a0, 0($t0)			# print character
		addi $v0, $0, 11
		syscall
	
		jr $ra					#return
		
exit:

	addi $v0, $0, 10
	syscall