
## Mixing Languages

#### Bruce Emehiser
#### 2016 04 21
---

Mixing Languages.
	To mix languages we need to know three things.

1. 	The order of the passed parameters.
	C passes from left to right, where the left parameter is on the top of the stack.
	Fortran passes from right to left, where the right parameter is on the top of the stack.
		
2. 	How it cleans up the stack.   
	Some languages clean up the stack in the calling method, and some clean up the stack in the called method.
		
3. 	Pass by reference vs value.
	C passes by value.
	Fortran passes by reference.
	