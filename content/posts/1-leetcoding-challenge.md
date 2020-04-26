+++
date = "2020-04-01"
title = "Single Number"
slug = "1 leetcoding challenge"
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

## Solution

``` go
func singleNumber(nums []int) int {
    xor := 0
    for _, val := range nums {
        xor ^= val     
    }
    return xor
}
```
