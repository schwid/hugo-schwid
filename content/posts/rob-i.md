+++
date = "2019-04-26"
title = "House Robber"
slug = "House Robber"
tags = []
categories = []
+++

## Introduction


You are a professional robber planning to rob houses along a street. Each house has a certain amount of money stashed, the only constraint stopping you from robbing each of them is that adjacent houses have security system connected and it will automatically contact the police if two adjacent houses were broken into on the same night.

Given a list of non-negative integers representing the amount of money of each house, determine the maximum amount of money you can rob tonight without alerting the police.

Example 1:
```
Input: [1,2,3,1]
Output: 4
Explanation: Rob house 1 (money = 1) and then rob house 3 (money = 3).
             Total amount you can rob = 1 + 3 = 4.
```
Example 2:
```
Input: [2,7,9,3,1]
Output: 12
Explanation: Rob house 1 (money = 2), rob house 3 (money = 9) and rob house 5 (money = 1).
             Total amount you can rob = 2 + 9 + 1 = 12.
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
        case 3:
            return max(nums[0] + nums[2], nums[1])
        default:
            mid := n / 2
            return max(rob(nums[:mid]) + rob(nums[mid+1:]), rob(nums[:mid-1]) + rob(nums[mid:]) ) 
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

Let's start solving this task from small to bigger examples.
If input array is empty, then 0 houses we can rob.
If input array has one element, then only one house we can rob.
If input array has two elements, then we need to select first or second house.
If input array has 3 elements, then we have choice between middle house and two in the corners.
For any number greater 3 we can split the task in the middle and select between two options: 
* do not rob mid house
* do not rob house before mid
By encoding all cases in `select` we get the solution.





