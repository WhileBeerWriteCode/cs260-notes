
# Scope

### Bruce Emehiser
### 2016 04 21


* Global Variables 
	Global variables live in the .data section of the program.

* Member variables
	Member variables live on the stack. Each time a subroutine is called,
	the variables it contains will be written to the stack.

* Stack Frames
	We use something called a "stack frame" which will store the current 
	state of the method call onto the stack.

This is an example of a stack frame.
The size of the stack frame is 16
	
```asm

	# entry code
	 addi sp, sp, -16		# move stack pointer down
	 sw $s0, 12($sp) 		# store first variable on stack
	 sw $s1, 8($sp)			# store second variable on stack
	 sw $ra, 4($sp)			# store return address on stack

	# exit code
	lw $s0, 12($sp)			# load first variable
	lw $s1, 8($sp)			# load second variable
	lw $ra, 4($sp)			# load return address
	addi sp, sp, 16			# move stack pointer up

```
	
* Frame Pointers
	Instead of walking all the way back up the stack, we can store
	the current value or stack height of the stack frame into the
	frame pointer $fp. We can then use this to reference the variables
	without having to walk all the way back up the stack.
