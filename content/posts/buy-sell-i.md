+++
date = "2019-04-21"
title = "Best Time to Buy and Sell Stock"
slug = "Best Time to Buy and Sell Stock"
tags = []
categories = []
+++

## Introduction

Say you have an array for which the i-th element is the price of a given stock on day i.

If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.

Note that you cannot sell a stock before you buy one.

Example 1:
```
Input: [7,1,5,3,6,4]
Output: 5
Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
             Not 7-1 = 6, as selling price needs to be larger than buying price.
```
Example 2:
```
Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.
```

### Solution

Golang:
```
func maxProfit(prices []int) int {

	n := len(prices)

	if n == 0 {
		return 0
	}

	minPrice := prices[0]
	profit := 0

	for i := 1; i < n; i++ {
		minPrice = min(minPrice, prices[i])
		profit = max(profit, prices[i] - minPrice)
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

Complexity of the task is O(n), because we have only one main loop.
On every step we update minPrice, because as less we buy, better profit we have.
We can have profit only if we sell after the purchase, therefore on each step we calculate difference between sell price on i-th iteration and minPrice. Maximum of that difference is our maxProfit.  
