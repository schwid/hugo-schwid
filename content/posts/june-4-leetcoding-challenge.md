+++
date = "2020-06-04"
title = "Reverse String"
slug = "june 4 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Write a function that reverses a string. The input string is given as an array of characters char[].

Do not allocate extra space for another array, you must do this by modifying the input array in-place with O(1) extra memory.

You may assume all the characters consist of printable ascii characters.


Example 1:
```
Input: ["h","e","l","l","o"]
Output: ["o","l","l","e","h"]
```

Example 2:
```
Input: ["H","a","n","n","a","h"]
Output: ["h","a","n","n","a","H"]
```

## Solution

Very simple and standard solution could be like this:

``` go
func reverseString(s []byte)  {
    n := len(s)
    for i, j := 0, n-1; i < j; i, j = i+1, j-1 {
        s[i], s[j] = s[j], s[i]
    }
}
```

Performance of this solution is:
```
Runtime: 40 ms
Memory Usage: 6.3 MB
```
