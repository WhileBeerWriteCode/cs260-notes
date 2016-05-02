.data
str: .asciiz "hello world"
newline: .asciiz "\n"
.text
main:
addi $v0 , $0, 4 # PRINT_STRING
la $a0 , str
syscall
# print newline
la $a0, newline
syscall
addi $v0 , $0, 10
syscall
