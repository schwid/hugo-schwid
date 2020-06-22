+++
date = "2020-06-20"
title = "Dungeon Game"
slug = "june 20 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

The demons had captured the princess (P) and imprisoned her in the bottom-right corner of a dungeon. The dungeon consists of M x N rooms laid out in a 2D grid. Our valiant knight (K) was initially positioned in the top-left room and must fight his way through the dungeon to rescue the princess.

The knight has an initial health point represented by a positive integer. If at any point his health point drops to 0 or below, he dies immediately.

Some of the rooms are guarded by demons, so the knight loses health (negative integers) upon entering these rooms; other rooms are either empty (0's) or contain magic orbs that increase the knight's health (positive integers).

In order to reach the princess as quickly as possible, the knight decides to move only rightward or downward in each step.

Write a function to determine the knight's minimum initial health so that he is able to rescue the princess.

For example, given the dungeon below, the initial health of the knight must be at least 7 if he follows the optimal path RIGHT-> RIGHT -> DOWN -> DOWN.
```
-2 (K)	-3	3
-5	-10	1
10	30	-5 (P)
```

Note:
```
The knight's health has no upper bound.
Any room can contain threats or power-ups, even the first room the knight enters and the bottom-right room where the princess is imprisoned.
```

## Solution

One way to solve this problem is to simulate king movements and find the min initial health he can reach the princess.

``` go
func calculateMinimumHP(dungeon [][]int) int {
    n := len(dungeon)
    if n == 0 {
        return -1
    }
    m := len(dungeon[0])
    health := make([][]int, n)
    for i := 0; i < n; i++ {
        health[i] = make([]int, m)
    }
    for h := 1; ; h++ {
        if canFinish(dungeon, health, h) {
            return h
        }   
    }
}

func canFinish(dungeon, health [][]int, initialHealth int) bool {
    minVal := int(math.MinInt64)
    n, m := len(dungeon), len(dungeon[0])
    health[0][0] = dungeon[0][0] + initialHealth
    if health[0][0] <= 0 {
        health[0][0] = minVal
    }
    for j := 1; j < m; j++ {
        health[0][j] = health[0][j-1]
        if health[0][j] <= 0 {
            health[0][j] = minVal
        } else {
             health[0][j] += dungeon[0][j]
        }
    }
    for i := 1; i < n; i++ {
        health[i][0] = health[i-1][0]
        if health[i][0] <= 0 {
            health[i][0] = minVal
        } else {
            health[i][0] += dungeon[i][0]
        }
        for j := 1; j < m; j++ {
            health[i][j] = max(health[i-1][j], health[i][j-1])
            if health[i][j] <= 0 {
                health[i][j] = minVal
            } else {
                health[i][j] += dungeon[i][j]
            }
        }
    }
    return health[n-1][m-1] > 0
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```

Performance of this solution is:
```
Runtime: 28 ms
Memory Usage: 3.7 MB
```

Let's move princess instead of king, so in this case we can track min health required for king to come to particular cell.

``` go
func calculateMinimumHP(dungeon [][]int) int {
    n := len(dungeon)
    if n == 0 {
        return -1
    }
    m := len(dungeon[0])
    health := make([][]int, n)
    for i := 0; i < n; i++ {
        health[i] = make([]int, m)
    }
    health[n-1][m-1] = minHealth(1, dungeon[n-1][m-1])
    for j := m-2; j >= 0; j-- {
        health[n-1][j] = minHealth(health[n-1][j+1], dungeon[n-1][j])
    }
    for i := n-2; i >= 0; i-- {
        health[i][m-1] = minHealth(health[i+1][m-1], dungeon[i][m-1])
        for j := m-2; j >= 0; j-- {
            optA := minHealth(health[i+1][j], dungeon[i][j])
            optB := minHealth(health[i][j+1], dungeon[i][j])
            health[i][j] = min(optA, optB)
        }
    }
    return health[0][0]
}

func minHealth(health, cell int) int {
    h := health - cell
    if h <= 0 {
        return 1
    }
    return h
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```

This solution is faster and gives good performance:
```
Runtime: 4 ms
Memory Usage: 3.7 MB
```
