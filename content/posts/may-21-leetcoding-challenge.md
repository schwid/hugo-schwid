+++
date = "2020-05-21"
title = "Count Square Submatrices with All Ones"
slug = "may 21 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a m * n matrix of ones and zeros, return how many square submatrices have all ones.

Example 1:
```
Input: matrix =
[
  [0,1,1,1],
  [1,1,1,1],
  [0,1,1,1]
]
Output: 15
Explanation:
There are 10 squares of side 1.
There are 4 squares of side 2.
There is  1 square of side 3.
Total number of squares = 10 + 4 + 1 = 15.
```

Example 2:
```
Input: matrix =
[
  [1,0,1],
  [1,1,0],
  [1,1,0]
]
Output: 7
Explanation:
There are 6 squares of side 1.  
There is 1 square of side 2.
Total number of squares = 6 + 1 = 7.
```

Constraints:
```
1 <= arr.length <= 300
1 <= arr[0].length <= 300
0 <= arr[i][j] <= 1
```

## Solution

Let's write simple brute force solution that checks right top corner of each possible square and optimize it later.

``` go
func countSquares(matrix [][]int) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }
    m := len(matrix[0])
    if m == 0 {
        return 0
    }
    total := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            side := min(n-i, m-j)
            for k := 1; k <= side; k++ {
                if isSquare(matrix, i, j, k) {
                    total++
                }
            }
        }
    }
    return total
}

func isSquare(matrix [][]int, i, j, k int) bool {
    for ii := 0; ii < k; ii++ {
        for jj := 0; jj < k; jj++ {
            if matrix[i+ii][j+jj] != 1 {
                return false
            }
        }
    }
    return true
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```

This solution gives

```
Runtime: 388 ms
Memory Usage: 6.5 MB
```

Let's do first optimization. We go to all possible sides of the square without taking in account, that if square 2 invalid that there is no any chance chat 3,4,5+ would be valid.

Here is the fix
``` go
if isSquare(matrix, i, j, k) {
    total++
-- }
++ } else {
++  break
++}
```

Current solution is
``` go
func countSquares(matrix [][]int) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }
    m := len(matrix[0])
    if m == 0 {
        return 0
    }
    total := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            side := min(n-i, m-j)
            for k := 1; k <= side; k++ {
                if isSquare(matrix, i, j, k) {
                    total++
                } else {
                    break
                }
            }
        }
    }
    return total
}

func isSquare(matrix [][]int, i, j, k int) bool {
    for ii := 0; ii < k; ii++ {
        for jj := 0; jj < k; jj++ {
            if matrix[i+ii][j+jj] != 1 {
                return false
            }
        }
    }
    return true
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```

Performance was improved:
```
Runtime: 160 ms
Memory Usage: 6.6 MB
```

But we still have redundancy in this solution. Every time when we check 3 square size, we check again 2 and 1 and so on.
Let's replace this code by checking only addons for the square.

``` go
func countSquares(matrix [][]int) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }
    m := len(matrix[0])
    if m == 0 {
        return 0
    }
    total := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            maxSize := min(n-i, m-j)
            total += calcSquares(matrix, i, j, maxSize)
        }
    }
    return total
}

func calcSquares(matrix [][]int, i, j, maxSquare int) int {
    if matrix[i][j] != 1 {
        return 0
    }
    k := 1
    for ; k < maxSquare; k++ {
        for jj := 0; jj <= k; jj++ {
            if matrix[i+k][j+jj] != 1 {
                return k
            }
        }
        for ii := 0; ii <= k; ii++ {
            if matrix[i+ii][j+k] != 1 {
                return k
            }
        }
    }
    return k
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```

Here is the performance of this solution:

```
Runtime: 92 ms
Memory Usage: 6.7 MB
```

This result is significantly better, but not the best.

Another way to solve this task is to use dynamic programming.
Instead of looking forward on the square, we need to look backward.
In this case we need to store intermediate value of the participating squares for the point.
And matrix itself works for this very well.

Here is the solution

``` go
func countSquares(matrix [][]int) int {
    n := len(matrix)
    if n == 0 {
        return 0
    }
    m := len(matrix[0])
    if m == 0 {
        return 0
    }
    total := 0
    for i := 0; i < n; i++ {
        for j := 0; j < m; j++ {
            if i > 0 && j > 0 && matrix[i][j] == 1 {
                matrix[i][j] += min3(matrix[i-1][j], matrix[i][j-1], matrix[i-1][j-1])   
            }
            total += matrix[i][j]
        }
    }
    return total
}

func min3(a, b, c int) int {
    if a < b {
        if a < c {
            return a
        }
        return c
    }
    if b < c {
        return b
    }
    return c
}
```

Performance is better:
```
Runtime: 64 ms
Memory Usage: 7.1 MB
```
