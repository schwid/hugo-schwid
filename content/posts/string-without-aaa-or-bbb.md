+++
date = "2019-05-15"
title = "String Without AAA or BBB"
slug = "String Without AAA or BBB"
tags = []
categories = []
+++

## Introduction

Given two integers A and B, return any string S such that:
```
S has length A + B and contains exactly A 'a' letters, and exactly B 'b' letters;
The substring 'aaa' does not occur in S;
The substring 'bbb' does not occur in S.
```

Example 1:
```
Input: A = 1, B = 2
Output: "abb"
Explanation: "abb", "bab" and "bba" are all correct answers.
```

Example 2:
```
Input: A = 4, B = 1
Output: "aabaa"
```

Note:
```
0 <= A <= 100
0 <= B <= 100
It is guaranteed such an S exists for the given A and B.
```

### Solution

State machine solution:
``` go
func strWithout3a3b(A int, B int) string {
    
    var sb strings.Builder

    lastA, lastB := 0, 0
    
    for i, j := 0, 0; i < A || j < B; {
        
        if (A - i >= B - j && lastA < 2) || lastB == 2 {
            sb.WriteRune('a')
            i++
            lastA++
            lastB = 0
        } else {
            sb.WriteRune('b')
            j++
            lastA = 0
            lastB++
        } 
        
    }
    
    return sb.String()
}
```

### Explanation

Lets keep track counters for last generated `a`-s and last generated `b`-s. It is not difficult to build a simple statemachine that will check 
switch time-to-time from a generation to b generation.
