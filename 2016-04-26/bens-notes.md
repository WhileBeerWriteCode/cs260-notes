# 2016-04-26

### Assignment

Recursion program that prints your name backwards recursively.
Print one character per function call. Basically, duplicate the python program
in MIPS assembly.

MIPS starter code
[Handy SPIM reference](https://www.cs.tcd.ie/John.Waldron/itral/spim_ref.html#data)

```
.data
name: .asciiz "Seymour Butts"

.text
.globl main

main:

  la $a1 , name # load address of name into register
  addi $sp, $sp, -4
  sw $a1, 0($sp) # store address of name onto stack
  jal print_name

  addi $sp, $sp, 4 # restore stack pointer

  move $v0, 0 # exit
  syscall


print_name:
  lw $t0, 0($sp) # load address of character into $t0
  lw $t1, 0($t0) # not sure why there are two load word instructions for this

  ###
  # The commented code below is probably wrong. Don't trust it.
  # I just copied it off the board.
  ###

  beq $t1, $0, done
  # move a0 to stack
  # move contents of t0 into a0
  # move 11 (code to print char) into v0
  # syscall
  # restore a0 from stack

  # t0 = t0 +1
  # t0 to stack
  # ra <- stack
  # jal print_name
  # restore stack
done:
  jr $ra

```
