+++
date = "2020-05-31"
title = "Edit Distance"
slug = "may 30 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given two words word1 and word2, find the minimum number of operations required to convert word1 to word2.

You have the following 3 operations permitted on a word:

```
Insert a character
Delete a character
Replace a character
```

Example 1:

Input: word1 = "horse", word2 = "ros"
Output: 3

Explanation:
```
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')
```

Example 2:

Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation:
```
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')
```

## Solution

Let's use DP with mutations count in cell.

``` go
func minDistance(word1 string, word2 string) int {
    n, m := len(word1), len(word2)
    dp := make([][]int, n+1)
    dp[0] = make([]int, m+1)
    for j := 1; j <= m; j++ {
        dp[0][j] = j
    }
    for i := 1; i <= n; i++ {
        dp[i] = make([]int, m+1)
        dp[i][0] = i
        for j := 1; j <= m; j++ {
            cost := 0
            if word1[i-1] != word2[j-1] {
                cost = 1
            }
            dp[i][j] = min(dp[i-1][j] + 1, dp[i][j-1] + 1,  dp[i-1][j-1] + cost)
        }
    }
    return dp[n][m]
}

func min(a, b, c int) int {
	if a > b {
		a = b
	}
	if a > c {
		a = c
	}
	return a
}
```

Performance of this solution is:
```
Runtime: 4 ms
Memory Usage: 5.7 MB
```
