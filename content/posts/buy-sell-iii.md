+++
date = "2019-04-21"
title = "Best Time to Buy and Sell Stock III"
slug = "Best Time to Buy and Sell Stock III"
tags = []
categories = []
+++

## Introduction

Say you have an array for which the i-th element is the price of a given stock on day i.

Design an algorithm to find the maximum profit. You may complete at most two transactions.

Note: You may not engage in multiple transactions at the same time (i.e., you must sell the stock before you buy again).

Example 1:
```
Input: [3,3,5,0,0,3,1,4]
Output: 6
Explanation: Buy on day 4 (price = 0) and sell on day 6 (price = 3), profit = 3-0 = 3.
             Then buy on day 7 (price = 1) and sell on day 8 (price = 4), profit = 4-1 = 3.
```

Example 2:
```
Input: [1,2,3,4,5]
Output: 4
Explanation: Buy on day 1 (price = 1) and sell on day 5 (price = 5), profit = 5-1 = 4.
             Note that you cannot buy on day 1, buy on day 2 and sell them later, as you are
             engaging multiple transactions at the same time. You must sell before buying again.
```             
Example 3:

```
Input: [7,6,4,3,1]
Output: 0
Explanation: In this case, no transaction is done, i.e. max profit = 0.
```

### Solution

Golang:
``` go
func maxProfit(prices []int) int {

	n := len(prices)

	if n == 0 {
		return 0
	}

	minPrice := prices[0]
	oneTxProfit, twoTxProfit, maxSoFar := 0, 0, -prices[0]

	for i := 1; i < n; i++ {
		minPrice = min(minPrice, prices[i])
		oneTxProfit = max(oneTxProfit, prices[i] - minPrice)
		twoTxProfit = max(twoTxProfit, prices[i] + maxSoFar)
		maxSoFar = max(maxSoFar, -prices[i] + oneTxProfit)
	}

	return twoTxProfit
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

First transaction profit comes from the difference between current price (suppose we sell at i-th iteration) and min buy price so far. That's pretty obvious and easy solution for "Buy and Sell I" problem.

Problem became hard if we want to calculate two transactions profit. In this case two transaction must not overlap each other.

Combine profit of two transactions calculated as a sum of one transaction plus deal after that. The second deal is the current price minus purchase price after achieving the max of first transaction before it so far.
