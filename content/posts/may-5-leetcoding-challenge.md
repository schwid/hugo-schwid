+++
date = "2020-05-05"
title = "First Unique Character in a String"
slug = "may 5 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a string, find the first non-repeating character in it and return it's index. If it doesn't exist, return -1.

Examples:

s = "leetcode"
return 0.

s = "loveleetcode",
return 2.
Note: You may assume the string contain only lowercase letters.

## Solution

We need to cache count of letters and filter only equal with 1. Get the first one for result.

``` go
func firstUniqChar(s string) int {
    cache := make([]int, 27)
    for _, ch := range s {
        idx := ch - 'a'
        cache[idx]++
    }
    for i, ch := range s {
        idx := ch - 'a'
        if cache[idx] == 1 {
            return i
        }
    }
    return -1
}
```
