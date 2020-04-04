+++
date = "2020-04-04"
title = "Happy Number"
slug = "Happy Number"
tags = []
categories = []
+++

## Introduction

Write an algorithm to determine if a number is "happy".

A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.

Example:
```
Input: 19
Output: true
```

Explanation:
```
12 + 92 = 82
82 + 22 = 68
62 + 82 = 100
12 + 02 + 02 = 1
```

## Solution

Let's create a map of visited numbers to avoid the infinity loop.

``` go
func isHappy(n int) bool {
  visited := make(map[int]bool)
	for !visited[n] {
		if n == 1 {
			return true
		}
        visited[n] = true
		n = next(n)
	}
	return false
}

func next(n int) int {
	sum := 0
	for v := n; v > 0; v /= 10 {
		digit := v % 10
		sum += digit * digit
	}
	return sum
}
```
