+++
date = "2020-04-09"
title = "Backspace String Compare"
slug = "Backspace String Compare"
tags = []
categories = []
+++

## Introduction

Given two strings S and T, return if they are equal when both are typed into empty text editors. # means a backspace character.

Example 1:
```
Input: S = "ab#c", T = "ad#c"
Output: true
Explanation: Both S and T become "ac".
```

Example 2:
```
Input: S = "ab##", T = "c#d#"
Output: true
Explanation: Both S and T become "".
```

Example 3:
```
Input: S = "a##c", T = "#a#c"
Output: true
Explanation: Both S and T become "c".
```

Example 4:
```
Input: S = "a#c", T = "b"
Output: false
Explanation: S becomes "c" while T becomes "b".
```

Note:
```
1 <= S.length <= 200
1 <= T.length <= 200
S and T only contain lowercase letters and '#' characters.
```
Follow up:

* Can you solve it in O(N) time and O(1) space?


## Solution

It is possible to compare strings backward, in this case it is easy to trim backspace control characters on each step.
At the end we need to trim additional time, because one of the string can have 'aaa###' or similar prefix.

``` go
func backspaceCompare(S string, T string) bool {
    n, m := len(S), len(T)
    i, j := n-1, m-1
    for i >= 0 && j >= 0 {
        i = trimBackward(S, i)
        j = trimBackward(T, j)
        if i >= 0 && j >= 0 {
            if S[i] != T[j] {
                return false
            } else {
                i--
                j--
            }
        }
    }
    i = trimBackward(S, i)
    j = trimBackward(T, j)
    return i == -1 && j == -1
}

func trimBackward(s string, i int) int {
    b := 0
    for i >= 0 {
        if s[i] == '#' {
            b++
            i--
        } else if b > 0 {
            b--
            i--
        } else {
            break
        }
    }
    return i
}
```
