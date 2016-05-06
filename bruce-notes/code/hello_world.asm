
# Bruce Emehiser
# 2014 04 06
#
# Hello World, written in mips assembly

.data 							# set up global memory variables

str0: .asciiz "Hello World!"	# store the null terminated hello world into str0

.globl main						# global entry point

.text 							# all the executable program code comes after the .text tag
main:							# jump tag
	
	la $a0, str0				# write hello world str0 to a0
	addi $v0, $0, 4				# set up system print call, and execute
	syscall						# make call to system. System reads v0, and then reads a0 and writes to output
	
	addi $v0, $0, 10			# exit
	syscall
