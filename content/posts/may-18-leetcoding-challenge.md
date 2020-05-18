+++
date = "2020-05-18"
title = "Permutation in String"
slug = "may 18 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given two strings s1 and s2, write a function to return true if s2 contains the permutation of s1. In other words, one of the first string's permutations is the substring of the second string.



Example 1:
```
Input: s1 = "ab" s2 = "eidbaooo"
Output: True
Explanation: s2 contains one permutation of s1 ("ba").
```

Example 2:
```
Input:s1= "ab" s2 = "eidboaoo"
Output: False
```

Note:
```
The input strings only contain lower case letters.
The length of both given strings is in range [1, 10,000].
```

## Solution

This task is the same as previous one, except return type, we need to return bool not list of indexes. Considering is more simple.

``` go
func checkInclusion(s1 string, s2 string) bool {
    ss, pp := []byte(s2), []byte(s1)
    n, m := len(ss), len(pp)
    if n < m {
        return false
    }
    if m == 0 {
        return true
    }
    var check,dp [26]int
    for _, ch := range pp {
        check[ch-'a']++
    }
    for _, ch := range ss[:m] {
        dp[ch-'a']++
    }
    if equal(check[:], dp[:], 26) {
        return true    
    }
    for i := m; i < n; i++ {
        dp[ss[i-m]-'a']--   
        dp[ss[i]-'a']++  
        if equal(check[:], dp[:], 26) {
            return true
        }
    }
    return false
}

func equal(a, b []int, n int) bool {
    for i := 0; i < n; i++ {
        if a[i] != b[i] {
            return false
        }
    }
    return true
}
```

## Performance

Good performance:
```
Runtime: 0 ms
Memory Usage: 2.9 MB
```
