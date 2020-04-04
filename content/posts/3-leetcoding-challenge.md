+++
date = "2020-04-04"
title = "Maximum Subarray"
slug = "Maximum Subarray"
tags = []
categories = []
+++

## Introduction

Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

Example:

Input: [-2,1,-3,4,-1,2,1,-5,4],
Output: 6
Explanation: [4,-1,2,1] has the largest sum = 6.
Follow up:
```
If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.
```

## Solution

This is an O(n) simple solution by using maxSoFar with left and right sides.

``` go
func maxSubArray(nums []int) int {
	n := len(nums)
	if n == 0 {
		return 0
	}
	left := make([]int, n+1)
	for i, val := range nums {
		left[i+1] = max(left[i] + val, 0)
	}
	maxSoFar := nums[0]
	right := 0
	for j := n-1; j >= 0; j-- {
		maxSoFar = max(maxSoFar, left[j] + nums[j] + right)
		right = max(right + nums[j], 0)
	}
	return maxSoFar
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
```
