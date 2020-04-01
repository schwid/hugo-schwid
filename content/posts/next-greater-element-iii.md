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

Another way to solve this problem is to find the sub-problem and solution for gready algorithm.
As we know the next greatest number we can get if we switch the min visited digits to first smaller one if we go from right to left. Here is the algorithm:

``` go
import (
	"math"
	"sort"
	"strconv"
)

type RuneSlice []rune

func (p RuneSlice) Len() int           { return len(p) }
func (p RuneSlice) Less(i, j int) bool { return p[i] < p[j] }
func (p RuneSlice) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }


func nextGreaterElement(n int) int {

	b := []rune(strconv.Itoa(n))

	if len(b) == 0 {
		return -1
	}

	l := len(b)
	for i := l-1; i >= 0; i-- {

        j := findGreaterMin(b, i+1, b[i])
        if j != -1 {
            b[j], b[i] = b[i], b[j]
            sort.Sort(RuneSlice(b[i+1:]))
            v, _ := strconv.Atoi(string(b))
            if v > math.MaxInt32 {
                v = -1
            }
            return v
        }
        
	}

	return -1
}

func findGreaterMin(b []rune, offset int, target rune) int {
    min := -1
    for i := offset; i < len(b); i++ {
        if b[i] > target {
            if min == -1 || b[min] > b[i] {
                min = i
            } 
        }
    }
    return min
}
```

This algorithm is using rune array, so therefore I had to copy-past standard IntSlice in to RuneSlice to make sort working. No need to solve the sort yet another time and I think it is more clear as it is. The goal of this task to show the gready algorithm solution.


Performance metrics:
```
Runtime: 0 ms, faster than 100.00% of Go online submissions for Next Greater Element III.
Memory Usage: 2 MB, less than 50.00% of Go online submissions for Next Greater Element III.
```
