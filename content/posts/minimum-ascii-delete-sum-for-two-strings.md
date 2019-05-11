+++
date = "2019-05-11"
title = "Minimum ASCII Delete Sum for Two Strings"
slug = "Minimum ASCII Delete Sum for Two Strings"
tags = []
categories = []
+++

## Introduction

Given two strings s1, s2, find the lowest ASCII sum of deleted characters to make two strings equal.

Example 1:
```
Input: s1 = "sea", s2 = "eat"
Output: 231
Explanation: Deleting "s" from "sea" adds the ASCII value of "s" (115) to the sum.
Deleting "t" from "eat" adds 116 to the sum.
At the end, both strings are equal, and 115 + 116 = 231 is the minimum sum possible to achieve this.
```

Example 2:
```
Input: s1 = "delete", s2 = "leet"
Output: 403
Explanation: Deleting "dee" from "delete" to turn the string into "let",
adds 100[d]+101[e]+101[e] to the sum.  Deleting "e" from "leet" adds 101[e] to the sum.
At the end, both strings are equal to "let", and the answer is 100+101+101+101 = 403.
If instead we turned both strings into "lee" or "eet", we would get answers of 433 or 417, which are higher.
```

Note:
```
0 < s1.length, s2.length <= 1000.
All elements of each string will have an ASCII value in [97, 122].
```

### Solution

Dynamic programming approach:
``` go
func minimumDeleteSum(s1 string, s2 string) int {

    n := len(s1)
    m := len(s2)

    dp := make([][]int, n+1)
    dp[0] = make([]int, m+1)

    for i := 1; i <= n; i++ {
        dp[i] = make([]int, m+1)
        dp[i][0] = dp[i-1][0] + int(s1[i-1])
    }

    for j := 1; j <= m; j++ {
        dp[0][j] = dp[0][j-1] + int(s2[j-1])
    }

    for i := 1; i <= n; i++ {

        for j := 1; j <= m; j++ {

            if s1[i-1] != s2[j-1] {
                dp[i][j] = min(dp[i-1][j] + int(s1[i-1]), dp[i][j-1] + int(s2[j-1]))
            } else {
                dp[i][j] = dp[i-1][j-1]
            }            
        }

    }

    return dp[n][m]

}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}
```

### Explanation

Lets find a sub-problem of this problem.
The sub-problem is to find a minimum ASCII sum of deleted characters for substrings `s1[:i]` and `s2[:j]`.
We have 2 dimensional space for all possible combinations of DP solutions `n+1 * m+1`, whereas our return value would be in the cell `dp[n][m]`.
Lets initialize dp matrix by `i` with increasing sum of deleted elements `dp[i-1][0] + int(s1[i-1])` from string `s1` and initialize by `j` with increasing sum of deleted elements `dp[0][j-1] + int(s2[j-1])` from string `s2`.
After that we have a simple logic inside two for-each loops, where we check if elements are equal `s1[i-1] == s2[j-1]` and if not select the cheapest way to delete element, from string `s1` that cost would be `dp[i-1][j] + int(s1[i-1])` or from string `s2` that cost would be `dp[i][j-1] + int(s2[j-1])`.
