
# Basic Assembly Language Syntax

#### Bruce Emehiser
#### 2016 04 12
---

##Load and Store Memory

Load and store values using l# tags

```
la $a0, var1			# load address from label var1
lw $a1, 0($a0)			# load the word from address a0 into register a1
lb $t0, 0($a0)			# load byte from address a0 into register t0
sw $a1, 0($a0)			# store word
```

After the .data tag, we can define global memory variables.

```
.data

name: .asciiz "Bruce Emehiser"
```

Name is 6 chars long, which means that the next byte won't align properly. We fix this by saying ".align 2" to align to next word boundary.
name: .asciiz "hello"
.align 2 # this means align the next guy to 2^2, or we could say .align 3, which is 2^3, or align to the next 8 bytes

You could also allocate name by each byte

`name: .byte 'h', 'e', 'l', 'l', 'o', 0`

Uninitialized 4 byte memory request (calloc) into var1;

`var1: .space 4`

Initialized 4 byte memory request (malloc) into var2 = {4, 8, 10, 2, 3};


`var2: .word 4`


## Word Boundary
Word boundary is a hardware restriction to make hardware faster. This means that the address you are trying to load from has to be divisible by 4, or 4 bytes. This makes it so that the bus only has to talk to the memory once instead of twice to get the word.

```
.data

numberSet: .asciiz "1234"	# allocate 5 bytes (4 plus null terminating character)
.align 2					# align to word boundary
```

## 	Example Load Address

```

.data

str0: .asciiz "Name = "
# fix the allignment after loading string, in case string is odd number of characters
.align 2

# load 4 byte (32 bit) int into var0
var0: .word 5

.text
main:

	# read
	la $a0, str0
	addi $v0, $0, 4
	syscall
	
	# print
	la $a0, var0
	addi $v0, 10
	syscall
	
	# exit
	addi $v0, 10
	syscall
	
```

## Loading Array Elements
(Assume array is initialized in the `.data` section of the program.)

la $a1, array  # array
lw $t1, 0($a1) # first index in array
lw $t2, 4($a1) # second index in arrya


## Branch controls.
(loops)

Conditional branch
`if($t1 == 5) { execute loc0 }`

if register t1 contains the value 5, jump to tag "location"
`beq $t1, 5, location`

Unconditional branch (use b or j). This will jump to the location "skip".
`b  skip`
We can also use
`j skip`

This is the example program.
```
beq $t1, 5, location

b  skip

location:
	add $t2, $t3, $t4
skip:

```

We can also write it like this to save one instruction branch not equal
```
bne $t1, 5, skip	# jump to skip if t1 contains value 5

add $t2, $t3, $t4	# if not skipped, this will execute

skip:				# branching tag
```


