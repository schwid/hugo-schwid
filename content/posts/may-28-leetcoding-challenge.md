+++
date = "2020-05-28"
title = "Counting Bits"
slug = "may 28 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a non negative integer number num. For every numbers i in the range 0 ≤ i ≤ num calculate the number of 1's in their binary representation and return them as an array.

Example 1:
```
Input: 2
Output: [0,1,1]
```

Example 2:
```
Input: 5
Output: [0,1,1,2,1,2]
```

Follow up:

It is very easy to come up with a solution with run time O(n*sizeof(integer)). But can you do it in linear time O(n) /possibly in a single pass?
Space complexity should be O(n).

## Solution

There is very easy solution based on internal golang function `bits.OnesCount`, let's use it as example:

``` go
import "math/bits"

func countBits(num int) []int {
    out := make([]int, num+1)
    out[0] = 0
    for i := 1; i <= num; i++ {
        out[i] = bits.OnesCount(uint(i))
    }
    return out
}
```

Performance of this reference solution is:
```
Runtime: 4 ms
Memory Usage: 4.4 MB
```

Let's try to improve it by using calculation methods.

``` go
func countBits(num int) []int {
    out := make([]int, num+1)
    out[0] = 0
    for j := 1; j <= num; j <<= 1 {
        for i := 0; i < j && i+j <= num; i++ {
            out[i+j] = out[i] + 1
        }
    }
    return out
}
```

Performance is the same
```
Runtime: 4 ms
Memory Usage: 4.4 MB
```
