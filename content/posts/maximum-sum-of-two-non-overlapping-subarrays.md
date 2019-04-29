+++
date = "2019-04-29"
title = "Maximum Sum of Two Non-Overlapping Subarrays"
slug = "Maximum Sum of Two Non-Overlapping Subarrays"
tags = []
categories = []
+++

## Introduction

Given an array A of non-negative integers, return the maximum sum of elements in two non-overlapping (contiguous) subarrays, which have lengths L and M.  (For clarification, the L-length subarray could occur before or after the M-length subarray.)

Formally, return the largest V for which V = (A[i] + A[i+1] + ... + A[i+L-1]) + (A[j] + A[j+1] + ... + A[j+M-1]) and either:
```
0 <= i < i + L - 1 < j < j + M - 1 < A.length, or
0 <= j < j + M - 1 < i < i + L - 1 < A.length.
```

Example 1:
```
Input: A = [0,6,5,2,2,5,1,9,4], L = 1, M = 2
Output: 20
Explanation: One choice of subarrays is [9] with length 1, and [6,5] with length 2.
```
Example 2:
```
Input: A = [3,8,1,3,2,1,8,9,0], L = 3, M = 2
Output: 29
Explanation: One choice of subarrays is [3,8,1] with length 3, and [8,9] with length 2.
```
Example 3:
```
Input: A = [2,1,5,6,0,9,5,0,3,8], L = 4, M = 3
Output: 31
Explanation: One choice of subarrays is [5,6,0,9] with length 4, and [3,8] with length 3.
``` 

Note:
```
L >= 1
M >= 1
L + M <= A.length <= 1000
0 <= A[i] <= 1000
```

### Solution

Dynamic programming solution:
``` go
func maxSumTwoNoOverlap(A []int, L int, M int) int {
    return max(dp(A, L, M), dp(A, M, L))
}

func dp(A []int, L int, M int) int {
    
    n := len(A)
    
    if L + M > n {
        return 0
    }
    
    m := n-L-M
    
    dp := make([][]int, m+1)
 
    sumL := 0
    for i := 0; i < L; i++ {
        sumL += A[i]
    }
    
    sumM := 0
    for j := 0; j < M; j++ {
        sumM += A[n-j-1]
    }
    
    // [L....M]
    dp[0] = make([]int, m+1)
    dp[0][0] = sumL + sumM
    
    maxSoFar := dp[0][0]
    
    for i := 1; i <= m; i++ {
        dp[i] = make([]int, m+1)
        dp[i][0] = dp[i-1][0] + A[i-1+L] - A[i-1]
        maxSoFar = max(maxSoFar, dp[i][0])
    }
 
    for j := 1; j <= m; j++ {
        dp[0][j] = dp[0][j-1] + A[n-M-j] - A[n-j]
        maxSoFar = max(maxSoFar, dp[0][j])
    }
  
    for i := 1; i <= m; i++ {
        for j := 1; j <= m-i; j++ {
            dp[i][j] = dp[i-1][j-1] + A[i-1+L] - A[i-1] + A[n-M-j] - A[n-j]
            maxSoFar = max(maxSoFar, dp[i][j])
        }
    }

    return maxSoFar
    
}

func max(a, b int) int {
    if a >= b {
        return a
    } else {
        return b
    }
}
```

### Explanation

There are two options of maximum sum solution:
* L array before M array
* L array after M array

Both problems are dynamic programming tasks, where size of 2D matrix is `m+1*m+1`, whereas `m=n-L-M`.
We place the first sub-array at the beginning of array `A` and second sub-array at the end of array `A` and finding all sums in the middle.
Max sum is our solution.
