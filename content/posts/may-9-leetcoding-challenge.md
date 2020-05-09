+++
date = "2020-05-08"
title = "Valid Perfect Square"
slug = "may 9 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a positive integer num, write a function which returns True if num is a perfect square else False.

Note: Do not use any built-in library function such as sqrt.

Example 1:
```
Input: 16
Output: true
```

Example 2:
```
Input: 14
Output: false
```

## Solution

Let's use the binary search to find the solution.

``` go
func isPerfectSquare(num int) bool {
    lo, hi := 1, num
    for lo < hi {
        mi := (hi - lo) >> 1 + lo
        val := mi * mi
        if val == num {
            return true
        } else if val > num {
            hi = mi
        } else {
            lo = mi + 1
        }
    }
    return lo * lo == num
}
```
