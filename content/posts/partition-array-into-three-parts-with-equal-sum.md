+++
date = "2019-05-01"
title = "Partition Array Into Three Parts With Equal Sum"
slug = "Partition Array Into Three Parts With Equal Sum"
tags = []
categories = []
+++

## Introduction

Given an array A of integers, return true if and only if we can partition the array into three non-empty parts with equal sums.

Formally, we can partition the array if we can find indexes i+1 < j with (A[0] + A[1] + ... + A[i] == A[i+1] + A[i+2] + ... + A[j-1] == A[j] + A[j-1] + ... + A[A.length - 1])

 

Example 1:
```
Input: [0,2,1,-6,6,-7,9,1,2,0,1]
Output: true
Explanation: 0 + 2 + 1 = -6 + 6 - 7 + 9 + 1 = 2 + 0 + 1
```

Example 2:
```
Input: [0,2,1,-6,6,7,9,-1,2,0,1]
Output: false
```

Example 3:
```
Input: [3,3,6,5,-2,2,5,1,-9,4]
Output: true
Explanation: 3 + 3 = 6 = 5 - 2 + 2 + 5 + 1 - 9 + 4
```

Note:
```
3 <= A.length <= 50000
-10000 <= A[i] <= 10000
```

### Solution

Simple solution:
``` go
func canThreePartsEqualSum(A []int) bool {
    
    n := len(A)
    
    sum := 0
    for _, v := range A {
        sum += v
    }
    
    firstSum := 0
    for i := 0; i < n; i++ {
        
        firstSum += A[i]
        
        secondSum := 0
        for j := i+1; j < n; j++ {
            
            secondSum += A[j]
            
            if firstSum == secondSum && firstSum == sum - firstSum - secondSum {
                return true
            }
        }
    }
    return false
}
```

### Explanation

If we precalculate the total sum of array, we can solve this problem by going through all combinations between first sub-array `[0,i]`, second sub-array `[i+1,j]` and the third subarray `[j+1,n-1]`.
If sum of all 3 subarrays ar equal, then we have a solution of partitioning the array.

