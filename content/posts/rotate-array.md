+++
date = "2019-04-24"
title = "Rotate Array"
slug = "Rotate Array"
tags = []
categories = []
+++

## Introduction

Given an array, rotate the array to the right by k steps, where k is non-negative.

Example 1:
```
Input: [1,2,3,4,5,6,7] and k = 3
Output: [5,6,7,1,2,3,4]
Explanation:
rotate 1 steps to the right: [7,1,2,3,4,5,6]
rotate 2 steps to the right: [6,7,1,2,3,4,5]
rotate 3 steps to the right: [5,6,7,1,2,3,4]
```
Example 2:
```
Input: [-1,-100,3,99] and k = 2
Output: [3,99,-1,-100]
Explanation: 
rotate 1 steps to the right: [99,-1,-100,3]
rotate 2 steps to the right: [3,99,-1,-100]
```
Note:

Try to come up as many solutions as you can, there are at least 3 different ways to solve this problem.
Could you do it in-place with O(1) extra space?

### Solution

Golang:
``` go
func rotate(nums []int, k int)  {
    n := len(nums)
    k = k % n
    t := make([]int, k)
    copy(t, nums[n-k:])
    copy(nums[k:], nums[:n-k])
    copy(nums, t)
}
```

### Explanation

Memory allocation in golang so fast, so this algorithm outperform any other solutions, because `copy` command will be transformed in to a single machine instruction.
