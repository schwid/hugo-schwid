+++
date = "2020-06-09"
title = "Is Subsequence"
slug = "june 9 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a string s and a string t, check if s is subsequence of t.

A subsequence of a string is a new string which is formed from the original string by deleting some (can be none) of the characters without disturbing the relative positions of the remaining characters. (ie, "ace" is a subsequence of "abcde" while "aec" is not).

Follow up:
If there are lots of incoming S, say S1, S2, ... , Sk where k >= 1B, and you want to check one by one to see if T has its subsequence. In this scenario, how would you change your code?

Credits:
Special thanks to @pbrother for adding this problem and creating all test cases.


Example 1:
```
Input: s = "abc", t = "ahbgdc"
Output: true
```

Example 2:
```
Input: s = "axc", t = "ahbgdc"
Output: false
```

Constraints:
```
0 <= s.length <= 100
0 <= t.length <= 10^4
Both strings consists only of lowercase characters.
```

## Solution

Very simple DP solution

``` go
func isSubsequence(s string, t string) bool {
    n, m := len(s), len(t)
    dp := make([][]bool, n+1)
    dp[0] = make([]bool, m+1)
    for j := 0; j <= m; j++ {
        dp[0][j] = true
    }
    for i := 1; i <= n; i++ {
        dp[i] = make([]bool, m+1)
        for j := 1; j <= m; j++ {
            if s[i-1] == t[j-1] {
                dp[i][j] = dp[i-1][j-1]
            } else {
                dp[i][j] = dp[i][j-1]
            }
        }
    }
    return dp[n][m]
}
```

Performance of this solution is:
```
Runtime: 0 ms
Memory Usage: 2.4 MB
```

Let's do follow up. The bottleneck in 1b requests is memory. There if we decrease using memory and reuse `prev` and `next` in each request, we are fine.

``` go
func isSubsequence(s string, t string) bool {
    n, m := len(s), len(t)
    prev := make([]bool, m+1)
    next := make([]bool, m+1)
    for j := 0; j <= m; j++ {
        prev[j] = true
    }
    for i := 1; i <= n; i++ {
        next[0] = false
        for j := 1; j <= m; j++ {
            if s[i-1] == t[j-1] {
                next[j] = prev[j-1]
            } else {
                next[j] = next[j-1]
            }
        }
        prev, next = next, prev
    }
    return prev[m]
}
```
