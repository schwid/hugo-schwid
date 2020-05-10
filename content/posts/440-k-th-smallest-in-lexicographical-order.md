+++
date = "2020-05-09"
title = "K-th Smallest in Lexicographical Order"
slug = "440. K-th Smallest in Lexicographical Order"
tags = []
categories = []
+++

## Introduction

Given integers n and k, find the lexicographically k-th smallest integer in the range from 1 to n.

Note: 1 ≤ k ≤ n ≤ 109.

Example:

Input:
```
n: 13   k: 2
```

Output:
```
10
```

Explanation:
The lexicographical order is [1, 10, 11, 12, 13, 2, 3, 4, 5, 6, 7, 8, 9], so the second smallest number is 10.

## Solution

This task is the same as "386. Lexicographical Numbers", but we also need to skip numbers by using function 'countNumber' to have a maximum performance.

``` go
func findKthNumber(n int, k int) int {
   return dfs(1, n, k-1)
}

func dfs(root, n, k int) int {

    if k == 0 {
        return root
    }

    count := countNumber(root, n)
    if count > k {
        return dfs(root*10, n, k-1)
    } else {
        return dfs(root+1, n, k-count)
    }
}

func countNumber(root, n int) int {
    son := root+1
    cnt := 0
    for root <= n {
        cnt += min(son, n+1) - root
        root *= 10;
        son *= 10;
    }        
    return cnt
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}
```


## Preformance

```
Runtime: 0 ms, faster than 100.00% of Go online submissions for K-th Smallest in Lexicographical Order.
Memory Usage: 2 MB, less than 100.00% of Go online submissions for K-th Smallest in Lexicographical Order.
```
