+++
date = "2019-05-16"
title = "Binary String With Substrings Representing 1 To N"
slug = "Binary String With Substrings Representing 1 To N"
tags = []
categories = []
+++

## Introduction


Given a binary string S (a string consisting only of '0' and '1's) and a positive integer N, return true if and only if for every integer X from 1 to N, the binary representation of X is a substring of S.

 

Example 1:
```
Input: S = "0110", N = 3
Output: true
```

Example 2:
```
Input: S = "0110", N = 4
Output: false
``` 

Note:
```
1 <= S.length <= 1000
1 <= N <= 10^9
```

### Solution

Simple solution:
func queryString(S string, N int) bool {
    
    n := len(S)    
    maxBits := numBits(N) 
    
    visit := make([]bool, N+1)

    for i := 0; i < n; i++ {
        
        if S[i] == '0' {
            continue
        }
        
        for j := i+1; j <= min(n, i+1+maxBits); j++ {
            v := parse(S[i:j], j - i)
            if v <= N {
                visit[v] = true
            }
        }
    }
    
    for _, v := range visit[1:] {
        if !v {
            return false
        }
    }
    
    return true
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func numBits(val int) int {
    cnt := 1
    val >>= 1
    for ; val > 0; cnt++ {
        val >>= 1
    }
    return cnt
}

func parse(A string, n int) int {
    if n == 0 {
        return 0
    }
    val := int(A[0] - '0')
    for i := 1; i < n; i++ {
        val <<= 1
        val |= int(A[i] - '0')
    }
    return val
}
``` go
```

### Explanation

We need to create an array or set to keep track of visited numbers.
If all numbers from 1 to N are visited, then return answer is true.

We go through array S and on each step skip zeros, because all numbers that start from zeros would be visited later in the loop.
For optimization purposes we do not look in array S more than the number of bits in number N.
Each slice we parse and update `visit` array.
BitSet in this task could improve memory consumption, but we do not have it in golang.


