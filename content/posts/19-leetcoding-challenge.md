+++
date = "2020-04-19"
title = "Search in Rotated Sorted Array"
slug = "Search in Rotated Sorted Array"
tags = []
categories = []
+++

## Introduction

Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.

(i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).

You are given a target value to search. If found in the array return its index, otherwise return -1.

You may assume no duplicate exists in the array.

Your algorithm's runtime complexity must be in the order of O(log n).

Example 1:

Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4
Example 2:

Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1

## Solution

The quick solution would be to separate logic for classical binary search and rotated array detection.
All we need is to detect if target is in range for binary search sequences, between [lo, mi] and (mi, hi].
One corner case is when nums[lo] == nums[mi].


``` go
func search(nums []int, target int) int {
	lo, hi := 0, len(nums)-1
	for lo <= hi {
		mi := (hi + lo) / 2
		if nums[mi] == target {
			return mi
		} else if nums[lo] == nums[mi] {
			lo = mi+1
		} else if nums[lo] < nums[mi] {
			if nums[lo] <= target && target < nums[mi] {
				return binarySearch(nums, lo, mi, target)
			}
			lo = mi+1
		} else {
			if nums[mi] < target && target <= nums[hi] {
				return binarySearch(nums, mi, hi, target)
			}
			hi = mi-1
		}
	}
	return -1
}

func binarySearch(nums []int, lo, hi int, target int) int {
	for lo <= hi {
		mi := (hi + lo) / 2
		if nums[mi] == target {
			return mi
		} else if target < nums[mi] {
			hi = mi-1
		} else {
			lo = mi+1
		}
	}
	return -1
}
```

We also can combine the binary search and rotated search in one loop:

``` go
func search(nums []int, target int) int {
	lo, hi := 0, len(nums)-1
	for lo <= hi {
		mi := (hi + lo) / 2
		if nums[mi] == target {
			return mi
		} else if nums[lo] == nums[mi] {
			lo = mi+1
		} else if nums[lo] < nums[mi] {
			if nums[lo] <= target && target < nums[mi] {
				hi = mi-1
      } else {
			  lo = mi+1
      }
		} else {
			if nums[mi] < target && target <= nums[hi] {
				lo = mi+1
      } else {
			  hi = mi-1
      }
		}
	}
	return -1
}
```

This is the fastest solution that gives 0ms
