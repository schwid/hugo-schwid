+++
date = "2020-05-12"
title = "Single Element in a Sorted Array"
slug = "may 12 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once. Find this single element that appears only once.


Example 1:

Input: [1,1,2,3,3,4,4,8,8]
Output: 2
Example 2:

Input: [3,3,7,7,10,11,11]
Output: 10


Note: Your solution should run in O(log n) time and O(1) space.

## Solution

This task is for binary logic. If all elements appear twice, that if we xor all of them, they will disappear.

``` go
func singleNonDuplicate(nums []int) int {
    x := 0
    for _, num := range nums {
        x ^= num
    }
    return x
}
```

Another way to solve this task is to use binary search.
We know that all numbers has pair, therefore for us it would be important to estimate for odd and even mid values their neighbors.

Here is the solution for O(logN)

``` go
func singleNonDuplicate(nums []int) int {
	lo, hi := 0, len(nums)
	for hi - lo >= 3 {
		mi := (hi - lo) >> 1 + lo
		if mi % 2 > 0 {
			mi--
		}
		if mi-1 >= lo && nums[mi-1] == nums[mi] {
			hi = mi-1
		} else if mi+1 < hi && nums[mi+1] == nums[mi] {
			lo = mi+2
		} else {
			return nums[mi]
		}
	}
	return nums[lo]
}
```
