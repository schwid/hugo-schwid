+++
date = "2019-05-21"
title = "Coin Change 2"
slug = "Coin Change 2"
tags = []
categories = []
+++

## Introduction

You are given coins of different denominations and a total amount of money. Write a function to compute the number of combinations that make up that amount. You may assume that you have infinite number of each kind of coin.



Example 1:
```
Input: amount = 5, coins = [1, 2, 5]
Output: 4
Explanation: there are four ways to make up the amount:
5=5
5=2+2+1
5=2+1+1+1
5=1+1+1+1+1
```

Example 2:
```
Input: amount = 3, coins = [2]
Output: 0
Explanation: the amount of 3 cannot be made up just with coins of 2.
```

Example 3:
```
Input: amount = 10, coins = [10]
Output: 1
```

Note:

You can assume that
```
0 <= amount <= 5000
1 <= coin <= 5000
the number of coins is less than 500
the answer is guaranteed to fit into signed 32-bit integer
```

### Solution

Golang:
``` go
func change(amount int, coins []int) int {

    dp := make([]int, amount+1)
    dp[0] = 1

    for _, coin := range coins {
        for i := coin; i <= amount; i++ {
            dp[i] += dp[i-coin]
        }
    }

    return dp[amount]
}
```

### Explanation

Lets create an array to keep counter of how many combination needed to achieve the sum of coins from 1 to amount, `dp := make([]int, amount+1)`
Lets initialize `dp[0]=1` that states for single coin use number 1 as a counter.
The trick is here  `dp[i] += dp[i-coin]`, for every time when we take a `coin` we can use it to complement it to the the amount `i` only if we add the number of coins of predecessor `dp[i-coin]` or if `i==coin` we will take a `1` from our init cell `dp[0]`, that states for one coin the counter is 1.
