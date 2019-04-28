+++
date = "2019-04-24"
title = "Factorial Trailing Zeroes"
slug = "Factorial Trailing Zeroes"
tags = []
categories = []
+++

## Introduction

Given an integer n, return the number of trailing zeroes in n!.

Example 1:
```
Input: 3
Output: 0
Explanation: 3! = 6, no trailing zero.
```
Example 2:
```
Input: 5
Output: 1
Explanation: 5! = 120, one trailing zero.
Note: Your solution should be in logarithmic time complexity.
```

### Solution

Golang:
``` go
func trailingZeroes(n int) int {
    zeros := 0
    for i := 5; n / i >= 1; i *= 5 { 
        zeros += n / i
    }
    return zeros
}
```

### Explanation

We need to calculate divisions on 5, 5^2, 5^3, and so on, because we 0 comes from 2*5, and we have a lot of 2s.
