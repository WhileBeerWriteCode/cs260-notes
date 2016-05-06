
# Stack Parameter passing

### Bruce Emehiser
#### 2016 04 21
---

To pass parameters to a subroutine call, we put the call parameters
on a stack.

In assembly, the stack pointer $sp is the stack pointer that points
at the top of the stack. To place a parameter on the stack, we put
assign the value to the top of the stack.

This code:

1. Loads the int 5 into register t0, then
2. Moves the stack pointer from the down one
3. Stores the register t0 into the stack pointer sp
4. Makes a jump and link call to the subroutine. jal stores the return address into the register ra
5. makes a second subroutine call subroutine call stores current return address onto the stack before making the call. Then it loads the pointer from the stack so it can return to its caller
6. Returns to caller


```asm

.text

li, $t0, 5				# load an arbitrary value 5 into register t0
addi sp, sp, -4			# move the stack pointer to point at the next stack address
sw $t0, 0($sp)			# store data value into stack pointer (parameter)
jal SubRoutine			# jump to subroutine

SubRoutine:				# subroutine signature

	# subroutine code goes here
		
	# second subroutine call
		
	addi $sp, $sp, -4	# move the stack pointer down
	sw $ra, 0(sp)		# save the current return address to the stack
	jal SecSR			# jump to second subroutine
	
	lw $ra, 0(sp)		# load saved return address from register
	addi $sp, $sp, 4	# move the stack pointer up
	
	jr $ra 				# jump return to return address
	
SecSR:

	# second subroutine
	
	jr $ra			# jump return to return address

```