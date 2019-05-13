+++
date = "2019-05-12"
title = "Binary Prefix Divisible By 5"
slug = "Binary Prefix Divisible By 5"
tags = []
categories = []
+++

## Introduction

Given an integer array A, you partition the array into (contiguous) subarrays of length at most K.  After partitioning, each subarray has their values changed to become the maximum value of that subarray.

Return the largest sum of the given array after partitioning.



Example 1:
```
Input: A = [1,15,7,9,2,5,10], K = 3
Output: 84
Explanation: A becomes [15,15,15,9,10,10,10]
```

Note:
```
1 <= K <= A.length <= 500
0 <= A[i] <= 10^6
```

### Solution

Dynamic Programming Solution:
``` go
func maxSumAfterPartitioning(A []int, K int) int {

    n := len(A)
    dp := make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = A[i-1]
    }

    for i := 1; i <= n; i++ {
        for j := max(0, i-K); j < i; j++ {
            dp[i] = max(dp[i], dp[j] + maxOf(A[j:i]) * (i-j))
        }
    }

    return dp[n]
}

func maxOf(A []int) int {
    n := len(A)
    maxSoFar := A[0]
    for i := 1; i < n; i++ {
        maxSoFar = max(maxSoFar, A[i])
    }   
    return maxSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

### Explanation

The best way to solve this problem is to use dynamic programming approach.
In this case we need to find a sub-problem and store value in `dp` array for sub-problem.

Support we have and array `[1,2,4]` and we are in the last element with `K == 2`.
We need to find the `maxOf([2,4]) * 2` if the last range, that would be `8` and compare with
two conditions:
* Include `4` in to the last range and get split `[1]`, `[2, 4]` with total `1 + 8 = 9`
* Do not include `4` in to the last range, and have sub-problem max [1,2] + [4], that give `2+2 + 4 = 8`, that is less

So, finally we will prefer to take sum of subproblem `[1]` plus current range `dp[j] + maxOf(A[j:i]) * (i-j)` that is
`1 + 4 * 2`.
