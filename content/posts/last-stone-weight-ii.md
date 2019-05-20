+++
date = "2019-05-20"
title = "Last Stone Weight II"
slug = "Last Stone Weight II"
tags = []
categories = []
+++

## Introduction

We have a collection of rocks, each rock has a positive integer weight.

Each turn, we choose any two rocks and smash them together.  Suppose the stones have weights x and y with x <= y.  The result of this smash is:

If x == y, both stones are totally destroyed;
If x != y, the stone of weight x is totally destroyed, and the stone of weight y has new weight y-x.
At the end, there is at most 1 stone left.  Return the smallest possible weight of this stone (the weight is 0 if there are no stones left.)

 

Example 1:
```
Input: [2,7,4,1,8,1]
Output: 1
Explanation: 
We can combine 2 and 4 to get 2 so the array converts to [2,7,1,8,1] then,
we can combine 7 and 8 to get 1 so the array converts to [2,1,1,1] then,
we can combine 2 and 1 to get 1 so the array converts to [1,1,1] then,
we can combine 1 and 1 to get 0 so the array converts to [1] then that's the optimal value.
``` 

Note:
```
1 <= stones.length <= 30
1 <= stones[i] <= 100
```

### Solution

Golang:
``` go
func lastStoneWeightII(stones []int) int {
    
    n := len(stones)
    if n == 0 {
        return 0
    }

    sum := 0
    for _, v := range stones {
        sum += v
    }

    target := sum / 2
    dp := make([]bool, target + 1)
    dp[0] = true
    
    for _, v := range stones {
        for j := target; j >= v; j-- {
            dp[j] = dp[j] || dp[j - v]
        }
    }

    for i := target; i > 0; i-- {
        if dp[i] {
            return sum - 2 * i
        }
    }

    return 0
}
```

### Explanation

This problem can be transformed in to [Partition a set into two subsets such that the difference of subset sums is minimum](https://www.geeksforgeeks.org/partition-a-set-into-two-subsets-such-that-the-difference-of-subset-sums-is-minimum/) and solved 
by using dynamic programming.



