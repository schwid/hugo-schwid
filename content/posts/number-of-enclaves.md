+++
date = "2019-05-01"
title = "Number of Enclaves"
slug = "Number of Enclaves"
tags = []
categories = []
+++

## Introduction

Given a 2D array A, each cell is 0 (representing sea) or 1 (representing land)

A move consists of walking from one land square 4-directionally to another land square, or off the boundary of the grid.

Return the number of land squares in the grid for which we cannot walk off the boundary of the grid in any number of moves.

 

Example 1:
```
Input: [[0,0,0,0],[1,0,1,0],[0,1,1,0],[0,0,0,0]]
Output: 3
Explanation: 
There are three 1s that are enclosed by 0s, and one 1 that isn't enclosed because its on the boundary.
```

Example 2:
```
Input: [[0,1,1,0],[0,0,1,0],[0,0,1,0],[0,0,0,0]]
Output: 0
Explanation: 
All 1s are either on the boundary or can reach the boundary.
```

Note:
```
1 <= A.length <= 500
1 <= A[i].length <= 500
0 <= A[i][j] <= 1
All rows have the same size.
```

### Solution

BFS solution:
``` go
func numEnclaves(A [][]int) int {
    
    n := len(A)
    m := len(A[0])
        
    dims := []int {n, m}
    
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if A[i][j] == 1 {
                bfs(A, []int {i, j}, dims)
            }
        }
    }
    
    //fmt.Print(A)
    
    num := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if A[i][j] == 2 {
                num++
            }
        }
    }    
    
    return num
    
}

func bfs(A [][]int, point, dims []int) {
    
    d := []int {0, 1, 0, -1, 0}
    
    q := [][]int{ point }
    
    set(A, point, 2)
    visited := [][]int{ point }
    onBorder := isOnBorder(point, dims)
    
    for len(q) > 0 {
        
        p := q[0]
        q = q[1:]
        
        for i := 0; i < 4; i++ {
            
            j := []int { p[0] + d[i], p[1] + d[i+1] }

            if isOutOfBorder(j, dims) {
                continue
            }
            
            if get(A, j) != 1 {
                continue
            }
            
            if isOnBorder(j, dims) {
                onBorder = true
            }
            
            set(A, j, 2)
            visited = append(visited, j)
            
            q = append(q, j)   
            
        }
        
    }
    
    if onBorder {
        for _, v := range visited {
            set(A, v, 3)
        }
    }
    
}

func get(A [][]int, p []int) int {
    return A[p[0]][p[1]]
}

func set(A [][]int, p []int, val int) {
    A[p[0]][p[1]] = val
}

func isOutOfBorder(p, dims []int) bool {
    return p[0] < 0 || p[0] >= dims[0] || p[1] < 0 || p[1] >= dims[1] 
}

func isOnBorder(p, dims []int) bool {
    return p[0] == 0 || p[0] == dims[0]-1 || p[1] == 0 || p[1] == dims[1] - 1
}
```

### Explanation

We can use table A to track different types od cells.
* 0 - sea
* 1 - non visited land
* 2 - visited land on isolated enclave
* 3 - visited land on border and part of land on border

Finally, we need to calculate all points that have `2` value.
