+++
date = "2019-04-20"
title = "Longest Substring Without Repeating Characters"
slug = "Longest Substring Without Repeating Characters"
tags = []
categories = []
+++

## Introduction

Given a string, find the length of the longest substring without repeating characters.

Example 1:
```
Input: "abcabcbb"
Output: 3
Explanation: The answer is "abc", with the length of 3.
```
Example 2:
```
Input: "bbbbb"
Output: 1
Explanation: The answer is "b", with the length of 1.
```
Example 3:
```
Input: "pwwkew"
Output: 3
Explanation: The answer is "wke", with the length of 3.
             Note that the answer must be a substring, "pwke" is a subsequence and not a substring.
```

### Solution

Golang:
``` go
func lengthOfLongestSubstring(s string) int {

    n := len(s)
    if n <= 1 {
        return n
    }

    indexes := make([]int, 256)
    maxSoFar := 0

    for i, j := 0, 0; i < n; i++ {

        ch := s[i]
        k := indexes[ch]

        if k-1 < j {
            maxSoFar = max(maxSoFar, i - j + 1)
        } else {
            j = k
        }

        indexes[ch] = i + 1
    }

    return maxSoFar
}

func max(a, b int) int {
    if a >= b {
        return a
    } else {
        return b
    }
}
```

### Explanation

This problem has O(n) solution with assumption that all characters are not unicode, therefore in range [0..255].
In this case we can have int array to keep last seen index of character instead of map.
For every i-th character in the string we check last seen index and if it greater or equal of j-th substring index move substring starting from the next of last seen character. On every step we check maximum substring length to return the value.
