+++
date = "2019-04-24"
title = "Length of Longest Fibonacci Subsequence"
slug = " Length of Longest Fibonacci Subsequence"
tags = []
categories = []
+++

## Introduction

A sequence X_1, X_2, ..., X_n is fibonacci-like if:

n >= 3
X_i + X_{i+1} = X_{i+2} for all i + 2 <= n
Given a strictly increasing array A of positive integers forming a sequence, find the length of the longest fibonacci-like subsequence of A.  If one does not exist, return 0.

(Recall that a subsequence is derived from another sequence A by deleting any number of elements (including none) from A, without changing the order of the remaining elements.  For example, [3, 5, 8] is a subsequence of [3, 4, 5, 6, 7, 8].)


Example 1:
```
Input: [1,2,3,4,5,6,7,8]
Output: 5
Explanation:
The longest subsequence that is fibonacci-like: [1,2,3,5,8].
```
Example 2:
```
Input: [1,3,7,11,12,14,18]
Output: 3
Explanation:
The longest subsequence that is fibonacci-like:
[1,11,12], [3,11,14] or [7,11,18].
```

### Solution

Sorted array solution:
``` go
func lenLongestFibSubseq(A []int) int {

    n := len(A)

    if n <= 0 {
        return n
    }

    T := make([][]int, n)

    for i := 0; i < n; i++ {
        T[i] = make([]int, n)

        k := 1
        if i > 0 {
            k = 2
        }

        for j := 0; j < n; j++ {
            T[i][j] = k
        }
    }  

    maxSoFar := 0

    for i := 2; i < n; i++ {  
        for j := 1; j < i; j++ {

            k, ok := binarySearch(A, 0, j, A[i] - A[j])

            for ok {

                T[i][j] = max(T[i][j], T[j][k] + 1)
                maxSoFar = max(maxSoFar, T[i][j])

                k, ok = binarySearch(A, k+1, j, A[i] - A[j])
            }

        }
    }

    return maxSoFar
}

func binarySearch(A []int, low, hi, target int) (int, bool) {

    for low < hi {
        mid := low + (hi - low) / 2
        v := A[mid]
        if target == v {
            return mid, true
        } else if target < v {
            hi = mid
        } else {
            low = mid + 1
        }
    }

    return low, false

}

func max(a, b int) int {
    if a >= b {
        return a
    } else {
        return b
    }
}
```

Unsorted array solution:
``` go
```

### Explanation
