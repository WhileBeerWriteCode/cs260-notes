.data

  source: .asciiz "Hello World!"
  destination: .space 20
  newline: .asciiz "\n"
  tocopy: .byte 4

.text
  .globl main

  main:

    la $a1, destination                   # load source string
    la $a2, source                        # load destination space
    lb $a3, tocopy                        # load number to copy

    jal strncpy

    li $v0, 4
    la $a0, destination
    syscall

    la $a0, newline
    syscall

    # exit
    addi $v0, $0, 10
    syscall


  strncpy:

    # a1 - address of destination
    # a2 - address of source
    # a3 - bytes to copy

    move $t1, $a1                         # destination
    move $t2, $a2                         # source
    move $t3, $a3                         # n to copy

    li $t0, 0                             # counter init to zero

    loop:
      beq $t0, $t3 end_strncpy            # if t0 >= t3 branch to end_strncpy

      lb $a0, 0($t2)                      # load element from source array
      sb $a0, 0($t1)                      # store element in destination array

      addi $t2, $t2, 1                    # offset $a2 by 4 to get next element
      addi $t1, $t1, 1                    # offset $a1 by 4 to get next element
      add $t0, $t0, 1                     # increment counter by 1
      j loop                              # loop again

    end_strncpy:
      sb $0, 0($t1)                       # end with terminator
      jr $ra                              # return to main
