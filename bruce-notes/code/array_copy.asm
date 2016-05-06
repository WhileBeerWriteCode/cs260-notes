
# Author: Bruce Emehiser
# Date: 2016 04 13
#
# Copy array0 to array1

.data

count: .word 11										# number of elements

array0: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10		# create array

array1: .space 44									# allocate space to copy array into

crlf: .asciiz "\n"									# newline character
	
.text
.globl main

main:
	#	Copy array0 into array1
	
	la $t0, array0					# get the starting address of arrays
	la $t1, array1
	
	lw $t2, count					# get the size of the array
	li $t3, 0						# loop indexer
	
	copyLoop:						# copy loop
		beq $t2, $t3, endCopyLoop	
	
		lw $t5, 0($t0)				# copy from array to temp, then from temp to second array
		sw $t5, 0($t1)
		
		lw $a0, 0($t1)				# print out number to verify copy
		addi $v0, $0, 1
		syscall
		
		addi $t0, $t0, 4			# move to next position in array
		addi $t1, $t1, 4
		addi $t3, $t3, 1
		
		# j copyLoop				# jump back to top of loop
		b copyLoop
	endCopyLoop: 					# end while loop
	
	# Print out array1 as proof of copy
	
	la $t6, array1					# load second array to a different register for redundant check
	
	la $t7, crlf					# load newline character
	
	li $t3, 0						# indexer
	
	printLoop:						# print loop
		beq $t2, $t3, endPrintLoop
	
		lw $a0, 0($t6)				# load from second array and print
		addi $v0, $0, 1
		syscall
		
		add $a0, $0, $t7			# print newline
		addi $v0, $0, 4
		syscall
		
		addi $t6, $t6, 4			# increment position
		addi $t3, $t3, 1
		
		b printLoop
	endPrintLoop:
	
	addi $v0, $0, 10				# exit
	syscall
	