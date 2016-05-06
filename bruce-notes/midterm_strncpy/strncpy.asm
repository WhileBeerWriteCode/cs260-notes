
# Bruce Emehiser
# 2016 05 03
#
# Architecture and Organization
# Test 1
#
# strncpy
#
# Copy the first n character of a string to an allocated
# space.
# If string is null terminated, and n is larger than the length
# of the string to copy from, it will pad the remaining space
# with null characters.

.data

name: .ascii "Bruce"			# string
long: .asciiz "Bruce Emehiser"	# null terminated string
new: .space 50					# space is purposfully larger than needed, for testing purposes
newline: .asciiz "\n"

.align 2

.globl main

.text

	# Entry Point.
	#
	# Tests functionality for copying the first
	# n characters of a non-null terminated string.
	#
	# Tests functionality for copying n > length
	# of null terminated string.
main:

	# copy all bytes
	
	la $t0, name			# load memory addresses
	la $t1, new
	li $t2, 5				# set number of characters (bytes) to copy

	addi $sp, $sp, -12		# set up stack
	sw $t1, 0($sp)
	sw $t0, 4($sp)
	sw $t2, 8($sp)
	jal strncpy				# make call to strncpy
	addi $sp, $sp, 12		# restore stack
	
	la $a0, new				# load memory address
	addi $v0, $0, 4			# print string
	syscall
	
	la $a0, newline			# print newline
	addi $v0, $0, 4
	syscall
		
	# copy first 3 bytes
	
	la $t0, name			# load memory addresses
	la $t1, new
	li $t2, 3				# set number of characters (bytes) to copy
	addi $sp, $sp, -12		# set up stack
	sw $t1, 0($sp)
	sw $t0, 4($sp)
	sw $t2, 8($sp)
	jal strncpy				# make call to strncpy
	addi $sp, $sp, 12		# restore stack
	
	la $a0, new				# load new address
	addi $v0, $0, 4			# print string
	syscall
	
	la $a0, newline			# print newline
	addi $v0, $0, 4
	syscall
	
	# copy first 50 bytes of null terminated string
	
	la $t0, long			# load memory addresses
	la $t1, new
	li $t2, 50				# set number of characters (bytes) to copy
	addi $sp, $sp, -12		# set up stack
	sw $t1, 0($sp)
	sw $t0, 4($sp)
	sw $t2, 8($sp)
	jal strncpy				# make call to strncpy
	addi $sp, $sp, 12		# restore stack
	
	la $a0, new				# load new address
	addi $v0, $0, 4			# print string
	syscall
	
	la $a0, newline			# print newline
	addi $v0, $0, 4
	syscall
	
	# exit
	
	jal exit				# exit the program

	# Copy the first n characters of a string
	# to space.
	# param: 0($sp) address of string to copy to
	# param: 4($sp) address of string to copy from
	# param: 8($sp) total number of bytes to copy
strncpy:

	lw $t0, 0($sp)			# load the parameters
	lw $t1, 4($sp)
	lw $t2, 8($sp)
	
	addi $t3, $0, 0			# counter
	
	while:
	beq $t2, $t3, return	# while t2 != t3
	
		lb $t5, 0($t1)		# load character from old string
		sb $t5, 0($t0)		# store character in new string
		
		addi $t0, $t0, 1	# go to next byte
		addi $t1, $t1, 1
		addi $t3, $t3, 1	# increment counter
		
		beq $t5, $0, pad	# check pad the remaining characters with null bytes
		
		b while
	
	pad:					# pad the remaining character with null characters
		beq $t2, $t3, return
		
		sb $0, 0($t0)		# add padding byte
		addi $t0, $t0, 1	# move to next index in output array
		addi $t3, $t3, 1	# increment counter
		
		b pad
		
	return:					# write last null terminating character and return
	
	sb $0, 0($t0)			# place null terminating character
	
	jr $ra					# return
	
	# Exit the program
exit:

	addi $v0, $0, 10
	syscall