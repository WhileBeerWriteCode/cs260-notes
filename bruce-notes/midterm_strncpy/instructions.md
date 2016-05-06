# Programming Test 1
## Architecture and Organization
##### Bruce Emehiser
##### 2016 05 03

## Description:

Implement strncpy function and write main to test your function.

#### Format
```
strncpy( address of destination, address of source, n bytes to copy)
```

#### For example:

```
s = "abcdefg";

strncpy( d, s, 4);

// d == "abcd\0"
```

 d will contain "abcd". And place the terminating 0 at the end of "abcd, so you can print it with string print syscall.

##Grading:

* Impressive 110%
* Working 100%
* Seems to be working but with errors each error -10%
* Not working 0%~5%.

## Suggested Coding Example:

main

strncpy( d, s, 4);

print d

strncpy( d, s, 6);

print d

exit syscall

strncpy:

 copy s to d until n-bytes count.