+++
date = "2020-04-04"
title = "Move Zeroes"
slug = "4 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an array nums, write a function to move all 0's to the end of it while maintaining the relative order of the non-zero elements.

Example:
```
Input: [0,1,0,3,12]
Output: [1,3,12,0,0]
```
Note:
```
You must do this in-place without making a copy of the array.
Minimize the total number of operations.
```

## Solution

``` go
func moveZeroes(nums []int)  {
	i, j := 0, 0
	n := len(nums)
	for i < n {
		if nums[i] != 0 {
			nums[j] = nums[i]
			j++
		}
		i++
	}
	for j < n {
		nums[j] = 0
		j++
	}
}
```
