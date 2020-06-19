+++
date = "2020-06-17"
title = "Surrounded Regions"
slug = "june 17 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.

A region is captured by flipping all 'O's into 'X's in that surrounded region.

Example:
```
X X X X
X O O X
X X O X
X O X X
```
After running your function, the board should be:

```
X X X X
X X X X
X X X X
X O X X
```

Explanation:

Surrounded regions shouldn’t be on the border, which means that any 'O' on the border of the board are not flipped to 'X'. Any 'O' that is not on the border and it is not connected to an 'O' on the border will be flipped to 'X'. Two cells are connected if they are adjacent cells connected horizontally or vertically.

## Solution

``` go
func solve(board [][]byte)  {
    n := len(board)
    if n == 0 {
        return
    }
    m := len(board[0])
    if m == 0 {
        return
    }

    for i := 1; i < n-1; i++ {
        for j := 1; j < m-1; j++ {
            if board[i][j] == 'O' {

                var color byte
                var flip []int
                if isSurrounded(i, j, n, m, board, &flip) {
                    color = 'X'
                } else {
                    color = 'O'
                }
                for k := 0; k < len(flip); k += 2 {
                    x, y := flip[k], flip[k+1]
                    board[x][y] = color
                }                

            }
        }
    }

}

var dims = []int { -1, 0, 1, 0, 0, 1, 0, -1 }

func isSurrounded(i, j, n, m int, board [][]byte, flip *[]int) bool {
    if i < 0 || i >= n || j < 0 || j >= m {
        return false
    }
    if board[i][j] == 'O' {
        board[i][j] = 'V'    // visited
        *flip = append(*flip, i, j)
        for k := 0; k < len(dims); k += 2 {
            if !isSurrounded(i + dims[k], j + dims[k+1], n, m, board, flip) {
                return false
            }
        }
    }
    return true
}

```

Performance of this solution is:
```
Runtime: 32 ms
Memory Usage: 12 MB
```
