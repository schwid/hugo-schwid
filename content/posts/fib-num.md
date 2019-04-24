+++
date = "2019-04-23"
title = "Fibonacci Number"
slug = "Fibonacci Number"
tags = []
categories = []
+++

## Introduction

The Fibonacci numbers, commonly denoted F(n) form a sequence, called the Fibonacci sequence, such that each number is the sum of the two preceding ones, starting from 0 and 1. That is,

```
F(0) = 0,   F(1) = 1
F(N) = F(N - 1) + F(N - 2), for N > 1.
Given N, calculate F(N).
```


Example 1:
```
Input: 2
Output: 1
Explanation: F(2) = F(1) + F(0) = 1 + 0 = 1.
```
Example 2:
```
Input: 3
Output: 2
Explanation: F(3) = F(2) + F(1) = 1 + 1 = 2.
```
Example 3:
```
Input: 4
Output: 3
Explanation: F(4) = F(3) + F(2) = 2 + 1 = 3.
```

### Solution

One-loop solution:
``` go
func fib(N int) int {
    if N <= 1 {
        return N
    }
    T := make([]int, N+1)
    T[0] = 0
    T[1] = 1
    for i := 2; i <= N; i++ {
        T[i] = T[i-1] + T[i-2]
    }
    return T[N]
}
```

Without array solution:
``` go
func fib(N int) int {
    if N <= 1 {
        return N
    }
    Tim2 := 0
    Tim1 := 1
    Ti := 0
    for i := 2; i <= N; i++ {
        Ti = Tim1 + Tim2

        Tim2 = Tim1
        Tim1 = Ti
    }
    return Ti
}
```

### Explanation

In order to calculate Fibonacci number we need to know previous number and number before previous.
Let's store them in the array to speedup calculations.
This solution could be optimized by replacing array with 2 variables.
