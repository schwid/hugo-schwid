+++
date = "2019-05-10"
title = "Smallest Integer Divisible by K"
slug = "Smallest Integer Divisible by K"
tags = []
categories = []
+++

## Introduction

Given a positive integer K, you need find the smallest positive integer N such that N is divisible by K, and N only contains the digit 1.

Return the length of N.  If there is no such N, return -1.

 
Example 1:
```
Input: 1
Output: 1
Explanation: The smallest answer is N = 1, which has length 1.
```

Example 2:
```
Input: 2
Output: -1
Explanation: There is no such positive integer N divisible by 2.
```

Example 3:
```
Input: 3
Output: 3
Explanation: The smallest answer is N = 111, which has length 3.
```

Note:
```
1 <= K <= 10^5
```


### Solution

Golang:
``` go
func smallestRepunitDivByK(K int) int {
    
    if K % 2 == 0 || K % 5 == 0 {
        return -1
    }
        
    N := 1
    cnt := 1
    remainders := make(map[int]bool)
            
    for N % K != 0 {
        
        if remainders[N % K] {
            return -1 
        }

        remainders[N % K] = true

        N = 10 * (N % K) + 1
        cnt++
    }
        
    return cnt;
}
```

### Explanation

If K divide on 2 or 5 without remainder then we can not find N for it, return -1
Otherwise lets work with reminders. In order to prevent looping on reminders lets use map as a cache.

