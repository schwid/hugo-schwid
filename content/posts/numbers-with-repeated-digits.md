+++
date = "2019-05-11"
title = "Numbers With Repeated Digits"
slug = "Numbers With Repeated Digits"
tags = []
categories = []
+++

## Introduction

Given a positive integer N, return the number of positive integers less than or equal to N that have at least 1 repeated digit.



Example 1:
```
Input: 20
Output: 1
Explanation: The only positive number (<= 20) with at least 1 repeated digit is 11.
```

Example 2:
```
Input: 100
Output: 10
Explanation: The positive numbers (<= 100) with atleast 1 repeated digit are 11, 22, 33, 44, 55, 66, 77, 88, 99, and 100.
```

Example 3:
```
Input: 1000
Output: 262
```

Note:
```
1 <= N <= 10^9
```

### Solution

Golang
``` go
func numDupDigitsAtMostN(N int) int {

    digits := make([]int, 40)
    last := 40
    for i := N+1; i > 0; i /= 10 {
        last--
        digits[last] = i % 10
    }
    digits = digits[last:]

    n := len(digits)
    res := 0

    for i := 1; i < n; i++ {
        res += 9 * permutation(9, i-1)
    }

    seen := make([]bool, 10)

    for i := 0; i < n; i++ {
        j := 1
        if i > 0 {
            j = 0
        }
        digit := digits[i]
        for ; j < digit; j++ {
            if !seen[j] {
                res += permutation(10 - (i+1), n - i - 1)
            }
        }
        if seen[digit] {
            break
        }
        seen[digit] = true      
    }
    return N - res
}

func permutation(n, c int) int {
    p := 1
    for i := 0; i < c; i, n = i + 1, n - 1 {
      p *= n;  
    }
    return p;
}
```

###  Intuition
Count res the Number Without Repeated Digit
Then the number with repeated digits = N - res

Similar as
* Rotated Digits
* Numbers At Most N Given Digit Set

###  Explanation:
Transform N + 1 to arrayList
Count the number with digits < n
Count the number with same prefix
For example,
if N = 8765, L = [8,7,6,6],
the number without repeated digit can the the following format:
| Numbers |
| :----: |
| XXX |
| XX |
| X |
| 1XXX ~ 7XXX |
| 80XX ~ 86XX |
| 870X ~ 875X |
| 8760 ~ 8765 |

Time Complexity:
the number of permutations `permutation(m, n)` is `O(1)`
We count digit by digit, so it's `O(logN)`
