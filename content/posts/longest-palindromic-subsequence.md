+++
date = "2020-06-04"
title = "Longest Palindromic Subsequence"
slug = "516. Longest Palindromic Subsequence"
tags = []
categories = []
+++

## Introduction

Given a string s, find the longest palindromic subsequence's length in s. You may assume that the maximum length of s is 1000.

Example 1:
Input:

"bbbab"
Output:
4
One possible longest palindromic subsequence is "bbbb".
Example 2:
Input:

"cbbd"
Output:
2
One possible longest palindromic subsequence is "bb".

### Solution

With dynamic programming this problem has this elegant solution


``` go
func longestPalindromeSubseq(s string) int {
    n := len(s)
    if n <= 1 {
        return n
    }
    dp := make([][]int, n+1)
    for i := 0; i <= n; i++ {
        dp[i] = make([]int, n+1)
    }

    for i := n-1; i >=0; i-- {
        for j := i; j < n; j++ {
            if i == j {
               dp[i][j] = 1
            } else if s[i] == s[j] {
                dp[i][j] = dp[i+1][j-1] + 2
            } else {
                dp[i][j] = max(dp[i][j-1], dp[i+1][j])
            }
        }
    }

    return dp[0][n-1]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```


Performance:
```
Runtime: 28 ms, faster than 91.49% of Go online submissions for Longest Palindromic Subsequence.
Memory Usage: 12.7 MB, less than 80.85% of Go online submissions for Longest Palindromic Subsequence.
```
