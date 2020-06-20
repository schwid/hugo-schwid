+++
date = "2020-06-20"
title = "Permutation Sequence"
slug = "june 20 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

The set [1,2,3,...,n] contains a total of n! unique permutations.

By listing and labeling all of the permutations in order, we get the following sequence for n = 3:
```
"123"
"132"
"213"
"231"
"312"
"321"
```
Given n and k, return the kth permutation sequence.

Note:
```
Given n will be between 1 and 9 inclusive.
Given k will be between 1 and n! inclusive.
```

Example 1:
```
Input: n = 3, k = 3
Output: "213"
```

Example 2:
```
Input: n = 4, k = 9
Output: "2314"
```


## Solution

Let's use greedy algorithm to fill up the k-th combination.
First we need to pre-allocate array of all possible digits.
Then on each step we need to get appropriate digit number from array and remove it from array.

``` go

func getPermutation(n int, k int) string {
    k--
    var digits []byte
    for i := 1; i <= n; i++ {
        digits = append(digits, '0' + byte(i))
    }

    var out []byte
    for i, j := fact(n), n; j > 1; j-- {
        m := i / j
        d := k / m
        out = append(out, digits[d])
        k -= d * m
        digits = remove(digits, d)
        i = m
    }

    out = append(out, digits...)
    return string(out)
}

func remove(arr []byte, i int) []byte {
    return append(arr[:i], arr[i+1:]...)
}

func fact(n int) int {
    if n == 1 {
        return n
    }
    return n * fact(n-1)
}
```

Performance of this solution is:
```
Runtime: 0 ms, faster than 100.00% of Go online submissions for Permutation Sequence.
Memory Usage: 2 MB, less than 91.84% of Go online submissions for Permutation Sequence.
```
