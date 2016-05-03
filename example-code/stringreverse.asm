.data
  name: .asciiz "josh harshman"
  newline: .asciiz "\n"

.text
  .globl main

  main:
    la $a1, name                  # load name into register a1

    #######################
    # print original name #
    #######################
    la $a0, 0($a1)                # load register a0 with register a1
    addi $v0, $0, 4               # 4 => PRINT_STRING
    syscall                       # execute

    #################
    # print newline #
    #################
    la $a0, newline               # load register a0 with newline
    syscall                       # execute

    ##############
    # prep stack #
    ##############
    addi $sp, $sp, -4             # move stack pointer before writing anything
    sw $a1, 0($sp)                # store address to where stack pointer is pointing

    ###############################
    # jump to PRINT_NAME function #
    ###############################
    jal PRINT_NAME                # jump to PRINT_NAME

    ################
    # repair stack #
    ################
    addi $sp, $sp 4               # fix position of stack pointer

    ########
    # exit #
    ########
    jal EXIT                      # jump to EXIT

  #######################
  # PRINT_NAME Function #
  #######################
  PRINT_NAME:
    lw $t0, 0($sp)                # load contents of stack pointer into register t0
    lb $t1, 0($t0)                # load byte from t0 into register t1
    beq $t1, $0, DONE             # branch if contents of t1 is the terminating character (asciiz adds terminating zero)

    addi $t2, $t0, 1              # move pointer to next location in character array
    addi $sp, $sp, -12            # make room on the stack

    sw $t0, 8($sp)                # store current value on stack
    sw $ra, 4($sp)                # store return address on stack
    sw $t2, 0($sp)                # store parameter value on stack

    jal PRINT_NAME                # jump and link to PRINT_NAME

    lw $t0, 8($sp)                # restore value from stack
    lw $ra, 4($sp)                # restore return address from stack
    addi $sp, $sp, 12             # repair stack

  #################
  # DONE Function #
  #################
  DONE:
    lb $a0, 0($t0)                # load byte
    addi $v0, $0, 11              # move 11 to v0
    syscall                       # execute
    jr $ra                        # jump to return address

  #################
  # EXIT Function #
  #################
  EXIT:
    addi $v0, $0, 10              # 10 => EXIT
    syscall                       # execute
