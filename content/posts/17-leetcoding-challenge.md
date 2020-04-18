+++
date = "2020-04-17"
title = "Number of Islands"
slug = "Number of Islands"
tags = []
categories = []
+++

## Introduction

Given a 2d grid map of '1's (land) and '0's (water), count the number of islands. An island is surrounded by water and is formed by connecting adjacent lands horizontally or vertically. You may assume all four edges of the grid are all surrounded by water.

Example 1:

Input:
```
11110
11010
11000
00000
```

Output: 1
Example 2:

Input:
```
11000
11000
00100
00011
```

Output: 3

## Solution

If we will remove islands on each step, then we can definitely count insolated ones.

This is simple DFS recursion solution that works well and gives maximum performance 0ms.

``` go
func numIslands(grid [][]byte) int {
    n := len(grid)
    if n == 0 {
        return 0
    }
    m := len(grid[0])

    cnt := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if grid[i][j] == '1' {
                cnt++
                removeIsland(i, n, j, m, grid)
            }    

        }
    }

    return cnt
}

func removeIsland(i, n, j, m int, grid [][]byte) {
    if i < 0 || i >= n || j < 0 || j >= m {
        return
    }
    if grid[i][j] == '1' {
        grid[i][j] = '0'
        removeIsland(i-1, n, j, m, grid)
        removeIsland(i+1, n, j, m, grid)
        removeIsland(i, n, j-1, m, grid)
        removeIsland(i, n, j+1, m, grid)
    }

}
```
