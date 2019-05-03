+++
date = "2019-05-02"
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
```
Input: nums = [4,5,6,7,0,1,2], target = 0
Output: 4
```

Example 2:
```
Input: nums = [4,5,6,7,0,1,2], target = 3
Output: -1
```

### Solution

Golang:
``` go
func search(nums []int, target int) int {

    lo, hi := 0, len(nums)
    
    for lo < hi {
        
        mi := lo + (hi - lo) / 2
        
        if nums[mi] == target {
            return mi
        } else if nums[lo] < nums[mi] {
            
            if nums[lo] <= target && target < nums[mi] {
                return binarySearch(nums[lo:mi], lo, target)
            } else {
                lo = mi + 1
            }
            
        } else {
            
            if nums[mi] <= target && target <= nums[hi-1] {
                return binarySearch(nums[mi+1:hi], mi+1, target)
            } else {
                hi = mi
            }
            
        }
        
    }
    
    return -1
}

func binarySearch(nums []int, offset int, target int) int {
        
    lo, hi := 0, len(nums)
    
    for lo < hi {
        
        mi := lo + (hi - lo) / 2
        
        if nums[mi] == target {
            return mi + offset
        } else if nums[mi] < target {
            lo = mi + 1
        } else {
            hi = mi
        }
        
    }
    
    return -1
    
}
```

### Explanation

This problem could be transformed to binary-search sub-problem or reduced to the same search problem, total complexity is `O(log(n))`.

In each iteration we calculate `mi` middle value between `lo` low and `hi` high in interval `[lo, hi)`. By splitting array in to two sub-arrays we end-up with two situations: one sub-array is sorted, another one is the half-problem of existing problem. We need to check what part of sub-array is sorted by comparing 'nums[lo] and nums[mi]', for sorted left part they will complain with condition 'nums[lo] < nums[mi]'. If `target` value is between `nums[lo]` and `nums[mi]` then this left sub-array is a binary search sub-problem, overwise we select another sub-array as sub-problem of original search, and so on.

