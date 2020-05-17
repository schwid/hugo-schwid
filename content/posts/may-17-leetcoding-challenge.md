+++
date = "2020-05-17"
title = "Find All Anagrams in a String"
slug = "may 17 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a string s and a non-empty string p, find all the start indices of p's anagrams in s.

Strings consists of lowercase English letters only and the length of both strings s and p will not be larger than 20,100.

The order of output does not matter.

Example 1:

Input:
s: "cbaebabacd" p: "abc"

Output:
[0, 6]

Explanation:
```
The substring with start index = 0 is "cba", which is an anagram of "abc".
The substring with start index = 6 is "bac", which is an anagram of "abc".
```
Example 2:

Input:
s: "abab" p: "ab"

Output:
[0, 1, 2]

Explanation:
```
The substring with start index = 0 is "ab", which is an anagram of "ab".
The substring with start index = 1 is "ba", which is an anagram of "ab".
The substring with start index = 2 is "ab", which is an anagram of "ab".
```

## Solution

We need somehowe to build a map of occur letters in pattern, ideally by using array with fixed size 26, because of lowercase English letters.
And then, by using sliding window calculate occurency map for incoming string and compare each time with pattern one.

``` go
func findAnagrams(s string, p string) []int {
    var out []int
    ss, pp := []byte(s), []byte(p)
    n, m := len(ss), len(pp)
    if n < m || m == 0 {
        return out
    }
    var check,dp [26]int
    for _, ch := range pp {
        check[ch-'a']++
    }
    for _, ch := range ss[:m] {
        dp[ch-'a']++
    }
    if equal(check[:], dp[:], 26) {
        out = []int {0}    
    }
    for i := m; i < n; i++ {
        dp[ss[i-m]-'a']--   
        dp[ss[i]-'a']++  
        if equal(check[:], dp[:], 26) {
            out = append(out, i-m+1)  
        }
    }
    return out
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

Hard to make better:
```
Runtime: 0 ms
Memory Usage: 5.3 MB
```
