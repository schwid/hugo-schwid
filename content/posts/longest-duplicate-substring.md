+++
date = "2019-05-16"
title = "Longest Duplicate Substring"
slug = "Longest Duplicate Substring"
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


### Solution

Golang:
``` go
func longestDupSubstring(S string) string {

    n := len(S)

    lo := 0
    hi := n
    sub := ""

    for lo < hi {
        mi := lo + (hi - lo) / 2
        index := findDupSubstring(S, n, mi)
        if index != -1 {
            lo = mi + 1
            sub = S[index:index + mi]
        } else if hi != mi {
            hi = mi
        } else {
            break
        }
    }

    return sub
}

func findDupSubstring(s string, n, m int) int {

    q := 6 * (1 << 20) + 1
    b := 31

    power := 1
    for i := 1; i < m; i++ {
        power = (power * b) % q
    }

    seen := make(map[int][]int)

    hash := 0
    for i := 0; i < m; i++ {
        hash = ( (hash * b) % q + int(s[i]) ) % q
    }

    seen[hash] = append(seen[hash], 0)

    for i := m; i < n; i++ {
        hash = (hash - (power * int(s[i-m])) % q + q) % q
        hash = ( (hash * b) % q + int(s[i]) ) % q

        if arr, ok := seen[hash]; ok {
            for _, index := range arr {
                if s[index:index+m] == s[i+1-m:i+1] {
                        return index
                 }                
            }
        }

        seen[hash] = append(seen[hash], i+1-m)
    }  
    return -1
}
```

### Explanation

Lets transform this problem to "Find duplicate substring with known length" by creating a binary search around it.
The sub-problem we will solve by using `O(n)` hash-based algorithm, so the total complexity would be `O(n*log(n))`.
