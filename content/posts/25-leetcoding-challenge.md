+++
date = "2020-04-25"
title = "Jump Game"
slug = "Jump Game"
tags = []
categories = []
+++

## Introduction

Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Determine if you are able to reach the last index.

Example 1:

Input: [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
Example 2:

Input: [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum
             jump length is 0, which makes it impossible to reach the last index.


## Solution

If array less or equal 1 we definitely can reach the last element.
We can solve this problem with brute force, but it would not be effective.

Let's find the solution O(n).
On each step we can calculate the maximum reachable index and store it in `maxSoFar` variable.
If current index plus value greater than maximum reachable index, then we can use this new number `maxSoFar = max(maxSoFar, i + v)`.
If at any moment we can not reach the cell `i`, then we definitely can not reach the last index:
```
if maxSoFar < i {
    return false
}
```

Here is the solution:

``` go
func canJump(nums []int) bool {

    n := len(nums)
    if n <= 1 {
        return true
    }

    maxSoFar := nums[0]
    for i, v := range nums {
        if maxSoFar < i {
            return false
        }
        maxSoFar = max(maxSoFar, i + v)        
    }

    return true
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```
