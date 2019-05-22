+++
date = "2019-05-21"
title = "Partition Equal Subset Sum"
slug = "Partition Equal Subset Sum"
tags = []
categories = []
+++

## Introduction

Given a non-empty array containing only positive integers, find if the array can be partitioned into two subsets such that the sum of elements in both subsets is equal.

Note:
```
Each of the array element will not exceed 100.
The array size will not exceed 200.
```

Example 1:
```
Input: [1, 5, 11, 5]
Output: true
```
Explanation: The array can be partitioned as [1, 5, 5] and [11].


Example 2:
```
Input: [1, 2, 3, 5]
Output: false
```
Explanation: The array cannot be partitioned into equal sum subsets.

### Solution

Simple dynamic programming solution:
``` go
func canPartition(nums []int) bool {

    n := len(nums)

    sum := 0
    for _, v := range nums {
        sum += v
    }

    if sum & 1 == 1 {
        return false
    }

    half := sum / 2

    dp := make([][]bool, n+1)

    for i := 0; i <= n; i++ {
        dp[i] = make([]bool, half+1)
        dp[i][0] = true
    }

    dp[0][0] = true

    for i := 1; i <= n; i++ {
        for j := nums[i-1]; j <= half; j++ {
            dp[i][j] = dp[i-1][j] || dp[i-1][j-nums[i-1]]             
        }
    }

    return dp[n][half]
}
```

Optimized dynamic programming solution:
``` go
func canPartition(nums []int) bool {

    sum := 0
    for _, v := range nums {
        sum += v
    }

    if sum & 1 == 1 {
        return false
    }

    half := sum / 2

    dp := make([]bool, half+1)
    dp[0] = true

    for _, v := range nums {
        for j := half; j >= v; j-- {
            dp[j] = dp[j] || dp[j - v]
        }
    }    

    return dp[half]
}
```

### Explanation

This problem could be transform to binary knapsack problem, where we try to fill half of sum.
First solution is modified knapsack solution for partition equal sums.
Second solution is optimized partition equal sums solution.
