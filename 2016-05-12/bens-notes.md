# Device programming

2 ways to accomplish
* IO instruction
  * special instruction just for accessing IO devices
  * does not use any space in memory
* Memory mapped I/O
  * no special instruction to access IO
  * read/ write from location in memory instead
  * reserved some memory just for IO

[Drawing for IO mapping methods](https://drive.google.com/file/d/0B2CZ6tvCHNj9TG5wTmpnMjRQaWM/view?usp=sharing)

Need to use an option in QTSpim to enable memory mapped IO.  


Ready bit set to 1 when input is available on device.
```
# pseudo code
if (ready_bit == 1)
  check data register
```

Polling the register
```
# top of loop
poll_keyboard:
lui $t0 0xffff # load upper address of IO location
lw $t1, ($t0) # read from IO location

andi $t1, $t1, 1 # and with 1 to check if ready
beq $t1, $zero, poll_keyboard

# end of loop

lw $t1, 4($t0) $load data out of data register of IO device

```

# Next assignment
Write keyboard read using memory mapped IO
