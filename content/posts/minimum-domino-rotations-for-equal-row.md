+++
date = "2019-05-17"
title = "Minimum Domino Rotations For Equal Row"
slug = "Minimum Domino Rotations For Equal Row"
tags = []
categories = []
+++

## Introduction

In a row of dominoes, A[i] and B[i] represent the top and bottom halves of the i-th domino.  (A domino is a tile with two numbers from 1 to 6 - one on each half of the tile.)

We may rotate the i-th domino, so that A[i] and B[i] swap values.

Return the minimum number of rotations so that all the values in A are the same, or all the values in B are the same.

If it cannot be done, return -1.

 
Example 1:

```
Input: A = [2,1,2,4,2,2], B = [5,2,6,2,3,2]
Output: 2
Explanation: 
The first figure represents the dominoes as given by A and B: before we do any rotations.
If we rotate the second and fourth dominoes, we can make every value in the top row equal to 2, as indicated by the second figure.
```

Example 2:
```
Input: A = [3,5,1,2,3], B = [3,6,3,3,4]
Output: -1
Explanation: 
In this case, it is not possible to rotate the dominoes to make one row of values equal.
``` 

Note:
```
1 <= A[i], B[i] <= 6
2 <= A.length == B.length <= 20000
```

### Solution

Golang:
``` go
func minDominoRotations(A []int, B []int) int {
    
    n := len(A)
    
    dp := make([]int, 12)
    da := dp[:6]
    db := dp[6:]
    
    for i := 0; i < n; i++ {
        for d := 1; d <= 6; d++ {
            if A[i] != d {
                if B[i] != d {
                    da[d-1] = -1
                } else if da[d-1] != -1 {
                    da[d-1]++
                }
            }
            if B[i] != d {
                if A[i] != d {
                    db[d-1] = -1
                } else if db[d-1] != -1 {
                    db[d-1]++
                }
            }
        }
    }
    
    m := -1
    for _, v := range dp {
        if v != -1 && (m == -1 || m > v) {
            m = v
        }
    }
    return m
}
```

### Explanation

Lets solve this problem by using dynamic counters and find min from them.

