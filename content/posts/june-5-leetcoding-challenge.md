+++
date = "2020-06-05"
title = "Random Pick with Weight"
slug = "june 5 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an array w of positive integers, where w[i] describes the weight of index i, write a function pickIndex which randomly picks an index in proportion to its weight.

Note:
```
1 <= w.length <= 10000
1 <= w[i] <= 10^5
pickIndex will be called at most 10000 times.
```

Example 1:

Input:
```
["Solution","pickIndex"]
[[[1]],[]]
Output: [null,0]
```

Example 2:

Input:
```
["Solution","pickIndex","pickIndex","pickIndex","pickIndex","pickIndex"]
[[[1,3]],[],[],[],[],[]]
Output: [null,0,1,1,1,0]
```

Explanation of Input Syntax:
```
The input is two lists: the subroutines called and their arguments. Solution's constructor has one argument, the array w. pickIndex has no arguments. Arguments are always wrapped with a list, even if there aren't any.
```

## Solution

Binary search could be the fastest solution in this case.
We also need to ignore numbers with weight 0.

``` go
import "math/rand"

type Solution struct {
	sums []int
	idx []int
	total int
}


func Constructor(w []int) Solution {
	var sums []int
	var idx []int
	total := 0
	for i, weight := range w {
		if weight > 0 {
			total += weight
			sums = append(sums, total)
			idx = append(idx, i)
		}
	}
	return Solution { sums, idx, total }
}


func (t *Solution) PickIndex() int {
	target := rand.Intn(t.total)+1
	lo, hi := 0, len(t.sums)
	for lo < hi {
		mi := (hi - lo) / 2 + lo
		if target <= t.sums[mi] {
			hi = mi
		} else {
			lo = mi+1
		}
	}
	return t.idx[lo]
}


/**
 * Your Solution object will be instantiated and called as such:
 * obj := Constructor(w);
 * param_1 := obj.PickIndex();
 */
```

Performance of this solution is:
```
Runtime: 48 ms
Memory Usage: 7.9 MB
```
