+++
date = "2019-04-22"
title = "Single Number"
slug = "Single Number"
tags = []
categories = []
+++

## Introduction

Given a non-empty array of integers, every element appears twice except for one. Find that single one.

Note:

Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

Example 1:
```
Input: [2,2,1]
Output: 1
```
Example 2:
```
Input: [4,1,2,1,2]
Output: 4
```


### Solution

Golang:
``` go
func singleNumber(nums []int) int {

    sum := 0
    for _, n := range nums {
        sum = sum ^ n
    }

    return sum
}
```

### Explanation

If we sum all numbers by using xor operation, then only one will left, because a ^ a = 0.
