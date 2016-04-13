# Useful references

[Spim quick reference](https://www.cs.tcd.ie/John.Waldron/itral/spim_ref.html)
[Sample spim program with loop](https://www.cs.uic.edu/~troy/spring04/cs366/ex2.html)


# Load and store architecture

* MIPS is this
* Loads data from memory into register, then stores output into main memory (duh)
* Intel is not load and store (there are some instructions that can read directly from memory directly)

Mips Syntax

```

lw $a1 0($a0) # load word from location referenced at a0 into register a1
sw $a1 0($a0) # store contents of a1 into location referenced in a0

# allocating memory

.data
var1: .space 4 # allocate empty space for 4 bytes
var2: .word 4 # initialize the number 4
var3: .word 4, 5, 6, 7 # initialize array of numbers


```

Word boundaries: makes hardware faster in exchange for programmers having headaches.

Assembler directives: Don't generate code, just tell the assembler what to do with stuff.

```

.align n
    # Align the next datum on a 2^n byte boundary. For example, .align 2 aligns the next value on a word boundary. .align 0 turns off automatic alignment of .half, .word, .float, and .double directives until the next .data or .kdata directive.
```

All MIPS instructions are 32 bits long.  Since the instruction number, register, and memory address all have to fit inside
of 32 bits, it's impossible for the `lw` instruction to be implemented.  It's a pseudo instruction
which the assembler splits into two instruction. One loads the upper half and the second
instruction loads the lower bits.


# Assignment

Copy one array into another

```
.data
array1: .word 0, 1, 2, 3, 4, 5, 6, 7, 8, 9

array2: .space 40

.globl main

.text
main:

# your code here
```
