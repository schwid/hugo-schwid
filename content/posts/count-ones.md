+++
date = "2019-04-24"
title = "Number of Digit One"
slug = "Number of Digit One"
tags = []
categories = []
+++

## Introduction

Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.

Example:
```
Input: 13
Output: 6 
Explanation: Digit 1 occurred in the following numbers: 1, 10, 11, 12, 13.
```

### Solution

Golang:
``` go
func countDigitOne(n int) int {
    cnt := 0
    a := 1 
    b := 1
    for n > 0 {
        endsOne := n % 10 == 1
        cnt += (n + 8) / 10 * a;
        if endsOne {
            cnt += b
        }
        b += n % 10 * a;
        a *= 10;
        n /= 10;
    }
    return cnt;
}
```

### Explanation

This is a mathematical solution.
