+++
date = "2019-05-16"
title = "Find the Closest Palindrome"
slug = "Find the Closest Palindrome"
tags = []
categories = []
+++

## Introduction

Given an integer n, find the closest integer (not including itself), which is a palindrome.

The 'closest' is defined as absolute difference minimized between two integers.

Example 1:
```
Input: "123"
Output: "121"
```
Note:
```
The input n is a positive integer represented by string, whose length will not exceed 18.
If there is a tie, return the smaller one as answer.
```

### Solution

Golang:
``` go
func nearestPalindromic(S string) string {
    
    value := toInt(S)
    
    P := Palindrom(S)
    p := toInt(P)
    
    n := len(S)
    scale := Pow(10, n/2)
    
    LS := PalindromInt( (value/scale) * scale - 1 )
    ls := toInt(LS)
    
    GT := PalindromInt( (value/scale + 1) * scale )
    gt := toInt(GT)
    
    if abs(ls - value) <= abs(gt - value) {
  
        if P == S || abs(ls - value) <= abs(p - value) {
            return LS
        } else {
            return P
        }
        
    } else {
        
        if P == S || abs(gt - value) < abs(p - value) {
            return GT
        } else {
            return P
        }
    }
    
}

func toInt(s string) int {
    value, _ := strconv.ParseInt(s, 10, 64)
    return int(value)
}

func abs(a int) int {
    if a < 0 {
        return -a
    } else {
        return a
    }
}

func Pow(base, exp int) int {
    v := 1
    for i := 1; i <= exp; i++ {
        v *= base
    }
    return v
}

func PalindromInt(val int) string {
    s := strconv.FormatInt(int64(val), 10)
    return Palindrom(s)
}

func Palindrom(s string) string {
    runes := []rune(s)
    for i, j := 0, len(runes)-1; i < j; i, j = i+1, j-1 {
        runes[j] = runes[i]
    }
    return string(runes)
}
```

### Explanation

This problem could be solved by creating polindrome from current value, from value with decremented mid, from value with incremented mid. Mid element is the middle element in number.
We need to select min from abs diffs of all cases, by keeping in mind that input value can be polindrome as well.

