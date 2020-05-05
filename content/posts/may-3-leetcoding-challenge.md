+++
date = "2020-05-03"
title = "Ransom Note"
slug = "may 3 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an arbitrary ransom note string and another string containing letters from all the magazines, write a function that will return true if the ransom note can be constructed from the magazines ; otherwise, it will return false.

Each letter in the magazine string can only be used once in your ransom note.

Note:
You may assume that both strings contain only lowercase letters.
```
canConstruct("a", "b") -> false
canConstruct("aa", "ab") -> false
canConstruct("aa", "aab") -> true
```

## Solution

We can construct ransom note only if we have characters in magazine. So, the simple cache can help keep count positive.

``` go
func canConstruct(ransomNote string, magazine string) bool {
    cache := make([]int, 26)
    for  _, c := range magazine {
        cache[c-'a']++
    }
    for _, c := range ransomNote {
        v := cache[c - 'a']
        v--
        cache[c - 'a'] = v
        if v < 0 {
            return false
        }
    }
    return true
}
```
