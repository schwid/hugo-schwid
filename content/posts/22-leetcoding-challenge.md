+++
date = "2020-04-22"
title = "Subarray Sum Equals K"
slug = "22 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an array of integers and an integer k, you need to find the total number of continuous subarrays whose sum equals to k.

Example 1:
Input:nums = [1,1,1], k = 2
Output: 2
Note:
```
The length of the array is in range [1, 20,000].
The range of numbers in the array is [-1000, 1000] and the range of the integer k is [-1e7, 1e7].
```


## Solution

Let's store in cache number of visited sums, therefore on each step we can quick look up amount that we want to add in order to match k.
One corner case situation when `k` equals `nums[i]` we record as `cache[0] = 1`.


``` go
func subarraySum(nums []int, k int) int {
	cache := make(map[int]int)
	cache[0] = 1
	sum := 0
	cnt := 0
	for _, val := range nums {
		sum += val
		if visited, ok := cache[sum - k]; ok {
			cnt += visited
		}
		cache[sum]++
	}
	return cnt
}
```
