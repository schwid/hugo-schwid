+++
date = "2019-04-23"
title = "Find the Duplicate Number"
slug = "Find the Duplicate Number"
tags = []
categories = []
+++

## Introduction

Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that at least one duplicate number must exist. Assume that there is only one duplicate number, find the duplicate one.

Example 1:
```
Input: [1,3,4,2,2]
Output: 2
```
Example 2:
```
Input: [3,1,3,4,2]
Output: 3
```
Note:

* You must not modify the array (assume the array is read only).
* You must use only constant, O(1) extra space.
* Your runtime complexity should be less than O(n2).
* There is only one duplicate number in the array, but it could be repeated more than once.

### Solution

Simple Solution:
``` go
func findDuplicate(nums []int) int {

    n := len(nums)
    seen := make([]bool, n+1)

    for _, n := range nums {

        if ok := seen[n]; ok {
          return n
        }

        seen[n] = true
    }

    return -1
}
```

Cycle Detection Solution:
``` go
func findDuplicate(nums []int) int {

    n := len(nums)

    if n <= 1 {
        return -1
    }

    for i, j := nums[0], nums[nums[0]];; i, j = nums[i], nums[nums[j]] {
        if i == j {
            meet := i
            if meet == 0 {
               return 0
            }
           for i, j := nums[meet], nums[0];; i, j = nums[i], nums[j] {
               if i == j {
                   return i
               }
           }             
        }
    }

    return -1
}
```

### Explanation

Simple solution based on fact that numbers are in range [1..n], that gives ability to build lookup array `seen`.
The disadvantage of this approach is memory consumption.

Another way is to solve the problem by transforming this task to [Linked List In Cycle](/posts/linked-list-cycle-ii/), where `i` is the node reference, and the `nums[i]` is the next node index.
