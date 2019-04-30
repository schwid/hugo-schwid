+++
date = "2019-04-29"
title = "Longest Arithmetic Sequence"
slug = "Longest Arithmetic Sequence"
tags = []
categories = []
+++

## Introduction

Given an array A of integers, return the length of the longest arithmetic subsequence in A.

Recall that a subsequence of A is a list A[i_1], A[i_2], ..., A[i_k] with 0 <= i_1 < i_2 < ... < i_k <= A.length - 1, and that a sequence B is arithmetic if B[i+1] - B[i] are all the same value (for 0 <= i < B.length - 1).



Example 1:
```
Input: [3,6,9,12]
Output: 4
Explanation:
The whole array is an arithmetic sequence with steps of length = 3.
```
Example 2:
```
Input: [9,4,7,2,10]
Output: 3
Explanation:
The longest arithmetic subsequence is [4,7,10].
```
Example 3:
```
Input: [20,1,15,3,10,5,8]
Output: 4
Explanation:
The longest arithmetic subsequence is [20,15,10,5].
```

Note:
```
2 <= A.length <= 2000
0 <= A[i] <= 10000
```

### Solution

Dynamic programming solution:
``` go
func longestArithSeqLength(A []int) int {

    n := len(A)

    if n <= 2 {
        return 2
    }

    dp := make(map[int][]int)
    maxSoFar := 0

    for i := 1; i <= n; i++ {
        for j := 1; j < i; j++ {

            diff := A[i-1] - A[j-1]
            var d []int
            var ok bool
            d, ok = dp[diff]
            if !ok {
                d = makeArray(n)
                dp[diff] = d
            }

            d[i] = max(d[i], d[j] + 1)
            maxSoFar = max(maxSoFar, d[i])

        }

    }

    return maxSoFar   

}

func makeArray(n int) []int {
    dp := make([]int, n+1)
    for i := 0; i <= n; i++ {
        dp[i] = 1
    }
    return dp
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

Lets modify well known problem of longest increasing subsequence and store DP arrays in the map, where the key would be a difference.
