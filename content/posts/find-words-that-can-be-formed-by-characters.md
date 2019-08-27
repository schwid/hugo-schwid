+++
date = "2019-08-27"
title = "Find Words That Can Be Formed by Characters"
slug = "Find Words That Can Be Formed by Characters"
tags = []
categories = []
+++

## Introduction

You are given an array of strings words and a string chars.

A string is good if it can be formed by characters from chars (each character can only be used once).

Return the sum of lengths of all good strings in words.

 

Example 1:
```
Input: words = ["cat","bt","hat","tree"], chars = "atach"
Output: 6
Explanation: 
The strings that can be formed are "cat" and "hat" so the answer is 3 + 3 = 6.
```
Example 2:
```
Input: words = ["hello","world","leetcode"], chars = "welldonehoneyr"
Output: 10
Explanation: 
The strings that can be formed are "hello" and "world" so the answer is 5 + 5 = 10.
``` 

Note:
```
1 <= words.length <= 1000
1 <= words[i].length, chars.length <= 100
All strings contain lowercase English letters only.
```

### Solution

We already know that characters could be only in english alphabet. Therefore, we can use approach of caching counters in fixed array.

``` go
func countCharacters(words []string, chars string) int {
    a := make([]int, 27)
    for _, ch := range chars {
        index := int(ch - 'a')
        a[index]++
    }
    cnt := 0
    for _, w := range words {
        if fit(w, copyOf(a)) {
            cnt += len(w)
        }
    }
    return cnt
}

func fit(w string, b []int) bool {
    for _, ch := range w {
        index := int(ch - 'a')
        if b[index] == 0 {
            return false
        }
        b[index]--
    }
    return true
}

func copyOf(src []int) []int {
    dst := make([]int, len(src))
    copy(dst, src)
    return dst
}
```

The solution with heap memory gives 16ms and could be considered as good enough.



