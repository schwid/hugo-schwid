+++
date = "2019-04-21"
title = "Best Time to Buy and Sell Stock IV"
slug = "Best Time to Buy and Sell Stock IV"
tags = []
categories = []
+++

## Introduction

Say you have an array for which the i-th element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete at most k transactions.

Note:
You may not engage in multiple transactions at the same time (ie, you must sell the stock before you buy again).

Example 1:
```
Input: [2,4,1], k = 2
Output: 2
Explanation: Buy on day 1 (price = 2) and sell on day 2 (price = 4), profit = 4-2 = 2.
```

Example 2:
```
Input: [3,2,6,5,0,3], k = 2
Output: 7
Explanation: Buy on day 2 (price = 2) and sell on day 3 (price = 6), profit = 6-2 = 4.
             Then buy on day 5 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
```


### Solution

Golang:
``` go
func maxProfit(k int, prices []int) int {

	n := len(prices)

	if n == 0 || k == 0 {
		return 0
	}

	if k >= n/2 {
    return maxProfitUnlimited(prices)
	}

	maxSoFar := make([]int, k+1)
	for i := 1; i <= k; i++ {
		maxSoFar[i] = -prices[0]
	}

	profit := make([]int, k+1)

	for i := 1; i < n; i++ {

		for t := 1; t <= k; t++ {

			profit[t] = max(profit[t], prices[i] + maxSoFar[t])
			maxSoFar[t] = max(maxSoFar[t], -prices[i] + profit[t-1])

		}

	}

	return profit[k]
}

func maxProfitUnlimited(prices []int) int {

    n := len(prices)

    if n <= 1 {
        return 0
    }

    profit := 0

    for i := 1; i < n; i++ {
        profit += max(0, prices[i] - prices[i-1])
    }

    return profit
}

func min(a, b int) int {
	if a <= b {
		return a
	} else {
		return b
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

Solution of IV problem is the combination of solutions of problem III and problem II.

If we have k >= n/2, then it is reasonable to calculate unlimited transactions (problem II), because it would be faster O(n).

If k < n/2, then we need to find a combination of all possible related to each other deals in [0, k) space, that is O(n*k).
For that purpose we enhance the problem III by adding additional loop [O,k) and arrays to track profits and maxSoFar.
