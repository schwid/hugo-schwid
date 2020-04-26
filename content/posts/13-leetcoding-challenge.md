+++
date = "2020-04-13"
title = "Contiguous Array"
slug = "13 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a binary array, find the maximum length of a contiguous subarray with equal number of 0 and 1.

Example 1:
Input: [0,1]
Output: 2

Explanation: [0, 1] is the longest contiguous subarray with equal number of 0 and 1.
Example 2:
Input: [0,1,0]
Output: 2

Explanation: [0, 1] (or [1, 0]) is a longest contiguous subarray with equal number of 0 and 1.
Note: The length of the given binary array will not exceed 50,000.

## Solution

On every step we observe point with accumulated number of zeros and ones. We are interested in difference of them and first occurrence.
Corner case is the substring starting from the first 0-th position, therefore we need to store `cache[0]=-1` at beginning.
After that we can lookup the opposite difference of zeros and ones to make them equal in subsequence. Maximum length would be a solution.


``` go
func findMaxLength(nums []int) int {
	n := len(nums)
	if n <= 1 {
		return 0
	}
	cache := make(map[int]int)
	cache[0] = -1

	maxSoFar := 0
	ones := 0
	for i, num := range nums {
		ones += num
		zeros := i - ones + 1
		diff := zeros - ones
		if _, ok := cache[diff]; !ok {
			cache[diff] = i
		}
		opposite := ones - zeros
		if j, ok := cache[-opposite]; ok {
			maxSoFar = max(maxSoFar, i - j)
		}
	}

	return maxSoFar
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}
```
