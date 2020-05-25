+++
date = "2020-05-25"
title = "Uncrossed Lines"
slug = "may 25 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

We write the integers of A and B (in the order they are given) on two separate horizontal lines.

Now, we may draw connecting lines: a straight line connecting two numbers A[i] and B[j] such that:

A[i] == B[j];
The line we draw does not intersect any other connecting (non-horizontal) line.
Note that a connecting lines cannot intersect even at the endpoints: each number can only belong to one connecting line.

Return the maximum number of connecting lines we can draw in this way.


Example 1:

```
Input: A = [1,4,2], B = [1,2,4]
Output: 2
Explanation: We can draw 2 uncrossed lines as in the diagram.
We cannot draw 3 uncrossed lines, because the line from A[1]=4 to B[2]=4 will intersect the line from A[2]=2 to B[1]=2.
```

Example 2:
```
Input: A = [2,5,1,2,5], B = [10,5,2,1,5,2]
Output: 3
```

Example 3:
```
Input: A = [1,3,7,1,7,5], B = [1,9,2,5,1]
Output: 2
```

Note:
```
1 <= A.length <= 500
1 <= B.length <= 500
1 <= A[i], B[i] <= 2000
```

## Solution

This problem can be transformed in to longest common sequence.

``` go
func maxUncrossedLines(A []int, B []int) int {
	n, m := len(A), len(B)
	dp := make([][]int, n+1)
	dp[0] = make([]int, m+1)
	for i := 1; i <= n; i++ {
		dp[i] = make([]int, m+1)
		for j := 1; j <= m; j++ {
			if A[i-1] == B[j-1] {
				dp[i][j] = dp[i-1][j-1] + 1
			} else {
				dp[i][j] = max(dp[i][j-1], dp[i-1][j])
			}
		}
	}
	return dp[n][m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```

## Performance

Current performance
```
Runtime: 4 ms
Memory Usage: 6.1 MB
```

We do not need to keep the full 2D array, just a previous row and current.

``` go
func maxUncrossedLines(A []int, B []int) int {
	n, m := len(A), len(B)
	prev, curr := make([]int, m+1), make([]int, m+1)
	for i := 1; i <= n; i++ {
		for j := 1; j <= m; j++ {
			if A[i-1] == B[j-1] {
				curr[j] = prev[j-1] + 1
			} else {
				curr[j] = max(curr[j-1], prev[j])
			}
		}
        prev, curr = curr, prev
	}
	return prev[m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```

This solution is faster:
```
Runtime: 0 ms
Memory Usage: 2.3 MB
```
