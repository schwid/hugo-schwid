+++
date = "2020-04-21"
title = "Leftmost Column with at Least a One"
slug = "Leftmost Column with at Least a One"
tags = []
categories = []
+++

## Introduction

(This problem is an interactive problem.)

A binary matrix means that all elements are 0 or 1. For each individual row of the matrix, this row is sorted in non-decreasing order.

Given a row-sorted binary matrix binaryMatrix, return leftmost column index(0-indexed) with at least a 1 in it. If such index doesn't exist, return -1.

You can't access the Binary Matrix directly.  You may only access the matrix using a BinaryMatrix interface:

BinaryMatrix.get(row, col) returns the element of the matrix at index (row, col) (0-indexed).
BinaryMatrix.dimensions() returns a list of 2 elements [rows, cols], which means the matrix is rows * cols.
Submissions making more than 1000 calls to BinaryMatrix.get will be judged Wrong Answer.  Also, any solutions that attempt to circumvent the judge will result in disqualification.

For custom testing purposes you're given the binary matrix mat as input in the following four examples. You will not have access the binary matrix directly.


Example 1:

Input: mat = [[0,0],[1,1]]
Output: 0
Example 2:

Input: mat = [[0,0],[0,1]]
Output: 1
Example 3:

Input: mat = [[0,0],[0,0]]
Output: -1
Example 4:

Input: mat = [[0,0,0,1],[0,0,1,1],[0,1,1,1]]
Output: 1

Constraints:
```
rows == mat.length
cols == mat[i].length
1 <= rows, cols <= 100
mat[i][j] is either 0 or 1.
mat[i] is sorted in a non-decreasing way.
```

## Solution

Let's solve this problem by binary search for all rows.

``` go
/**
 * // This is the BinaryMatrix's API interface.
 * // You should not implement it, or speculate about its implementation
 * type BinaryMatrix struct {
 *     Get(int, int) int
 *     Dimensions() []int
 * }
 */

func leftMostColumnWithOne(binaryMatrix BinaryMatrix) int {
    dims := binaryMatrix.Dimensions()
    n, m := dims[0], dims[1]
    min_col := m
    for i := 0; i < n; i++ {
        lo, hi := 0, min(min_col, m)
        for lo < hi {
            mi := (hi - lo) / 2 + lo
            val := binaryMatrix.Get(i, mi)
            if val == 0 {
                lo = mi+1
            } else if val == 1 {
                min_col = min(min_col, mi)
                hi = mi
            }
        }
    }   
    if min_col == m {
        return -1
    }
    return min_col
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```

This is already pretty fast algorithm for 8ms
