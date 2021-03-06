+++
date = "2019-05-11"
title = "Complement of Base 10 Integer"
slug = "Complement of Base 10 Integer"
tags = []
categories = []
+++

## Introduction

Every non-negative integer N has a binary representation.  For example, 5 can be represented as "101" in binary, 11 as "1011" in binary, and so on.  Note that except for N = 0, there are no leading zeroes in any binary representation.

The complement of a binary representation is the number in binary you get when changing every 1 to a 0 and 0 to a 1.  For example, the complement of "101" in binary is "010" in binary.

For a given number N in base-10, return the complement of it's binary representation as a base-10 integer.



Example 1:
```
Input: 5
Output: 2
Explanation: 5 is "101" in binary, with complement "010" in binary, which is 2 in base-10.
```

Example 2:
```
Input: 7
Output: 0
Explanation: 7 is "111" in binary, with complement "000" in binary, which is 0 in base-10.
```

Example 3:
```
Input: 10
Output: 5
Explanation: 10 is "1010" in binary, with complement "0101" in binary, which is 5 in base-10.
```

Note:
```
0 <= N < 10^9
```

### Solution

Xor solution:
``` go
func bitwiseComplement(N int) int {
    if N == 0 {
        return 1
    }
    n := N
    mask := 0
    for n > 0 {
        if mask != 0 {
            mask <<= 1
        }
        mask |= 1
        n >>= 1
    }
    return N ^ mask
}
```

### Explanation

Lets first check for 0, because it is a special case.
After that lets create a mask of ones for the size of the number and finally xor with this mask.
It will invert all binary digits in the number.
