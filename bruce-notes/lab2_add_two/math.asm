
# Bruce Emehiser
# 2016 04 07
#
# User input, addition, and subtraction.
# The purpose of this assignment is to learn
# some of the syntax of the MIPS assembly language.

# set up the data variables
.data
str0: .asciiz "sum = "
str1: .asciiz "diff = "
cr: .asciiz "\n"
p: .asciiz "Enter integer "

# this is the global entry point
.globl main

# executable code follows .text tag
.text

# main method
main:

	# get the user input for the first int with subroutine call
	la $t8, p
	jal input
	# save the content from the subroutine return into regiseter
	add $t0, $0, $t9
	
	# get second input
	la $t8, p
	jal input
	add $t1, $0, $t9
	
	# perform operation a + b
	# perform operation a - b
	add $t2, $t0, $t1
	sub $t3, $t0, $t1
	
	# print the first line
	la $t8, str0
	add $t9, $0, $t2
	la $t7, cr
	jal print
	
	# print the second line
	la $t8, str1
	add $t9, $0, $t3
	la $t7, cr
	jal print
	
	# exit the program
	jal exit
	
# Get the user input
#
# parameter: p The string to prompt with
# return: $t9
input:

	# prompt the user
	add $a0, $0, $t8 		# copy prompt string from register p to register a0
	addi $v0, $0, 4 # set up system call to PRINT_STRING
	syscall			# execute system call

	# get input
	addi $v0, $0, 5 # set up system call to READ_INT
	syscall			# execute system call
	
	# read the value from $v0 into temporary regiseter $t9
	add $t9, $0, $v0
	
	# return from subroutine by loading next address to execute from register ra (return address)
	jr $ra

# Print formatted output
#
# parameter: $t8 The string to print
# parameter: $t9 The int to print
# parameter: $t7 The newline character
print:
	# print string
	add $a0, $0, $t8
	addi $v0, $0, 4
	syscall
	# print int
	add $a0, $0, $t9
	addi $v0, $0, 1
	syscall
	#print newline
	add $a0, $0, $t7
	addi $v0, $0, 4
	syscall
	
	# return from subroutine
	jr $ra

# Exit the system safely
exit:
	# exit
	addi $v0, $0, 10
	syscall
	