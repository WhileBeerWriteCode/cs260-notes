
# Bruce Emehiser
# 2016 04 26
#
# Print name recursively by printing one character at a time.

.data

name: .asciiz "my name"

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
	lb $t1, 0($t0)
	
	beq $t1, 0, done			# base case, when we reach the null terminating character
	
	else:
		
		add $a0, $0, $t1		# print character
		addi $v0, $0, 11
		syscall
	
		# next recursive call
		addi $t0, $t0, 1		# move pointer to next location in char array name
		
		addi $sp, $sp, -8		# move stack pointer down
		sw $ra, 4($sp)			# store return address in stack
		sw $t0, 0($sp)			# store value into stack
		jal print				# recursive call
		lw $ra, 4($sp)			# restore return address from stack
		addi $sp, $sp, 8		# restore stack
		
	done:
		jr $ra					#return
		
exit:
	addi $v0, $0, 10
	syscall