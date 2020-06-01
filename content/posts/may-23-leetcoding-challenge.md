+++
date = "2020-05-23"
title = "Interval List Intersections"
slug = "may 23 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given two lists of closed intervals, each list of intervals is pairwise disjoint and in sorted order.

Return the intersection of these two interval lists.

(Formally, a closed interval [a, b] (with a <= b) denotes the set of real numbers x with a <= x <= b.  The intersection of two closed intervals is a set of real numbers that is either empty, or can be represented as a closed interval.  For example, the intersection of [1, 3] and [2, 4] is [2, 3].)


Example 1:
```
Input: A = [[0,2],[5,10],[13,23],[24,25]], B = [[1,5],[8,12],[15,24],[25,26]]
Output: [[1,2],[5,5],[8,10],[15,23],[24,24],[25,25]]
Reminder: The inputs and the desired output are lists of Interval objects, and not arrays or lists.
```


Note:
```
0 <= A.length < 1000
0 <= B.length < 1000
0 <= A[i].start, A[i].end, B[i].start, B[i].end < 10^9
NOTE: input types have been changed on April 15, 2019. Please reset to default code definition to get new method signature.
```

## Solution

Let's do merge of two sorted arrays, keeping in mind about intervals and use min and max methods to test them.

``` go
func intervalIntersection(A [][]int, B [][]int) [][]int {
    var out [][]int
    for i, j := 0, 0; i < len(A) && j < len(B); {
        x := max(A[i][0], B[j][0])
        y := min(A[i][1], B[j][1])
        if x <= y {
            out = append(out, []int { x, y })
        }
        if A[i][1] <= y {
            i++
        } else if A[i][0] <= y {
            A[i][0] = y+1  
        }
        if B[j][1] <= y {
            j++
        } else if B[j][0] <= y {
            B[j][0] = y+1
        }
    }
    return out
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```


Performance of this solution

```
Runtime: 20 ms
Memory Usage: 6.3 MB
```
