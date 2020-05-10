+++
date = "2020-05-09"
title = "Lexicographical Numbers"
slug = "386 Lexicographical Numbers"
tags = []
categories = []
+++

## Introduction

Given an integer n, return 1 - n in lexicographical order.

For example, given 13, return: [1,10,11,12,13,2,3,4,5,6,7,8,9].

Please optimize your algorithm to use less time and space. The input size may be as large as 5,000,000.

## Solution

Let's use DFS seach to build the ordered list of numbers.

``` go
func lexicalOrder(n int) []int {
    return dfs(0, n, make([]int, 0, n))
}

func dfs(root, n int, out []int) []int {
    for i := 0; i <= 9; i++ {
        val := i + root
        if val > n {
            return out
        } else if val > 0 {
            out = append(out, val)
            val *= 10
            if val <= n {
                out = dfs(val, n, out)  
            }  
        }

    }
    return out
}
```

Performance of this task is

```
Runtime: 8 ms, faster than 100.00% of Go online submissions for Lexicographical Numbers.
Memory Usage: 6.1 MB, less than 100.00% of Go online submissions for Lexicographical Numbers.
```

Let's simplify this code by removing loop on i and write classic DFS solution.

``` go
func lexicalOrder(n int) []int {
    return dfs(1, n, make([]int, 0, n))
}

func dfs(root, n int, out []int) []int {
    out = append(out, root)
    child := root * 10
    if child <= n {
        out = dfs(child, n, out)
    }
    next := root+1
    if next % 10 == 0 || next > n {
        return out
    }
    return dfs(next, n, out)
}
```

This new code gives better performance, because it has less if-else statements and loops.

```
Runtime: 8 ms, faster than 100.00% of Go online submissions for Lexicographical Numbers.
Memory Usage: 6.1 MB, less than 100.00% of Go online submissions for Lexicographical Numbers.
```
