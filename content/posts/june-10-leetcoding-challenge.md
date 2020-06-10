+++
date = "2020-06-10"
title = "Search Insert Position"
slug = "june 10 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a sorted array and a target value, return the index if the target is found. If not, return the index where it would be if it were inserted in order.

You may assume no duplicates in the array.

Example 1:
```
Input: [1,3,5,6], 5
Output: 2
```

Example 2:
```
Input: [1,3,5,6], 2
Output: 1
```

Example 3:
```
Input: [1,3,5,6], 7
Output: 4
```

Example 4:
```
Input: [1,3,5,6], 0
Output: 0
```

## Solution

This is reference binary search problem and solution.

``` go
func searchInsert(nums []int, target int) int {
    lo, hi := 0, len(nums)
    for lo < hi {
        mi := (hi - lo)/2 + lo
        val := nums[mi]
        if val == target {
            return mi
        } else if val > target {
            hi = mi
        } else {
            lo = mi+1
        }
    }
    return lo
}
```

Performance of this solution is:
```
Runtime: 4 ms
Memory Usage: 3.1 MB
```
