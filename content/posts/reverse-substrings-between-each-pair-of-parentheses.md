+++
date = "2019-09-19"
title = "Reverse Substrings Between Each Pair of Parentheses"
slug = "Reverse Substrings Between Each Pair of Parentheses"
tags = []
categories = []
+++

## Introduction

Reverse Substrings Between Each Pair of Parentheses

You are given a string s that consists of lower case English letters and brackets. 

Reverse the strings in each pair of matching parentheses, starting from the innermost one.

Your result should not contain any brackets.

 

Example 1:
```
Input: s = "(abcd)"
Output: "dcba"
```

Example 2:
```
Input: s = "(u(love)i)"
Output: "iloveu"
Explanation: The substring "love" is reversed first, then the whole string is reversed.
```

Example 3:
```
Input: s = "(ed(et(oc))el)"
Output: "leetcode"
Explanation: First, we reverse the substring "oc", then "etco", and finally, the whole string.
```

Example 4:
```
Input: s = "a(bcdefghijkl(mno)p)q"
Output: "apmnolkjihgfedcbq"
```
 

Constraints:
```
    0 <= s.length <= 2000
    s only contains lower case English characters and parentheses.
    It's guaranteed that all parentheses are balanced.
```

### Solution

```go
func reverseParentheses(s string) string {
    runes := []rune(s)
    q := []int{}
    for i, r := range runes {
        if r == '(' {
            q = append(q, i)
        } else if r == ')' && len(q) > 0 {
            m := len(q)-1
            openIdx := q[m]
            q = q[:m]
            reverse(runes[openIdx:i])
        }
    }
    var out strings.Builder
    for _, r := range runes {
        if r != '(' && r != ')' {
            out.WriteRune(r)
        }
    }
    return out.String()
}

func reverse(runes []rune) {
    n := len(runes)
    for i, j := 0, n-1; i < j; i, j = i+1, j-1 {
        runes[i], runes[j] = runes[j], runes[i]
    }
}
```

### Description

The simple solution could be to revert inner sub-string each time when we meet closing bracket.
After that we need to cleanup brackets.

Some optimizations could be added for repeated brackets `(())` to avoid double reverting.


