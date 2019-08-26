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

``` go

func isMatch(s string, p string) bool {
    cache := make(map[string]bool)
    return isMatchCache(cache, s, p)
}

func isMatchCache(cache map[string]bool, s string, p string) bool {
    
    key := s + ":" + p
    
    if v, ok := cache[key]; ok {
        return v
    }
    
    ret := isMatchRec(cache, s, p) 
    cache[key] = ret
    
    return ret
}

func isMatchRec(cache map[string]bool, s string, p string) bool {

	n, m := len(s), len(p)
	if m == 0 {
		return n == 0
	}
	if m > 1 && p[1] == '*' {

		if isMatchCache(cache, s, p[2:]) {
			return true
		}

		for i := 0; i < n && (s[i] == p[0] || p[0] == '.'); i++ {
			if isMatchCache(cache, s[i+1:], p[2:]) {
				return true
			}
		}
	} else if n >= 1 && m >= 1 && (s[0] == p[0] || p[0] == '.') {
		return isMatchCache(cache, s[1:], p[1:])
	}
	return false
}
```

Recursion with caching gave the same 8ms in performance, it looks like requests are distributed ramdomly and there is no much gain in caching. Let's try another approach.

Let's simplify code in function style and get this simple solution
``` go
func isMatch(s string, p string) bool {
    n, m := len(s), len(p)
    if m == 0 {
        return n == 0
    }
    matchFirst := n > 0 && (s[0] == p[0] || p[0] == '.')
    if m > 1 && p[1] == '*' {
        return isMatch(s, p[2:]) || (matchFirst && isMatch(s[1:], p))
    } else {
        return matchFirst && isMatch(s[1:], p[1:])
    }
}
```

It gives 12ms for execution time on Golang. 

The same implementation on Java with slice simulation `(i, n, j, m)`:
``` java
class Solution {
    public boolean isMatch(String text, String pattern) {
        return isMatchRec(text, 0, text.length(), pattern, 0, pattern.length());
    }
    public static boolean isMatchRec(String text, int i, int n, String pattern, int j, int m) {
        if (m-j == 0) {
            return n-i == 0;
        }
        boolean matchFirst = (n-i > 0 && (text.charAt(i) == pattern.charAt(j) || pattern.charAt(j) == '.'));
        if (m-j > 1 && pattern.charAt(j+1) == '*') {
            return isMatchRec(text, i, n, pattern, j+2, m) || (matchFirst && isMatchRec(text, i+1, n, pattern, j, m));
        } else {
            return matchFirst && isMatchRec(text, i+1, n, pattern, j+1, m);
        }
    }
}
```

Gives also 12ms! This is amazing result that shows both language processing similarity with the same code!
But if you implements Java version with strings:

``` java
class Solution {
    public boolean isMatch(String text, String pattern) {
        if (pattern.isEmpty()) {
            return text.isEmpty();
        }
        boolean matchFirst = (!text.isEmpty() && (pattern.charAt(0) == text.charAt(0) || pattern.charAt(0) == '.'));
        if (pattern.length() > 1 && pattern.charAt(1) == '*'){
            return (isMatch(text, pattern.substring(2)) ||
                    (matchFirst && isMatch(text.substring(1), pattern)));
        } else {
            return matchFirst && isMatch(text.substring(1), pattern.substring(1));
        }
    }
}
```

You will get 55ms execution time. Slice approach in golang gives ability to write simple readable code similar to strings operation code, but keeping performance in the level for index access of data.





This is slower then going through options in iterative method, that gives ideas for optimizations. Functional style of programming is actively using stack, and someetimes this approach is expensive.
Let's try totaly imperative style solution.

Let's see the Python version of the same problem:

``` python
class Solution:
    def isMatch(self, s: str, p: str) -> bool:
        n, m = len(s), len(p)
        if m == 0:
            return n == 0
        matchFirst = n > 0 and (s[0] == p[0] or p[0] == '.')
        if m > 1 and p[1] == '*':
            return self.isMatch(s, p[2:]) or (matchFirst and self.isMatch(s[1:], p))
        else:
            return matchFirst and self.isMatch(s[1:], p[1:])
        
```

It is very easy to transform golang solution to Python by replacing `and` and `or` operations and brackets.

Performance is 1448ms, that is significantly bigger than Golang or Java.



