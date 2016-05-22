.data

  source: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
  destination: .space 20
  orig_str: .asciiz "original array:"
  new_str: .asciiz "new array:"
  newline: .asciiz "\n"

.text
  .globl main

  main:
    li $t0, 0                 # counter init to zero
    li $s1, 10                # size of array
    la $t1, source            # source array
    la $t2, destination       # destination array

    addi $v0, $0, 4           # 4 => PRINT_STRING
    la $a0, orig_str          # load string "original array"
    syscall                   # execute

    #########################################
    # loop through original array and print #
    #########################################
    LOOP:
      bge $t0, $s1, END_LOOP  # branch to END_LOOP once t0 is equal to s1
      addi $v0, $0, 1         # 1 => PRINT_INT
      lw $a0, 0($t1)          # load value from source array
      syscall                 # execute

      addi $t1, $t1, 4        # offset $t1 by 4 to get next element
      add $t0, $t0, 1         # increment counter by 1
      j LOOP                  # jump back to LOOP

    END_LOOP:
      # print newline
      addi $v0, $0, 4         # 4 => PRINT_STRING
      la $a0, newline         # load string "\n"
      syscall                 # execute

      la $t1, source          # reset $t1 offset
      addi $t0, $0, 0         # reset counter

      # print new array
      addi $v0, $0, 4         # 4 => PRINT_STRING
      la $a0, new_str         # load string "new array"
      syscall                 # execute

    ########################################################
    # loop through list and copy even values to new array  #
    ########################################################
    LOOP_AGAIN:
      bge $t0, $s1, TERMINATE # branch to TERMINATE once t0 is equal to s1
      lw $a0, 0($t1)          # load element from source array
      andi $v0, $a0, 1        # AND current element with 1 and store result in v0
      beqz $v0, COPY          # jump if register v0 contains zero
    BACK:
      # increment counters
      addi $t1, $t1, 4        # offset $t1 by 4 to get next element
      add $t0, $t0, 1         # increment counter by 1
      j LOOP_AGAIN            # jump to LOOP_AGAIN
    COPY:
      sw $a0, ($t2)           # copy value in a0 to address at t2

      # print element
      addi $v0, $0, 1         # 1 => PRINT_INT
      lw $a0, 0($t2)          # load element from destination
      syscall                 # execute

      addi $t2, $t2, 4        # offset $t2 by 4 to get next element
      j BACK                  # jump to BACK

    ###############################
    # Terminate Program Execution #
    ###############################
    TERMINATE:
      addi $v0, $0, 4         # 4 => PRINT_STRING
      la $a0, newline         # load string "\n"
      syscall                 # execute
      addi $v0, $0, 10        # 10 => EXIT
      syscall                 # execute
