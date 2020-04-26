+++
date = "2020-04-14"
title = "Perform String Shifts"
slug = "14 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You are given a string s containing lowercase English letters, and a matrix shift, where shift[i] = [direction, amount]:

direction can be 0 (for left shift) or 1 (for right shift).
amount is the amount by which string s is to be shifted.
A left shift by 1 means remove the first character of s and append it to the end.
Similarly, a right shift by 1 means remove the last character of s and add it to the beginning.
Return the final string after all operations.


Example 1:
```
Input: s = "abc", shift = [[0,1],[1,2]]
Output: "cab"
Explanation:
[0,1] means shift to left by 1. "abc" -> "bca"
[1,2] means shift to right by 2. "bca" -> "cab"
```

Example 2:
```
Input: s = "abcdefg", shift = [[1,1],[1,1],[0,2],[1,3]]
Output: "efgabcd"
Explanation:  
[1,1] means shift to right by 1. "abcdefg" -> "gabcdef"
[1,1] means shift to right by 1. "gabcdef" -> "fgabcde"
[0,2] means shift to left by 2. "fgabcde" -> "abcdefg"
[1,3] means shift to right by 3. "abcdefg" -> "efgabcd"
```

Constraints:
```
1 <= s.length <= 100
s only contains lower case English letters.
1 <= shift.length <= 100
shift[i].length == 2
0 <= shift[i][0] <= 1
0 <= shift[i][1] <= 100
```

## Solution

As we know the right shift is the left shift `n-i`. Just because it is the ring.
Therefore, we can accumulate all operations and represent them as a single final left shift, because it is easy to implement with golang slices.

``` go
func stringShift(s string, shift [][]int) string {
	n := len(s)
	cnt := 0
	for _, op := range shift {
		switch op[0] {
		case 0:
			cnt += op[1]
		case 1:
			cnt += n - op[1]
		default:
		}
		cnt %= n
	}
	return s[cnt:] + s[:cnt]
}
```
