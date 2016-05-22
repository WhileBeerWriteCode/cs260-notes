.data

  tcb0: .word 32
  tcb1: .word 32
  tid: .word 1

  taskzero_say: .asciiz "Hi I'm Task Zero!\n"
  taskzero_bye: .asciiz "Bye from Task Zero!\n"
  taskone_say: .asciiz "Hi I'm Task One!\n"
  taskone_bye: .asciiz "Bye from Task One!\n"

.text
  .globl main

  main:
  la $a0, __TASK_0                      # load address of task 0
  la $a1, __TASK_1                      # load address of task 1
  la $t0, tcb0                          # load address of tcb0
  la $t1, tcb1                          # load address of tcb1
  sw $a0, 0($t0)                        # store address of task 0 in tcb0
  sw $a1, 0($t1)                        # store address of task 1 in tcb1
  la $a1, tid                           # load tid into register a1
  sw $0, 0($a1)                         # initialize tid to 0
  jal __TASK_0                          # jump and link to task 0


  __TASK_SWITCHER:
    addi $sp, $sp, -4                   # move stack pointer down
    sw $t0, 0($sp)                      # store t0 onto stack
    lw $t0, tid                         # load tid into t0
    beq $t0, $0, savezero
    j saveone

    savezero:
      la $t0, tcb0                      # load address of tcb0 (savezero)
      sw $ra, 0($t0)                    # store return address
      lw $a0, 0($sp)                    # grab address of tcb0 from stack
      addi $sp, $sp, 4                  # restore stack
      sw $a0, 8($t0)                    # store in tcb0 offset 8

      #TODO: Store other registers

      la $a1, tid                       # load tid
      li $a1, 1                         # update tid to 1
      la $t1, tcb1                      # load tcb1
      lw $ra, 0($t1)                    # load return address
      jr $ra                            # return to task 1

    saveone:
      la $t1, tcb1                      # load address of tcb1 (saveone)
      sw $ra, 0($t1)                    # store return address
      lw $a0, 0($sp)                    # grab address of tcb0 from stack
      addi $sp, $sp, 4                  # restore stack
      sw $a0, 8($t1)                    # store in tcb0 offset 8

      #TODO: Store other registers

      la $a1, tid                       # load tid
      li $a1, 0                         # update tid to 0
      la $t1, tcb0                      # load tcb0
      lw $ra, 0($t1)                    # load return address
      jr $ra                            # return to task 0

  __TASK_0:
    li $v0, 4 # entered task 0
    la $a0, taskzero_say
    syscall
    jal __TASK_SWITCHER
    la $a0, taskzero_bye
    syscall
    jal __TASK_SWITCHER
    j __TASK_0

  __TASK_1:
    li $v0, 4 # entered task 1
    la $a0, taskone_say
    syscall
    jal __TASK_SWITCHER
    la $a0, taskone_bye
    syscall
    j __TASK_1
