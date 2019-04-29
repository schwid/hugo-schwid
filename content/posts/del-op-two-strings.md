+++
date = "2019-04-28"
title = "Delete Operation for Two Strings"
slug = "Delete Operation for Two Strings"
tags = []
categories = []
+++

## Introduction

Given two words word1 and word2, find the minimum number of steps required to make word1 and word2 the same, where in each step you can delete one character in either string.

Example 1:
```
Input: "sea", "eat"
Output: 2
Explanation: You need one step to make "sea" to "ea" and another step to make "eat" to "ea".
```
Note:
* The length of given words won't exceed 500.
* Characters in given words can only be lower-case letters.


### Solution

Dynamic programming solution:
``` go
func minDistance(word1 string, word2 string) int {

    n := len(word1)
    m := len(word2)

    dp := make([][]int, n + 1)
    dp[0] = make([]int, m + 1)

    for i := 1; i <= n; i++ {
        dp[i] = make([]int, m + 1)
        dp[i][0] = i
    }

    for j := 1; j <= m; j++ {
        dp[0][j] = j
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {

            if word1[i-1] == word2[j-1] {
                dp[i][j] = dp[i-1][j-1]
            } else {
                dp[i][j] = min(dp[i][j-1] + 1, dp[i-1][j] + 1)
            }

        }

    }

    return dp[n][m]

}

func min(a, b int) int {
    if a <= b {
        return a
    } else {
        return b
    }
}
```

### Explanation

We have 2D Dynamic Programming table where `i` and `j` represents iterations in both words. Vertical steps mean deletion of one character from `word1`, whereas horizontal steps mean deletion of one character form `word2`. If both character equal `word1[i-1] == word2[j-1]`, we transform cost from diagonal cell `dp[i][j] = dp[i-1][j-1]`, if not we select minimum cost from vertical or horizontal case plus one (our cost of deletion) `dp[i][j] = min(dp[i][j-1] + 1, dp[i-1][j] + 1)`.
Final minimum cost would be find in `dp[n][m]`.
