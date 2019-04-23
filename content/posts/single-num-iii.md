+++
date = "2019-04-22"
title = "Single Number III"
slug = "Single Number III"
tags = []
categories = []
+++

## Introduction

Given an array of numbers nums, in which exactly two elements appear only once and all the other elements appear exactly twice. Find the two elements that appear only once.

Example:
```
Input:  [1,2,1,3,2,5]
Output: [3,5]
```
Note:

The order of the result is not important. So in the above example, [5, 3] is also correct.
Your algorithm should run in linear runtime complexity. Could you implement it using only constant space complexity?

### Solution

Simple solution:
``` go
seen := make(map[int]int)

for _, n := range nums {
    seen[n]++
}

var r []int

for k, v := range seen {
    if v == 1 {
        r = append(r, k)
    }
}

return r
```

Faster solution:
``` go
func singleNumber(nums []int) []int {

    // X == a ^ b
    X := 0
    for _, n := range nums {
        X ^= n
    }

    // M == min diff bit between a and b
    M := X & -X

    ab := []int {0 ,0 }
    for _, n := range nums {
        if n & M == 0 {
            ab[0] ^= n
        } else {
            ab[1] ^= n
        }
    }

    return ab
}
```

### Explanation

All we need is to track elements that we seen and find all of them that has counter equal 1.
Another way is to create mutual mask of a^b and split stream of integers by it.
