+++
date = "2020-04-18"
title = "Minimum Path Sum"
slug = "Minimum Path Sum"
tags = []
categories = []
+++

## Introduction

Given a m x n grid filled with non-negative numbers, find a path from top left to bottom right which minimizes the sum of all numbers along its path.

Note: You can only move either down or right at any point in time.

Example:

Input:
```
[
  [1,3,1],
  [1,5,1],
  [4,2,1]
]
```
Output: 7
Explanation: Because the path 1→3→1→1→1 minimizes the sum.

## Solution

First of all we need to check input parameters of the matrix `m` x `n` and if it is empty return zero.
Then we need to create a temporary array to store all calculated sums, and on each step select the min from
horizontal or vertically step towards destination.

It is also possible to reuse grid array, and save memory in this task.

``` go
func minPathSum(grid [][]int) int {
    m := len(grid)
    if m == 0 {
        return 0
    }
    n := len(grid[0])
    if n == 0 {
        return 0
    }

    sums := make([][]int, m)
    for j := 0; j < m; j++ {
        sums[j] = make([]int, n)
        for i := 0; i < n; i++ {
            addon := 0
            if j > 0 {
                if i > 0 {
                     addon = min(sums[j-1][i], sums[j][i-1])
                } else {
                    addon = sums[j-1][i]
                }
            } else if i > 0 {
                addon = sums[j][i-1]
            }

            sums[j][i] = grid[j][i] + addon   
        }
    }

    return sums[m-1][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```

Finally, after refactoring we can have this elegant solution:

``` go
func minPathSum(grid [][]int) int {
    m := len(grid)
    if m == 0 {
        return 0
    }
    n := len(grid[0])
    if n == 0 {
        return 0
    }

    for i := 1; i < n; i++ {
        grid[0][i] += grid[0][i-1]
    }

    for j := 1; j < m; j++ {
        grid[j][0] += grid[j-1][0]
        for i := 1; i < n; i++ {
            grid[j][i] += min(grid[j-1][i], grid[j][i-1])
        }
    }

    return grid[m-1][n-1]
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
``` 
