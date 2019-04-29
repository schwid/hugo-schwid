+++
date = "2019-04-29"
title = "Two City Scheduling"
slug = "Two City Scheduling"
tags = []
categories = []
+++

## Introduction

There are 2N people a company is planning to interview. The cost of flying the i-th person to city A is costs[i][0], and the cost of flying the i-th person to city B is costs[i][1].

Return the minimum cost to fly every person to a city such that exactly N people arrive in each city.


Example 1:
```
Input: [[10,20],[30,200],[400,50],[30,20]]
Output: 110
Explanation:
The first person goes to city A for a cost of 10.
The second person goes to city A for a cost of 30.
The third person goes to city B for a cost of 50.
The fourth person goes to city B for a cost of 20.

The total minimum cost is 10 + 30 + 50 + 20 = 110 to have half the people interviewing in each city.
```

Note:
```
1 <= costs.length <= 100
It is guaranteed that costs.length is even.
1 <= costs[i][0], costs[i][1] <= 1000
```

### Solution

Dynamic programming solution:
``` go
func twoCitySchedCost(costs [][]int) int {

    n := len(costs) / 2

    dp := make([][]int, n+1)
    dp[0] = make([]int, n+1)

    for i := 1; i <= n; i++ {
        dp[i] = make([]int, n+1)
        dp[i][0] = dp[i-1][0] + costs[i-1][0]
    }

    for j := 1; j <= n; j++ {
        dp[0][j] = dp[0][j-1] + costs[j-1][1]
    }

    for i := 1; i <= n; i++ {
        for j := 1; j <= n; j++ {
            idx := i+j-1
            dp[i][j] = min(dp[i-1][j] + costs[idx][0], dp[i][j-1] + costs[idx][1])
        }
    }

    return dp[n][n]
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

The best way to estimate all combinations in this problem is to use dynamic programming.
We have only two cities where we need to optimize traffic, therefore lets create a 2D matrix where each dimension is the number of people flying to city A (coordinates X or rows) or city B (coordinates Y or columns).
