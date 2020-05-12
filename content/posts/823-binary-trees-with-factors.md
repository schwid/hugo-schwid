+++
date = "2020-05-11"
title = "Binary Trees With Factors"
slug = "823. Binary Trees With Factors"
tags = []
categories = []
+++

## Introduction

Given an array of unique integers, each integer is strictly greater than 1.

We make a binary tree using these integers and each number may be used for any number of times.

Each non-leaf node's value should be equal to the product of the values of it's children.

How many binary trees can we make?  Return the answer modulo 10 ** 9 + 7.

Example 1:

Input: A = [2, 4]
Output: 3
Explanation: We can make these trees: [2], [4], [4, 2, 2]
Example 2:

Input: A = [2, 4, 5, 10]
Output: 7
Explanation: We can make these trees: [2], [4], [5], [10], [4, 2, 2], [10, 2, 5], [10, 5, 2].


Note:
```
1 <= A.length <= 1000.
2 <= A[i] <= 10 ^ 9.
```

## Solution

This is combinatorics task for building binary trees.
The catch here is that any tree can be reused in other trees, therefore I decided to use enterprise way to build lazy calculations trees with basic operations like Cache, Add, Product and get value from cache.

``` go
type Op interface {
	Get() int
}

type One struct {
}

func (t *One) Get() int {
	return 1
}

type Cache struct {
	val   int
	lazy  Op
}

func (t *Cache) Get() int {
	if t.val == 0 {
		t.val = t.lazy.Get()
	}
	return t.val
}

type Add struct {
	a  Op
	b  Op
}

func (t *Add) Get() int {
	return t.a.Get() + t.b.Get()
}

type Product struct {
	a  Op
	b  Op
}

func (t *Product) Get() int {
	return t.a.Get() * t.b.Get()
}

type Eval struct {
	call  func() int
}

func (t *Eval) Get() int {
	return t.call()
}

func numFactoredBinaryTrees(A []int) int {
	n := len(A)
	if n == 0 {
		return 0
	}
	sort.Ints(A)

	one := &One{}

	maxNum := A[n-1]
	cache := make(map[int]Op)

	for i := 0; i < n; i++ {
		cache[A[i]] = one
	}
	for i := 0; i < n; i++ {
		for j := 0; j < n; j++ {
			p := A[i] * A[j]
			if p > maxNum {
				break
			}
			if op, ok := cache[p]; ok {
				a := A[i]
				b := A[j]
				product := &Product{
					&Eval{
						func() int {
							return cache[a].Get()
						},
					},
					&Eval{func() int {
							return cache[b].Get()
						},
					},
				}
				cache[p] = &Cache{lazy: &Add{ product, op} }
			}
		}
	}
	total := 0
	mod := 1000000000 + 7
	for _, v := range cache {
		total += v.Get()
		total %= mod
	}
	return total
}
```


## Preformance

```
Runtime: 20 ms
Memory Usage: 6.1 MB
```

Let's simplify this code by removing the lazy computations and use the dynamic programming.

``` go
func numFactoredBinaryTrees(A []int) int {
	n := len(A)
	if n == 0 {
		return 0
	}
	sort.Ints(A)

	cache := make(map[int]int)
	for i := 0; i < n; i++ {
		cache[A[i]] = 1
	}

	for p := 0; p < n; p++ {
		for j := 0; j <= p; j++ {
			if A[p] % A[j] == 0 {
        i := A[p] / A[j]
				if cnt, ok := cache[i]; ok {
					cache[A[p]] += cache[A[j]] * cnt
				}
      }
		}
	}
	total := 0
	mod := 1000000000 + 7
	for _, v := range cache {
		total += v
		total %= mod
	}
	return total
}
```

This code is much more simple, but performance is not better:

```
Runtime: 48 ms, faster than 100.00% of Go online submissions for Binary Trees With Factors.
Memory Usage: 3.8 MB, less than 100.00% of Go online submissions for Binary Trees With Factors.
```

I think performance is not good, because of too many golang map operation in the loop.
