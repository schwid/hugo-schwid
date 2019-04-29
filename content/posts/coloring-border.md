+++
date = "2019-04-28"
title = "Coloring A Border"
slug = "Coloring A Border"
tags = []
categories = []
+++

## Introduction

Given a 2-dimensional grid of integers, each value in the grid represents the color of the grid square at that location.

Two squares belong to the same connected component if and only if they have the same color and are next to each other in any of the 4 directions.

The border of a connected component is all the squares in the connected component that are either 4-directionally adjacent to a square not in the component, or on the boundary of the grid (the first or last row or column).

Given a square at location (r0, c0) in the grid and a color, color the border of the connected component of that square with the given color, and return the final grid.


Example 1:
```
Input: grid = [[1,1],[1,2]], r0 = 0, c0 = 0, color = 3
Output: [[3, 3], [3, 2]]
```
Example 2:
```
Input: grid = [[1,2,2],[2,3,2]], r0 = 0, c0 = 1, color = 3
Output: [[1, 3, 3], [2, 3, 3]]
```
Example 3:
```
Input: grid = [[1,1,1],[1,1,1],[1,1,1]], r0 = 1, c0 = 1, color = 2
Output: [[2, 2, 2], [2, 1, 2], [2, 2, 2]]
```

Note:
* 1 <= grid.length <= 50
* 1 <= grid[0].length <= 50
* 1 <= grid[i][j] <= 1000
* 0 <= r0 < grid.length
* 0 <= c0 < grid[0].length
* 1 <= color <= 1000

### Solution

DFS solution:
``` go
func colorBorder(grid [][]int, r0 int, c0 int, color int) [][]int {

    n := len(grid)
    m := len(grid[0])

    dfs(grid, r0, c0, grid[r0][c0], n, m)

    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] < 0 {
                grid[i][j] = color
            }
        }
    }

    return grid
}

func dfs(grid [][]int, r, c, color, n, m int) {

    d := []int { 0, 1, 0, -1, 0}
    grid[r][c] = -1
    cnt := 0
    for i := 0; i < 4; i++ {

        x, y := r + d[i], c + d[i+1]

        if x >= 0 && x < n && y >= 0 && y < m {

            if grid[x][y] == color || grid[x][y] < 0 {
                cnt++
            }

            if grid[x][y] == color {
                dfs(grid, x, y, color, n, m)
            }
        }

    }

    if cnt == 4 {
        grid[r][c] = color
    }
}
```

BFS solution:
``` go
func colorBorder(grid [][]int, r0 int, c0 int, color int) [][]int {

    n := len(grid)
    m := len(grid[0])

    visited := make([]bool, n * m)
    visited[r0 * m + c0] = true

    bfs(grid, []int{r0, c0}, grid[r0][c0], color, n, m, visited)

    return grid
}

func bfs(grid [][]int, q []int, color, newColor, n, m int, visited []bool) {

    d := []int { 0, 1, 0, -1, 0}

    for len(q) > 0 {

        r := q[0]
        c := q[1]
        q = q[2:]

        if (r == 0 || r == n - 1 || c == 0 || c == m - 1) {
            grid[r][c] = newColor
        }         

        for i := 0; i < 4; i++ {
            x, y := r + d[i], c + d[i+1]
            if x >= 0 && x < n && y >= 0 && y < m && !visited[x*m+y] {

                if grid[x][y] == color {
                    visited[x*m+y] = true
                    q = append(q, x)
                    q = append(q, y)         
                } else {
                    grid[r][c] = newColor    
                }

            }
        }
    }
}
```

### Explanation

BFS solution works faster than DFS.
For the initial point `r0, c0` we need to take it color and check neighbors.
If neighbor has different color, it suppose to be a border, then we need to color it,
otherwise, ignore. Repeat the same logic for all neighbors as for the point `r0, c0`.
