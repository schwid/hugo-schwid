+++
date = "2019-04-26"
title = "House Robber II"
slug = "House Robber II"
tags = []
categories = []
+++

## Introduction

You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed. All houses at this place are arranged in a circle. That means the first house is the neighbor of the last one. Meanwhile, adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.

Example 1:
```
Input: [2,3,2]
Output: 3
Explanation: You cannot rob house 1 (money = 2) and then rob house 3 (money = 2),
             because they are adjacent houses.
```
Example 2:
```
Input: [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
             Total amount you can rob = 1 + 3 = 4.
```

### Solution

Recursive solution:
``` go
func rob(nums []int) int {
    n := len(nums) 
    switch n {
      case 0:
          return 0
      case 1:
          return nums[0]
      case 2:
          return max(nums[0], nums[1])
      default:
          return max(robR(nums[:n-1]), robR(nums[1:]))
    }
}

func robR(nums []int) int {
    n := len(nums)
    switch n {
        case 0:
            return 0
        case 1:
            return nums[0]
        case 2:
            return max(nums[0], nums[1])
        case 3:
            return max(nums[0] + nums[2], nums[1])
        default:
            m := n / 2
            return max(robR(nums[:m]) + robR(nums[m+1:]), robR(nums[:m-1]) + robR(nums[m:]) ) 
    }
}

func max(a, b int) int {
    if a >= b {
        return a
    } else {
        return b
    }
}
```

### Explanation

Let's start from a small example to bigger one.
If we have zero houses, then profit is zero.
If we have one house, then profit is from this one house.
For two houses, we need to select the maximum of them.
Three and more houses can transform this task to "House Robber I" by removing one of the edge houses.
