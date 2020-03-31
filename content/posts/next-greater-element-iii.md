+++
date = "2020-03-31"
title = "Next Greater Element III"
slug = "Next Greater Element III"
tags = []
categories = []
+++

## Introduction

Given a positive 32-bit integer n, you need to find the smallest 32-bit integer which has exactly the same digits existing in the integer n and is greater in value than n. If no such positive 32-bit integer exists, you need to return -1.

Example 1:
```
Input: 12
Output: 21
```
 

Example 2:
```
Input: 21
Output: -1
```

### Solution

Let's try to solve this problem by using permutations. It is easy but not the fastest solution.

``` go
import "strconv"
import "math"

func nextGreaterElement(n int) int {

	p := []rune(strconv.Itoa(n))

	min_el := -1
	min_diff := math.MaxInt64

	perm(p, func(test []rune) {

		next := FastParseInt(test)
		diff := next - n
		if diff > 0 && diff < min_diff && next <= math.MaxInt32 {
			min_el = next
			min_diff = diff
		}

	}, 0, len(p))

	return min_el
}

func perm(a []rune, f func([]rune), i, n int) {
	if i > n {
		f(a)
		return
	}
	perm(a, f, i+1, n)
	for j := i + 1; j < n; j++ {
		a[i], a[j] = a[j], a[i]
		perm(a, f, i+1, n)
		a[i], a[j] = a[j], a[i]
	}
}

func FastParseInt(s []rune) int {
	n := 0
	for _, ch := range s {
		ch -= '0'
		if ch > 9 {
			return 0
		}
		n = n*10 + int(ch)
	}
	return n
}
```
