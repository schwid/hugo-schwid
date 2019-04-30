+++
date = "2019-04-30"
title = "Jump Game II"
slug = "Jump Game II"
tags = []
categories = []
+++

## Introduction


Given an array of non-negative integers, you are initially positioned at the first index of the array.

Each element in the array represents your maximum jump length at that position.

Your goal is to reach the last index in the minimum number of jumps.

Example:
```
Input: [2,3,1,1,4]
Output: 2
Explanation: The minimum number of jumps to reach the last index is 2.
    Jump 1 step from index 0 to 1, then 3 steps to the last index.
```
Note:
```
You can assume that you can always reach the last index.
```

### Solution

Dynamic programming solution:
``` go
func jump(nums []int) int {
    
    n := len(nums)
    if n <= 1 {
        return 0
    }
 
    dp := make([]int, n+1)
    for i := 0; i <= n; i++ {
        dp[i] = n+1
    }
    dp[0] = 0
    
    j := nums[0]
    for i, v := range nums {
        if j < i {
            // unachievable
            return -1
        }
        j = max(j, i+v) 
        m := min(j, n-1)
        for k := i; k <= m; k++ {
            dp[k] = min(dp[k], dp[i] + 1)
        }
    }
    
    return dp[n-1]
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

BFS solution
``` go
func jump(nums []int) int {
    
    n := len(nums)
    if n <= 1 {
        return 0
    }
 
    steps := nums[0]
    if steps >= n-1 {
        return 1
    }
    
    maxSoFar, maxIndex := 0, 0
    
    for i := 1; i <= steps; i++ {
        
        nextSteps := i + nums[i]
        
        if nextSteps >= n-1 {
            // we achieved the last index
            return 2
        }
        
        if maxSoFar < nextSteps {
            maxSoFar = nextSteps
            maxIndex = i
        }
        
    }
  
    if maxIndex == 0 {
        panic("no solution")
    }
    
    return 1 + jump(nums[maxIndex:])
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}
```

### Explanation

The first solution that come in mind is dynamic programming approach based on more simple version of this problem "Jump Game".
But, this solution is not optimal. There is another one based on BFS with recursion.
