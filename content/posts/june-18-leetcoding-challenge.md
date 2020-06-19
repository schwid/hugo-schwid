+++
date = "2020-06-18"
title = "H-Index II"
slug = "june 18 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an array of citations sorted in ascending order (each citation is a non-negative integer) of a researcher, write a function to compute the researcher's h-index.

According to the definition of h-index on Wikipedia: "A scientist has index h if h of his/her N papers have at least h citations each, and the other N − h papers have no more than h citations each."

Example:

Input: citations = [0,1,3,5,6]
Output: 3
Explanation: [0,1,3,5,6] means the researcher has 5 papers in total and each of them had
             received 0, 1, 3, 5, 6 citations respectively.
             Since the researcher has 3 papers with at least 3 citations each and the remaining
             two with no more than 3 citations each, her h-index is 3.
Note:

If there are several possible values for h, the maximum one is taken as the h-index.

Follow up:

This is a follow up problem to H-Index, where citations is now guaranteed to be sorted in ascending order.
Could you solve it in logarithmic time complexity?

## Solution

Let's first solve this problem with for each loop

``` go
func hIndex(citations []int) int {
    h := 0
    n := len(citations)
    for j := n-1; j >= 0; j-- {
        pos := n - j
        if citations[j] >= pos {
            h = pos
        }
    }
    return h
}
```

Performance of this solution is:
```
Runtime: 12 ms
Memory Usage: 6.3 MB
```

Another way to solve this problem is to use binary search

``` go
func hIndex(citations []int) int {
    n := len(citations)    
    lo, hi := 0, n
    for lo < hi {
        mi := (hi - lo) / 2 + lo
        pos := n - mi
        if citations[mi] >= pos {
           hi = mi
        } else {
           lo = mi+1
        }
    }
    return n - lo
}
```

Performance of this solution is better, and complexity is just O(log(n)):
```
Runtime: 8 ms, faster than 100.00% of Go online submissions for H-Index II.
Memory Usage: 6.3 MB, less than 80.00% of Go online submissions for H-Index II.
```
