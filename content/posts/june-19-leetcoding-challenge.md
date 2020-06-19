+++
date = "2020-06-19"
title = "Longest Duplicate Substring"
slug = "june 19 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a string S, consider all duplicated substrings: (contiguous) substrings of S that occur 2 or more times.  (The occurrences may overlap.)

Return any duplicated substring that has the longest possible length.  (If S does not have a duplicated substring, the answer is "".)


Example 1:
```
Input: "banana"
Output: "ana"
```

Example 2:
```
Input: "abcd"
Output: ""
```

Note:
```
2 <= S.length <= 10^5
S consists of lowercase English letters.
```

## Solution

Let's use binary search

``` go
func longestDupSubstring(S string) string {
    maxSub := ""
    lo, hi := 0, len(S)
    for lo < hi {
        mi := (hi - lo) / 2 + lo
        sub := searchDubSubstring(S, mi)
        if len(sub) == 0 {
            hi = mi
        } else {
            maxSub = sub
            lo = mi+1
        }
    }
    return maxSub
}

func searchDubSubstring(S string, m int) string {
    n := len(S)
    d := 26
    visited := make(map[int]int)

    scale := 1
    h := 0
    for i := 0; i < m; i++ {
        h = h * d + int(S[i])
        if i > 0 {
            scale *= d
        }
    }
    visited[h] = m-1

    for i := m; i < n; i++ {
        h = (h - scale * int(S[i-m])) * d + int(S[i])
        if j, ok := visited[h]; ok {
            sub := S[i-m+1:i+1]
            if sub == S[j-m+1:j+1] {
                return sub
            }
        }
        visited[h] = i
    }

    return ""
}
```

Performance of this solution is:
```
Runtime: 232 ms
Memory Usage: 12.6 MB
```
