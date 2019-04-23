+++
date = "2019-04-22"
title = "Single Number II"
slug = "Single Number II"
tags = []
categories = []
+++

## Introduction

Given a non-empty array of integers, every element appears three times except for one, which appears exactly once. Find that single one.

Note:

Your algorithm should have a linear runtime complexity. Could you implement it without using extra memory?

Example 1:
```
Input: [2,2,3,2]
Output: 3
```
Example 2:
```
Input: [0,1,0,1,0,1,99]
Output: 99
```

### Solution

Simple solution:
``` go
func singleNumber(nums []int) int {

    seen := make(map[int]int)

    for _, n := range nums {
        seen[n]++
    }

    for k, v := range seen {
        if v == 1 {
            return k
        }
    }

    return 0

}
```

### Explanation

All we need is to track elements that we seen and find one that has counter equal 1.
