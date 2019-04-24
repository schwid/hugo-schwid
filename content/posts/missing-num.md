+++
date = "2019-04-23"
title = "Missing Number"
slug = "Missing Number"
tags = []
categories = []
+++

## Introduction

Given an array containing n distinct numbers taken from 0, 1, 2, ..., n, find the one that is missing from the array.

Example 1:
```
Input: [3,0,1]
Output: 2
```
Example 2:
```
Input: [9,6,4,2,3,5,7,0,1]
Output: 8
```

Note:
* Your algorithm should run in linear runtime complexity. Could you implement it using only constant extra space complexity?


### Solution

One-loop solution:
``` go
func missingNumber(nums []int) int {
    n := len(nums)
    sum := 0
    for _, n := range nums {
        sum += n
    }
    exp := n * (n + 1) / 2
    return exp - sum
}
```

### Explanation

Simple algebra formula `n * (n + 1) / 2` gives `sum` of sequence.
All we need is to subtract actual sum of numbers from it.
