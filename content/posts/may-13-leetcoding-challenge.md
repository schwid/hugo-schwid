+++
date = "2020-05-13"
title = "Remove K Digits"
slug = "may 13 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a non-negative integer num represented as a string, remove k digits from the number so that the new number is the smallest possible.

Note:
The length of num is less than 10002 and will be ≥ k.
The given num does not contain any leading zero.
Example 1:

Input: num = "1432219", k = 3
Output: "1219"
Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
Example 2:

Input: num = "10200", k = 1
Output: "200"
Explanation: Remove the leading 1 and the number is 200. Note that the output must not contain leading zeroes.
Example 3:

Input: num = "10", k = 2
Output: "0"
Explanation: Remove all the digits from the number and it is left with nothing which is 0.


## Solution

Let's assume that removing digit is communitive operation therefore, we can split this task in to `k` independent sub-tasks of removing one digit.
Second, we need to build `skipLeadingZeros` function that will filter our digits.
And finally, we need to select one digit to remove, with the target to get minium possible number after that.
First of all, if number has less or equal then one digit, then result would be always '0'.
And the removal digit is the first extremum, like, for example, in number '123454321' it would be '5'.


``` go
func removeKdigits(num string, k int) string {
    switch k {
        case 0:
            return num
        case 1:
            return removeOneDigit(num)
        default:
            return removeKdigits(removeOneDigit(num), k-1)
    }
}

func removeOneDigit(num string) string {
    n := len(num)
    if n <= 1 {
        return "0"
    }
    i := 0
    for ; i < n-1; i++ {
        if num[i] > num[i+1] {
            return skipLeadingZeros(num[:i] + num[i+1:])
        }
    }
    return skipLeadingZeros(num[:i] + num[i+1:])
}

func skipLeadingZeros(num string) string {
    for i, ch := range num {
        if ch != '0' {
            sanitized := num[i:]
            if len(sanitized) == 0 {
                return "0"
            }
            return sanitized
        }
    }
    return "0"
}
```

Performance of this solution is
```
Runtime: 4 ms
Memory Usage: 9 MB
```

Let's optimize it by replacing string operations by byte array and by removing recursion.

``` go
var zero = []byte { '0' }

func removeKdigits(num string, k int) string {
    arr := []byte(num)
    for i := 0; i < k; i++ {
        arr = removeOneDigit(arr)
    }
    return string(arr)
}

func removeOneDigit(num []byte) []byte {
    n := len(num)
    if n <= 1 {
        return zero
    }
    i := 0
    for ; i < n-1; i++ {
        if num[i] > num[i+1] {
            return skipLeadingZeros(append(num[:i], num[i+1:]...))
        }
    }
    return skipLeadingZeros(append(num[:i], num[i+1:]...))
}

func skipLeadingZeros(num []byte) []byte {
    for i, ch := range num {
        if ch != '0' {
            sanitized := num[i:]
            if len(sanitized) == 0 {
                return zero
            }
            return sanitized
        }
    }
    return zero
}
```


This solution shows better performance, but less readable code:

```
Runtime: 0 ms
Memory Usage: 2.5 MB
```

It also visible that memory footprint decreased significantly.
That's probably because in tests it uses large strings.
