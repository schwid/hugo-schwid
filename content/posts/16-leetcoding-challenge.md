+++
date = "2020-04-16"
title = "Valid Parenthesis String"
slug = "Valid Parenthesis String"
tags = []
categories = []
+++

## Introduction

```
Given a string containing only three types of characters: '(', ')' and '*', write a function to check whether this string is valid. We define the validity of a string by these rules:
Any left parenthesis '(' must have a corresponding right parenthesis ')'.
Any right parenthesis ')' must have a corresponding left parenthesis '('.
Left parenthesis '(' must go before the corresponding right parenthesis ')'.
'*' could be treated as a single right parenthesis ')' or a single left parenthesis '(' or an empty string.
An empty string is also valid.
```
Example 1:
```
Input: "()"
Output: True
```

Example 2:
```
Input: "(*)"
Output: True
```

Example 3:
```
Input: "(*))"
Output: True
```

Note:
The string size will be in the range [1, 100].

## Solution

We can solve this task by the simple recursion method by calling all possible combinations.
This is not effective, but very simple solution.

``` go
func checkValidStringR(s string, i, n, cnt int) bool {
    for ;i < n; i++ {
        if s[i] == '(' {
            cnt++
        } else if s[i] == ')' {
            if cnt == 0 {
                return false
            }
            cnt--
        } else if s[i] == '*' {
            if cnt == 0 {
                if checkValidStringR(s, i+1, n, cnt+1) {
                    return true
                }
            } else {
                // two options
                if checkValidStringR(s, i+1, n, cnt+1) || checkValidStringR(s, i+1, n, cnt-1) {
                    return true
                }
            }
        }
    }
    return cnt == 0
}

func checkValidString(s string) bool {
    return checkValidStringR(s, 0, len(s), 0)
}
```

This recursion method is kind of DFS implementation, because it looks in leaf nodes first.
We can rewrite this code in to classical DFS.

``` go
func dfs(s string, cnt int) bool {
    for i, ch := range s {
        switch ch {
            case '(':
                cnt++
            case ')':
                if cnt == 0 {
                    return false
                }
                cnt--
            case '*':
                if cnt == 0 {
                    // only left
                    if dfs(s[i+1:], cnt+1) {
                        return true
                    }
                } else {
                    // left and right
                    if dfs(s[i+1:], cnt+1) || dfs(s[i+1:], cnt-1) {
                        return true
                    }
                }
        }
    }
    return cnt == 0
}

func checkValidString(s string) bool {
    return dfs(s, 0)
}
```

Logic of dfs is the same, but different notation.

Let's rewrite this task from dfs recursion in to dfs queue.

``` go
type Item struct {
    offset   int
    cnt      int
}

func checkValidString(s string) bool {
	n := len(s)
	q := []Item { Item{0, 0} }
	for len(q) > 0 {

		last := len(q)-1
		item := q[last]
		q = q[:last]

		cnt := item.cnt
		valid := true
		for i := item.offset; valid && i < n; i++ {
			switch s[i] {
			case '(':
				cnt++
			case ')':
				if cnt == 0 {
					valid = false
					break
				}
				cnt--
			case '*':
				q = append(q, Item{i+1, cnt+1})
				if cnt > 0 {
					q = append(q, Item{i+1, cnt-1})
				}

			}
		}

		if valid && cnt == 0 {
			return true
		}
	}

	return false
}
```

The performance of DFS with queue is Runtime: 220 ms.
Let's rewrite to BFS and see the difference.
BFS gave Runtime: 348 ms.

But it is a very small code change:
``` go

type Item struct {
    offset   int
    cnt      int
}

func checkValidString(s string) bool {
	n := len(s)
	q := []Item { Item{0, 0} }
	for len(q) > 0 {

		item := q[0]
        q = q[1:]

		cnt := item.cnt
		valid := true
		for i := item.offset; valid && i < n; i++ {
			switch s[i] {
			case '(':
				cnt++
			case ')':
				if cnt == 0 {
					valid = false
					break
				}
				cnt--
			case '*':
				q = append(q, Item{i+1, cnt+1})
				if cnt > 0 {
					q = append(q, Item{i+1, cnt-1})
				}

			}
		}

		if valid && cnt == 0 {
			return true
		}
	}

	return false
}
```

Instead of taking last element in queue, we got the first one.

What is the performance of DFS recursion? Runtime: 148 ms
And performance of recursion without DFS is Runtime: 140 ms.

Another way to solve this problem it to keep in queue only counter options.
In this case we have benefit of execution, because on asterix step we have ability
to merge the same counters and significantly decrease computation steps.

Here it is:
``` go
func checkValidString(s string) bool {
	n := len(s)
	options := []int { 0 }
	for i := 0; i < n; i++ {
		switch s[i] {
		case '(':
			options = increment(options)
		case ')':
			options = decrement(options)
			if len(options) == 0 {
				return false
			}
		case '*':
			options = expand(options)
		}
	}
	return hasZero(options)
}

func hasZero(opt []int) bool {
	n := len(opt)
	for i := 0; i < n; i++ {
		if opt[i] == 0 {
			return true
		}
	}
	return false
}

func increment(opt []int) []int {
	n := len(opt)
	for i := 0; i < n; i++ {
		opt[i]++
	}
	return opt
}

func decrement(opt []int) []int {
	n := len(opt)
	out := make([]int, 0, n)
	for i := 0; i < n; i++ {
		if opt[i] > 0 {
			out = append(out, opt[i]-1)
		}
	}
	return out
}

func expand(opt []int) []int {
	n := len(opt)
	cache := make(map[int]bool)
	for i := 0; i < n; i++ {
		cache[opt[i]] = true
		cache[opt[i]+1] = true
		if opt[i] > 0 {
			cache[opt[i]-1] = true
		}
	}
	out := make([]int, 0, len(cache))
	for o, _ := range cache {
		out = append(out, o)
	}
	return out
}
```

This solution gives runtime 0ms. The best one.

So, now we have all performance metrics:
* Classical recursion C-style algorithm: 140ms
* DFS recursion with slices: 148ms
* DFS with queue: 220 ms
* BFS with queue: 348 ms
* Counter options: 0ms
