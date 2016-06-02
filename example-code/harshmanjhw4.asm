.data

  tcb0: .space 128
  tcb1: .space 128
  tid: .word 1

  str0:   .asciiz "123"
  str1:   .asciiz "45678"

  # taskzero_say: .asciiz "Hi I'm Task Zero!\n"
  # taskzero_bye: .asciiz "Bye from Task Zero!\n"
  # taskone_say: .asciiz "Hi I'm Task One!\n"
  # taskone_bye: .asciiz "Bye from Task One!\n"

.text
  .globl main

  main:
  la $a0, __TASK_0                      # load address of task 0
  la $a1, __TASK_1                      # load address of task 1
  la $t0, tcb0                          # load address of tcb0
  la $t1, tcb1                          # load address of tcb1
  sw $a0, 120($t0)                      # store address of task 0 in tcb0
  sw $a1, 120($t1)                      # store address of task 1 in tcb1
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

      #TODO: Store other registers
      sw $2, 4($t0)
      sw $3, 8($t0)
      sw $4, 12($t0)
      sw $5, 16($t0)
      sw $6, 20($t0)
      sw $7, 24($t0)
      #sw $8, 28($t0)
      sw $9, 32($t0)
      sw $10, 36($t0)
      sw $11, 40($t0)
      sw $12, 44($t0)
      sw $13, 48($t0)
      sw $14, 52($t0)
      sw $15, 56($t0)
      sw $16, 60($t0)
      sw $17, 64($t0)
      sw $18, 68($t0)
      sw $19, 72($t0)
      sw $20, 76($t0)
      sw $21, 80($t0)
      sw $22, 84($t0)
      sw $23, 88($t0)
      sw $24, 92($t0)
      sw $25, 96($t0)
      # sw $26, 100($t0)
      # sw $27, 104($t0)
      # sw $28, 108($t0)
      # sw $29, 112($t0)
      # sw $30, 116($t0)
      sw $31, 120($t0)

      lw $t1, 0($sp)
      sw $t1, 28($t0)

      la $a1, tid                       # load tid
      li $a2, 1                         # store 1 in register a2
      sw $a2, ($a1)                     # update tid to 1
      la $t0, tcb1                      # load tcb1

      # TODO: Restore registers
      lw $2, 4($t0)
      lw $3, 8($t0)
      lw $4, 12($t0)
      lw $5, 16($t0)
      lw $6, 20($t0)
      lw $7, 24($t0)
      #lw $8, 28($t0)
      lw $9, 32($t0)
      lw $10, 36($t0)
      lw $11, 40($t0)
      lw $12, 44($t0)
      lw $13, 48($t0)
      lw $14, 52($t0)
      lw $15, 56($t0)
      lw $16, 60($t0)
      lw $17, 64($t0)
      lw $18, 68($t0)
      lw $19, 72($t0)
      lw $20, 76($t0)
      lw $21, 80($t0)
      lw $22, 84($t0)
      lw $23, 88($t0)
      lw $24, 92($t0)
      lw $25, 96($t0)
      # lw $26, 100($t0)
      # lw $27, 104($t0)
      # lw $28, 108($t0)
      # lw $29, 112($t0)
      # lw $30, 116($t0)
      lw $31, 120($t0)

      lw $t0, 28($t0)                   # restore register t0
      addi $sp, $sp, 4                  # restore stack
      jr $ra                            # return to task 1

    saveone:
      la $t0, tcb1                      # load address of tcb1 (saveone)
      #sw $a0, 8($t1)                    # store in tcb1 offset 8

      #TODO: Store other registers
      sw $2, 4($t0)
      sw $3, 8($t0)
      sw $4, 12($t0)
      sw $5, 16($t0)
      sw $6, 20($t0)
      sw $7, 24($t0)
      #sw $8, 28($t0)
      sw $9, 32($t0)
      sw $10, 36($t0)
      sw $11, 40($t0)
      sw $12, 44($t0)
      sw $13, 48($t0)
      sw $14, 52($t0)
      sw $15, 56($t0)
      sw $16, 60($t0)
      sw $17, 64($t0)
      sw $18, 68($t0)
      sw $19, 72($t0)
      sw $20, 76($t0)
      sw $21, 80($t0)
      sw $22, 84($t0)
      sw $23, 88($t0)
      sw $24, 92($t0)
      sw $25, 96($t0)
      # sw $26, 100($t0)
      # sw $27, 104($t0)
      # sw $28, 108($t0)
      # sw $29, 112($t0)
      # sw $30, 116($t0)
      sw $31, 120($t0)

      lw $t1, 0($sp)
      sw $t1, 28($t0)

      la $a1, tid                       # load tid
      li $a2, 0                         # store 0 in register a2
      sw $a2, ($a1)                     # update tid to 0
      la $t0, tcb0                      # load tcb0

      # TODO: Restore registers
      lw $2, 4($t0)
      lw $3, 8($t0)
      lw $4, 12($t0)
      lw $5, 16($t0)
      lw $6, 20($t0)
      lw $7, 24($t0)
      #lw $8, 28($t0)
      lw $9, 32($t0)
      lw $10, 36($t0)
      lw $11, 40($t0)
      lw $12, 44($t0)
      lw $13, 48($t0)
      lw $14, 52($t0)
      lw $15, 56($t0)
      lw $16, 60($t0)
      lw $17, 64($t0)
      lw $18, 68($t0)
      lw $19, 72($t0)
      lw $20, 76($t0)
      lw $21, 80($t0)
      lw $22, 84($t0)
      lw $23, 88($t0)
      lw $24, 92($t0)
      lw $25, 96($t0)
      # lw $26, 100($t0)
      # lw $27, 104($t0)
      # lw $28, 108($t0)
      # lw $29, 112($t0)
      # lw $30, 116($t0)
      lw $31, 120($t0)

      lw $t0, 28($t0)                   # restore register t0
      addi $sp, $sp, 4                  # restore stack
      jr $ra                            # return to task 0

  # __TASK_0:
  #   li $v0, 4 # entered task 0
  #   la $a0, taskzero_say
  #   syscall
  #   jal __TASK_SWITCHER
  #   la $a0, taskzero_bye
  #   syscall
  #   jal __TASK_SWITCHER
  #   j __TASK_0
  #
  # __TASK_1:
  #   li $v0, 4 # entered task 1
  #   la $a0, taskone_say
  #   syscall
  #   jal __TASK_SWITCHER
  #   la $a0, taskone_bye
  #   syscall
  #   j __TASK_1

# --- Alternate tasks ---

__TASK_0:
        add  $t0, $0, $0
	jal __TASK_SWITCHER
        addi $t1, $0, 10
        la   $s0, str0
	jal __TASK_SWITCHER
beg0:
        lb   $t2, ($s0)
        beq  $t2, $0, quit0
        sub  $t2, $t2, '0'
        mult $t0, $t1
        mflo $t0
        add  $t0, $t0, $t2
	jal __TASK_SWITCHER
        add  $s0, $s0, 1
        b    beg0
quit0:
	jal __TASK_SWITCHER
	add  $v1, $0, $t0
	add  $s0, $0, $v1
	add  $a1, $0, $s0
	jal __TASK_SWITCHER
	add  $t5, $0, $a1
	add  $t6, $0, $t5
	addi $s0, $0, 1
	add  $v0, $0, $s0
	add  $a0, $0, $t6
	jal __TASK_SWITCHER
	syscall
        j __TASK_0


__TASK_1:
        add  $t0, $0, $0    #( start of task 1)
        addi $t1, $0, 10
        la   $s0, str1
beg1:
        lb   $t2, ($s0)
        beq  $t2, $0, quit1
	jal __TASK_SWITCHER
        sub  $t2, $t2, '0'    #( beg1 first return )
        mult $t0, $t1
	addi $t8, $0, 0
        addi $s5, $t8, 0
	add  $t8, $s5, $s5
        addi $t8, $0, 0
        addi $s5, $t8, 0
	add  $t8, $s5, $s5
        mflo $t0
        add  $t0, $t0, $t2
        add  $s0, $s0, 1
        b    beg1
quit1:
	add  $v1, $0, $t0
	add  $s0, $0, $v1
	jal __TASK_SWITCHER
	add  $a1, $0, $s0
	add  $t5, $0, $a1
	jal __TASK_SWITCHER
	add  $t6, $0, $t5
	jal __TASK_SWITCHER
	addi $s0, $0, 1
	add  $v0, $0, $s0
	jal __TASK_SWITCHER
	add  $a0, $0, $t6
	jal __TASK_SWITCHER
	syscall
        j __TASK_1
