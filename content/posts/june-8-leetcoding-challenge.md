+++
date = "2020-06-08"
title = "Power of Two"
slug = "june 8 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an integer, write a function to determine if it is a power of two.

Example 1:
```
Input: 1
Output: true
Explanation: 20 = 1
```

Example 2:
```
Input: 16
Output: true
Explanation: 24 = 16
```

Example 3:
```
Input: 218
Output: false
```

## Solution

Very simple solution

``` go
func isPowerOfTwo(n int) bool {
    for i := n; i > 0; i >>= 1 {
        if (i & 1) > 0 {
            if i == 1 {
                return true
            } else if i > 1 {
                return false
            }
        }
    }
    return false
}
```

Performance of this solution is:
```
Runtime: 4 ms
Memory Usage: 2.2 MB
```
