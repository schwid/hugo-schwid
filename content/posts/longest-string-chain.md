+++
date = "2019-05-20"
title = "Longest String Chain"
slug = "Longest String Chain"
tags = []
categories = []
+++

## Introduction

Given a list of words, each word consists of English lowercase letters.

Let's say word1 is a predecessor of word2 if and only if we can add exactly one letter anywhere in word1 to make it equal to word2.  For example, "abc" is a predecessor of "abac".

A word chain is a sequence of words [word_1, word_2, ..., word_k] with k >= 1, where word_1 is a predecessor of word_2, word_2 is a predecessor of word_3, and so on.

Return the longest possible length of a word chain with words chosen from the given list of words.

 

Example 1:
```
Input: ["a","b","ba","bca","bda","bdca"]
Output: 4
Explanation: one of the longest word chain is "a","ba","bda","bdca".
``` 

Note:
```
1 <= words.length <= 1000
1 <= words[i].length <= 16
words[i] only consists of English lowercase letters.
```

### Solution

Dynamic programming solution:
``` go
func longestStrChain(words []string) int {
    
    sort.SliceStable(words, func(i, j int) bool {
        return len(words[i]) < len(words[j])
    })    
        
    n := len(words)
    dp := make([]int, n)
    
    for i := 0; i < n; i++ {
        dp[i] = 1
    }
    
    maxSoFar := 1
    for i := 0; i < n; i++ {
        for j := 0; j < i; j++ {
            
            if isPredecessor(words[j], words[i]) {
                dp[i] = max(dp[i],  dp[j] + 1)
                maxSoFar = max(maxSoFar, dp[i])
            }
            
        }
    }
        
    return maxSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}

func isPredecessor(prev, curr string) bool {
    
    j, m := 0, len(prev)
        
    n := len(curr)
    if m + 1 != n {
        return false
    }
    
    missing := 0
    for i := 0; i < n; i++ {

        if j < m && prev[j] == curr[i] {
            j++
        } else {
            missing++
        }
        
    }

    return missing == 1 && j == m
}
```

### Explanation

Lets transform this task in to the "Find the longest subsequence" and define a special function `isPredecessor` for this purpose.
We would need to sort words by length to have a sequence.
