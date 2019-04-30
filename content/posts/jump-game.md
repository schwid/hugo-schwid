+++
date = "2019-04-30"
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
```
Input: [2,3,1,1,4]
Output: true
Explanation: Jump 1 step from index 0 to 1, then 3 steps to the last index.
```

Example 2:
```
Input: [3,2,1,0,4]
Output: false
Explanation: You will always arrive at index 3 no matter what. Its maximum
             jump length is 0, which makes it impossible to reach the last index.
```

### Solution

Dynamic programming solution with one variable:
``` go
func canJump(nums []int) bool {

    n := len(nums)
    if n <= 1 {
        return true
    }
 
    dp := nums[0]
    for i, v := range nums {
        if dp < i {
            return false
        }
        dp = max(dp, i + v)        
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

### Explanation

There two corner cases, if array empty and if it has a one element. In both corner cases we can reach the end, because all values a non-negative.
If we create and dynamic programming array and save maxSoFar for `i+nums[i]`, we will figured out that we are using only last cell in DP array.
So, this task simplify till the one dp variable.




