+++
date = "2019-08-23"
title = "Regular Expression Matching"
slug = "Regular Expression Matching"
tags = []
categories = []
+++

## Introduction

Given an input string (s) and a pattern (p), implement regular expression matching with support for '.' and '*'.

```
'.' Matches any single character.
'*' Matches zero or more of the preceding element.
```

The matching should cover the entire input string (not partial).

Note:
```
s could be empty and contains only lowercase letters a-z.
p could be empty and contains only lowercase letters a-z, and characters like . or *.
```

Example 1:
```
Input:
s = "aa"
p = "a"
Output: false
Explanation: "a" does not match the entire string "aa".
```

Example 2:
```
Input:
s = "aa"
p = "a*"
Output: true
Explanation: '*' means zero or more of the preceding element, 'a'. Therefore, by repeating 'a' once, it becomes "aa".
```

Example 3:
```
Input:
s = "ab"
p = ".*"
Output: true
Explanation: ".*" means "zero or more (*) of any character (.)".
```

Example 4:
```
Input:
s = "aab"
p = "c*a*b"
Output: true
Explanation: c can be repeated 0 times, a can be repeated 1 time. Therefore, it matches "aab".
```

Example 5:
```
Input:
s = "mississippi"
p = "mis*is*p*."
Output: false
```

### Solution

Let's try to solve this problem by using brute force method and recursion.
In this case we need to create functional style implementation that will reduce task on each iteration. 
Golang with slice support perfectly fits to this approach.

Here what we have:
``` go
func isMatch(s string, p string) bool {

	n, m := len(s), len(p)
	if m == 0 {
		return n == 0
	}
	if m > 1 && p[1] == '*' {

		if isMatch(s, p[2:]) {
			return true
		}

		for i := 0; i < n && (s[i] == p[0] || p[0] == '.'); i++ {
			if isMatch(s[i+1:], p[2:]) {
				return true
			}
		}
	} else if n >= 1 && m >= 1 && (s[0] == p[0] || p[0] == '.') {
		return isMatch(s[1:], p[1:])
	}
	return false
}
```

On each iteration we need to check wildcard asterix in order to pick up zero or more matching characters, 
kind of options and check validity of them.

This altorithm works fine, and gives 8ms execution time, but let's improve performance by using taking in account that tail could be invoked multiple times, 
therefore caching could improve overal performance.




