+++
date = "2020-04-23"
title = "Bitwise AND of Numbers Range"
slug = "Bitwise AND of Numbers Range"
tags = []
categories = []
+++

## Introduction

Given a range [m, n] where 0 <= m <= n <= 2147483647, return the bitwise AND of all numbers in this range, inclusive.

Example 1:

Input: [5,7]
Output: 4
Example 2:

Input: [0,1]
Output: 0

## Solution

Let's first solve this task with brute force method:

``` go
func rangeBitwiseAndBF(m int, n int) int {

	if m > n {
		return 0
	}

	val := m
	for i := m+1; i <= n; i++ {
		val &= i
	}

	return val
}
```

This is far away from optimal method, therefore we need to find better solution.
Looks like the task needs to work with bits and we need to implement bitwise operation.

Let's first create a unit test to prove that we cover all corner cases:

``` go
func main() {

	rand.Seed(time.Now().UnixNano())

	for i := 0; i < 100; i++ {
		m := rand.Intn(1000)
		n := rand.Intn(1000)

		if m > n {
			m,n = n,m
		}

		f := rangeBitwiseAnd(m, n)
		s := rangeBitwiseAndBF(m, n)

		if f != s {
			fmt.Printf("m=%d, n=%d, f=%d, s=%d\n", m, n, f, s)
		}

	}
}
```

Now, when we have a loop of random test, we can start implementing bitwise operation.
We would need to create a stat machine with two states, before meeting two ones and after.
We also need to go from bigger bit to lower bit, and limit of 32 bits would help here.

So, final solution is this one:
``` go
func rangeBitwiseAnd(m int, n int) int {

	first := true
	res := 0
	for i := 31; i >= 0; i-- {
		bit := 1 << i
		mBit := m & bit > 0
		nBit := n & bit > 0

		if first {
			if nBit != mBit {
				return 0
			}
			if mBit && nBit {
				res |= bit
				first = false
			}
		} else {
			if mBit == nBit {
				if mBit {
					res |= bit
				}
			} else {
				break
			}
		}
	}

	return res
}
```

This solution is O(32).
