+++
date = "2019-04-24"
title = "Preimage Size of Factorial Zeroes Function"
slug = "Preimage Size of Factorial Zeroes Function"
tags = []
categories = []
+++

## Introduction

Let f(x) be the number of zeroes at the end of x!. (Recall that x! = 1 * 2 * 3 * ... * x, and by convention, 0! = 1.)

For example, f(3) = 0 because 3! = 6 has no zeroes at the end, while f(11) = 2 because 11! = 39916800 has 2 zeroes at the end. Given K, find how many non-negative integers x have the property that f(x) = K.

Example 1:
```
Input: K = 0
Output: 5
Explanation: 0!, 1!, 2!, 3!, and 4! end with K = 0 zeroes.
```
Example 2:
```
Input: K = 5
Output: 0
Explanation: There is no x such that x! ends in K = 5 zeroes.
Note:
K will be an integer in the range [0, 10^9].
```

### Solution

Golang:
``` go
func preimageSizeFZF(K int) int {
    
    low := 0
    hi := (K + 1) * 5 + 1
    
    for low < hi {
        mid := low + (hi - low) / 2
        zeros := fzf(mid)   
        if K == zeros {
            return 5
        } else if K < zeros {
            hi = mid
        } else {
            low = mid+1
        }
    }
    
    return 0
}

func fzf(n int) int {
    cnt := 0
    for i := 5; n / i >= 1; i *= 5 { 
        cnt += n / i
    }
    return cnt    
}
```

### Explanation

Every 5 numbers change the count, therefore we have 5 number intervals [0...5K]. This function can return 0 or 5 only, depending on what interval we hit.
All digits are sorted, so binary search works fine.
