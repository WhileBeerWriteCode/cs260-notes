
# Device Programming and Device I/O Mapping
2016 05 12
2016 05 17

## Memory Mapped I/O

Many of our devices used memory mapped I/O. This means that the memory contains the keyboard mapping, so when a keystroke is logged it will look at a location in memory get the mapping address.

### Polling I/O

1. Check the input ready bit
2. If the ready bit is 1, then read data register

1. Check the output buffer ready bit
2. If the ready bit is 1, then write data to the output

```

# character input

	lui $t0, 0xffff					# ffff0000 load unsigned int of the input register
		
	inputLoop:
		lw $t1, 0($t0) 				# load input set bit from the input register to t1
		andi $t1, $t1, 0x0001
		beq $t1, $0, inputLoop		# loop until input set is 1
	lw $v0, 4($t0)					# load the data into v0

# character output
		
	lui $t0,0xffff					# ffff0000
	
	outputLoop:
		lw $t1, 8($t0) 				# get outbut buffer ready bit
		andi $t1, $t1, 0x0001
		beq $t1, $0, outputLoop		# loop until output buffer ready
	sw $a0, 12($t0) 				# write data from a0 to output
```

## Hardware Mapped I/O

When you type a character, the data ready bit is set. Then it goes to the data bit and reads it. 



### Interrupt Driven I/O

Hardware interrupt is where the hardware puts data into the pipeline processor.

##### Control Register
Each device has a set of four registers. They contain information on whether or not to register system interrupts, and perform other IO operations. This is the control register.

