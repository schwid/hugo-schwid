+++
date = "2020-06-22"
title = "Single Number II"
slug = "june 22 leetcoding challenge"
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

## Solution

Very simple solution would be to cache all counters.

``` go
func singleNumber(nums []int) int {
    cache := make(map[int]int)
    for _, num := range nums {
        cache[num]++
    }
    for k, v := range cache {
        if v == 1 {
            return k
        }
    }
    return -1
}
```

Performance of this solution is:
```
Runtime: 4 ms
Memory Usage: 4.4 MB
```

But let's solve it differently, we already know that all numbers have 3 occurrences, therefore if we summarize distinct numbers and multiply them by 3, we can have
ideal sum, and we also can have real sum.

``` go
func singleNumber(nums []int) int {
    visited := make(map[int]bool)
    realSum := 0
    for _, num := range nums {
        realSum += num
        visited[num] = true
    }
    idealSum := 0
    for num := range visited {
        idealSum += 3 * num
    }
    return (idealSum - realSum) / 2
}
```

Performance of this solution is:
```
Runtime: 4 ms
Memory Usage: 4.1 MB
```
