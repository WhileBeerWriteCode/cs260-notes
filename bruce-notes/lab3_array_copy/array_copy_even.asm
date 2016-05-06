
# Author: Bruce Emehiser
# Date: 2016 04 13
#
# Copy the even elements of one
# array to another array

.data

# number of elements
count: .word 11

# create array
array0: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10

# allocate space to copy array into
array1: .space 44

# newline character
crlf: .asciiz "\n"
	
.text
.globl main

main:
	###
	#	Copy array0 into array1
	
	# get the starting address of arrays
	la $t0, array0
	la $t1, array1
	
	# get the size of the array
	lw $t2, count
	# loop indexer
	li $t3, 0
	
	# copy loop
	# while (t2 == t3) -> break;
	copyLoop: beq $t2, $t3, endCopyLoop
	
		# copy from array to temp, then from temp to second array
		lw $t5, 0($t0)
		sw $t5, 0($t1)
		
		# check for even number
		andi $t6, $t5, 1
		
		beq $t6, 0, evenNum
		b oddNum
		
		evenNum:
			lw $t5, 0($t0)
			sw $t5, 0($t1)
			
			addi $t1, $t1, 4
			
		oddNum:

		addi $t0, $t0, 4
		addi $t3, $t3, 1
			
		b copyLoop
	endCopyLoop:
	
	###
	# 	Print out array1 as proof of copy
	
	# load second array to a different register for redundant check
	la $t6, array1
	
	# load newline character
	la $t7, crlf
	
	# print loop
	li $t3, 0
	printLoop: beq $t2, $t3, endPrintLoop
	
		# load from second array and print
		lw $a0, 0($t6)
		addi $v0, $0, 1
		syscall
		
		# print newline
		add $a0, $0, $t7
		addi $v0, $0, 4
		syscall
		
		# increment position
		addi $t6, $t6, 4
		addi $t3, $t3, 1
		
		b printLoop
	endPrintLoop:
	
	# exit
	addi $v0, $0, 10
	syscall
	