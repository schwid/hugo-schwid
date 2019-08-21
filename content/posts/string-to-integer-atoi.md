+++
date = "2019-08-21"
title = "String to Integer (atoi)"
slug = "String to Integer (atoi)"
tags = []
categories = []
+++

## Introduction

mplement atoi which converts a string to an integer.

The function first discards as many whitespace characters as necessary until the first non-whitespace character is found. Then, starting from this character, takes an optional initial plus or minus sign followed by as many numerical digits as possible, and interprets them as a numerical value.

The string can contain additional characters after those that form the integral number, which are ignored and have no effect on the behavior of this function.

If the first sequence of non-whitespace characters in str is not a valid integral number, or if no such sequence exists because either str is empty or it contains only whitespace characters, no conversion is performed.

If no valid conversion could be performed, a zero value is returned.

Note:

Only the space character ' ' is considered as whitespace character.
Assume we are dealing with an environment which could only store integers within the 32-bit signed integer range: [−231,  231 − 1]. If the numerical value is out of the range of representable values, INT_MAX (231 − 1) or INT_MIN (−231) is returned.
Example 1:
```
Input: "42"
Output: 42
```
Example 2:
```
Input: "   -42"
Output: -42
Explanation: The first non-whitespace character is '-', which is the minus sign.
             Then take as many numerical digits as possible, which gets 42.
```
Example 3:
```
Input: "4193 with words"
Output: 4193
Explanation: Conversion stops at digit '3' as the next character is not a numerical digit.
```
Example 4:
```
Input: "words and 987"
Output: 0
Explanation: The first non-whitespace character is 'w', which is not a numerical 
             digit or a +/- sign. Therefore no valid conversion could be performed.
```
Example 5:
```
Input: "-91283472332"
Output: -2147483648
Explanation: The number "-91283472332" is out of the range of a 32-bit signed integer.
             Thefore INT_MIN (−231) is returned.
```

### Solution
``` go
func myAtoi(str string) int {
    
    val := uint(0)
    state, sign := 0, 1
    for _, ch := range str {
        Again:
        switch state {
        case 0:
            if ch != ' ' {
                state = 1
                goto Again
            }
        case 1:
            if ch == '-' {
                sign = -1
                state = 2
            } else if ch == '+' {
                sign = 1
                state = 2 
            } else {
                state = 2 
                goto Again
            }
        case 2:
            if ch >= '0' && ch <= '9' {
                val *= 10
                val += uint(ch - '0')
                if sign == -1 && -int(val) < math.MinInt32 {
                    return math.MinInt32
                }
                if sign == 1 && int(val) > math.MaxInt32 {
                    return math.MaxInt32
                }
            } else {
                return int(val) * sign
            }
        }
    }
    
    return int(val) * sign
    
}
```

### Explanation

Let's use simple state machine to track the state of the parsing. It will give the maximum performance of the solution on modern CPUs.
Do not forget to check overflow corner cases.



