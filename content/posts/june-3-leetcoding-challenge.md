+++
date = "2020-06-03"
title = "Two City Scheduling"
slug = "june 3 leetcoding challenge"
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
```

Explanation:
```
The first person goes to city A for a cost of 10.
The second person goes to city A for a cost of 30.
The third person goes to city B for a cost of 50.
The fourth person goes to city B for a cost of 20.
```

The total minimum cost is 10 + 30 + 50 + 20 = 110 to have half the people interviewing in each city.


Note:
```
1 <= costs.length <= 100
It is guaranteed that costs.length is even.
1 <= costs[i][0], costs[i][1] <= 1000
```

## Solution

This is the greedy algorithm solution where the simple implementation would be to sort our list by priority based on cost between two options.


``` go
type Cost  [][]int

func (p Cost) Len() int           { return len(p) }
func (p Cost) Less(i, j int) bool { return p[i][0] - p[i][1] < p[j][0] - p[j][1] }
func (p Cost) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }


func twoCitySchedCost(costs [][]int) int {
    sort.Sort(Cost(costs))
    A, B := 0, 0
    n := len(costs) / 2
    for i := 0; i < n; i++ {
        A += costs[i][0]
        B += costs[n+i][1]
    }
    return A + B
}
```

Performance of this solution is:
```
Runtime: 0 ms
Memory Usage: 2.5 MB
```
