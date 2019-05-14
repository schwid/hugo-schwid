+++
date = "2019-04-28"
title = "Edit Distance"
slug = "Edit Distance"
tags = []
categories = []
+++

## Introduction

Given two words word1 and word2, find the minimum number of operations required to convert word1 to word2.

You have the following 3 operations permitted on a word:

Insert a character
Delete a character
Replace a character

Example 1:
```
Input: word1 = "horse", word2 = "ros"
Output: 3
Explanation:
horse -> rorse (replace 'h' with 'r')
rorse -> rose (remove 'r')
rose -> ros (remove 'e')
```
Example 2:
```
Input: word1 = "intention", word2 = "execution"
Output: 5
Explanation:
intention -> inention (remove 't')
inention -> enention (replace 'i' with 'e')
enention -> exention (replace 'n' with 'x')
exention -> exection (replace 'n' with 'c')
exection -> execution (insert 'u')
```

### Solution

Dynamic Programming solution:
``` go
func minDistance(word1 string, word2 string) int {

    cost_deletion, cost_insertion, cost_substitution := 1, 1, 1

    n := len(word1)
    m := len(word2)

    dp := make([][]int, n+1)
    dp[0] = make([]int, m+1)

    for i := 1; i <= n; i++ {
        dp[i] = make([]int, m+1)
        dp[i][0] = i * cost_deletion
    }

    for j := 1; j <= m; j++ {
        dp[0][j] = j * cost_insertion
    }    

    for i := 1; i <= n; i++ {
        for j := 1; j <= m; j++ {
            replace_cost := 0
            if word1[i-1] != word2[j-1] {
                replace_cost = cost_substitution
            }
            dp[i][j] = min(dp[i-1][j] + cost_deletion, dp[i][j-1] + cost_insertion, dp[i-1][j-1] + replace_cost)
        }
    }

    return dp[n][m]
}

func min(arr ...int) int {
    mi := arr[0]
    for _, v := range arr[1:] {
        if mi > v {
            mi = v
        }
    }
    return mi
}
```

Python version
``` python
def edit_distance(s1, s2):
    n, m = len(s1), len(s2)
    dp = [None] * (n+1)
    dp[0] = [i for i in range(m+1)]
    for i in range(1, n+1):
        dp[i] = [0 for _ in range(m+1)]
        dp[i][0] = i     
    for i in range(1, n+1):
        for j in range(1, m+1):
            cost = 0
            if s1[i-1] != s2[j-1]:
                cost = 1
            dp[i][j] = min(dp[i-1][j-1] + cost, dp[i-1][j] + 1, dp[i][j-1] + 1)           
    return dp[n][m]
```

### Explanation

Lets build dynamic programming 2D matrix with the size `n+1, m+1`
Suppose our second word is empty, therefore in order to get empty word we need to delete all characters one-by-one from the first one. To encode this we need to setup distance for each `dp[i][0]` where `i` from `1` to `n` equal `i * cost_deletion`.
Similar way we need to do in case if first word is empty and second is non empty, for each `dp[0][j]` where `j` from `1` to `m` setup distance `j * cost_insertion`
In each cell we need to check is characters are the same, if so, the replacement cost is `0`, otherwise `cost_substitution`.
By selecting the `min` case each time we solve the task.
