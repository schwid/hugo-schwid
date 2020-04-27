+++
date = "2020-04-27"
title = "Maximal Square"
slug = "27 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a 2D binary matrix filled with 0's and 1's, find the largest square containing only 1's and return its area.

Example:

Input:
```
1 0 1 0 0
1 0 1 1 1
1 1 1 1 1
1 0 0 1 0
```
Output: 4


## Solution

This task is easy to solve by brute force. And actually it gave me the maximum performance on it.

Results of execution of brute force
```
Runtime: 0 ms
Memory Usage: 3.4 MB
```

So, the idea of brute force is to try each point in matrix to be the left-top corner of the square.
We have O(n*m) two loops that goes through all points and trying to getSquare for each point.

GetSquare method simply goes through all possible square lengths from 0 to ...
It also checks the borders and exist with current achievable square length `k` if not possible to build bigger square.


``` go
func maximalSquare(matrix [][]byte) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }
    m := len(matrix[0])

    maxSoFar := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            maxSoFar = max(maxSoFar, getSquare(matrix, i, j, n, m))
        }
    }
    return maxSoFar * maxSoFar
}

func getSquare(matrix [][]byte, i, j, n, m int) int {
    k := 0
    for {
        if i + k >= n || j + k >= m {
            return k
        }
        for ii := i; ii <= i+k; ii++ {
            for jj := j; jj <= j+k; jj++ {
                if matrix[ii][jj] != '1' {
                    return k
                }
            }
        }
        k++
    }
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```
