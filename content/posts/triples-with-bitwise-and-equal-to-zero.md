+++
date = "2019-05-15"
title = "Triples with Bitwise AND Equal To Zero"
slug = "Triples with Bitwise AND Equal To Zero"
tags = []
categories = []
+++

## Introduction

Given an array of integers A, find the number of triples of indices (i, j, k) such that:
```
0 <= i < A.length
0 <= j < A.length
0 <= k < A.length
A[i] & A[j] & A[k] == 0, where & represents the bitwise-AND operator.
```

Example 1:
```
Input: [2,1,3]
Output: 12
Explanation: We could choose the following i, j, k triples:
(i=0, j=0, k=1) : 2 & 2 & 1
(i=0, j=1, k=0) : 2 & 1 & 2
(i=0, j=1, k=1) : 2 & 1 & 1
(i=0, j=1, k=2) : 2 & 1 & 3
(i=0, j=2, k=1) : 2 & 3 & 1
(i=1, j=0, k=0) : 1 & 2 & 2
(i=1, j=0, k=1) : 1 & 2 & 1
(i=1, j=0, k=2) : 1 & 2 & 3
(i=1, j=1, k=0) : 1 & 1 & 2
(i=1, j=2, k=0) : 1 & 3 & 2
(i=2, j=0, k=1) : 3 & 2 & 1
(i=2, j=1, k=0) : 3 & 1 & 2
``` 

Note:
```
1 <= A.length <= 1000
0 <= A[i] < 2^16
```

### Solution

Brute force solution:
``` go
func countTriplets(A []int) int {
    n := len(A)
    cnt := 0
    for i := 0; i < n; i++ {
        for j := 0; j < n; j++ {
            for k := 0; k < n; k++ {
                if A[i] & A[j] & A[k] == 0 {
                    cnt++
                }    
            }
        }
    }
    return cnt
}
```

### Explanation

Lets start with brute force solution and then take a look how we can optimize it.


