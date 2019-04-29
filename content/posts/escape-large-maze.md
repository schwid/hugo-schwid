+++
date = "2019-04-28"
title = "Escape a Large Maze"
slug = "Escape a Large Maze"
tags = []
categories = []
+++

## Introduction

In a 1 million by 1 million grid, the coordinates of each grid square are (x, y) with 0 <= x, y < 10^6.

We start at the source square and want to reach the target square.  Each move, we can walk to a 4-directionally adjacent square in the grid that isn't in the given list of blocked squares.

Return true if and only if it is possible to reach the target square through a sequence of moves.


Example 1:
```
Input: blocked = [[0,1],[1,0]], source = [0,0], target = [0,2]
Output: false
Explanation:
The target square is inaccessible starting from the source square, because we can't walk outside the grid.
```
Example 2:
```
Input: blocked = [], source = [0,0], target = [999999,999999]
Output: true
Explanation:
Because there are no blocked cells, it's possible to reach the target square.
```

### Solution

BFS search:
``` go
func isEscapePossible(blocked [][]int, source []int, target []int) bool {

    d := []int{ 0, 1, 0, -1 ,0 }

    n := 1000000

    block := make(map[int]bool)
    for _, b := range blocked {
        block[b[0] * n + b[1]] = true
    }

    visit := make(map[int]bool)

    q := []int{ source[0], source[1] }

    c := 10000
    for ; len(q) > 0 && c > 0; c-- {

        x0, y0 := q[0], q[1]
        q = q[2:]

        for i := 0; i < 4; i++ {

            x, y := x0 + d[i], y0 + d[i + 1]

            if x < 0 || x >= n || y < 0 || y >= n {
                continue
            }

            if x == target[0] && y == target[1] {
                return true
            }

            if !visit[x * n + y] && !block[x * n + y] {
                q = append(q, x)
                q = append(q, y)
                visit[x * n + y] = true    
            }

        }

    }

    return c <= 0
}
```

### Explanation

This problem is a good example for BFS (Breadth First Search) algorithm, because at any step we have 4 options to go, and it is reasonable to consider all of them at ones, rather than use DFS (Deep First Search), because of a huge grid space 10^6 * 10^6.

We have two options of ending the loop: if we achieved target point or we escape a maze.
Of course, computation power it not enough to estimate all 10^12 space points, therefore this solution is using only 10^4 steps to decide if we excepted a maze or not.
