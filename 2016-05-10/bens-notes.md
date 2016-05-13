# Task switching

```
.data
tcb0: @ra # 32 registers x 4 bytes
tcb1: @ra task2

tid:
#...

.text

main:
  la $a0 task0
  la $a1 task1
  la $t0 tcb0
  la $t1 tcb1
  sw $a0, 8($t0)
  sw $a1, 8($t1)
  la $a1, tid
  sw $0, 0($a1)
  j task0

task0:
  # some task code here
  jal ts # relinquish CPU to task switcher
  # some more task code
  jal ts
  j task0

task1:
  # some task code here
  jal ts
  j task1


ts: # Task swticher code

  sp = sp -4 # move stack pointer down
  sw $t0 0($sp)
  la $t0, tid
  lw $t0, 0($t0)
  beq $t0, $0, zerorunning

zerorunning:

  # save registers to tcb0
  # update tid
  # restore items from tcb 1

  lw $a0, 0($sp) # reload former contents of t0 (saved on stack in task switcher)
  



 # if (tid == 0)
     goto task 1
   else
     goto task 0

```
