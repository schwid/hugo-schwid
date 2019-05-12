+++
date = "2019-05-11"
title = "Capacity To Ship Packages Within D Days"
slug = "Capacity To Ship Packages Within D Days"
tags = []
categories = []
+++

## Introduction

A conveyor belt has packages that must be shipped from one port to another within D days.

The i-th package on the conveyor belt has a weight of weights[i].  Each day, we load the ship with packages on the conveyor belt (in the order given by weights). We may not load more weight than the maximum weight capacity of the ship.

Return the least weight capacity of the ship that will result in all the packages on the conveyor belt being shipped within D days.



Example 1:
```
Input: weights = [1,2,3,4,5,6,7,8,9,10], D = 5
Output: 15
Explanation:
A ship capacity of 15 is the minimum to ship all the packages in 5 days like this:
1st day: 1, 2, 3, 4, 5
2nd day: 6, 7
3rd day: 8
4th day: 9
5th day: 10
```

Note that the cargo must be shipped in the order given, so using a ship of capacity 14 and splitting the packages into parts like (2, 3, 4, 5), (1, 6, 7), (8), (9), (10) is not allowed.


Example 2:
```
Input: weights = [3,2,2,4,1,4], D = 3
Output: 6
Explanation:
A ship capacity of 6 is the minimum to ship all the packages in 3 days like this:
1st day: 3, 2
2nd day: 2, 4
3rd day: 1, 4
```

Example 3:
```
Input: weights = [1,2,3,1,1], D = 4
Output: 3
Explanation:
1st day: 1
2nd day: 2
3rd day: 3
4th day: 1, 1
```

Note:
```
1 <= D <= weights.length <= 50000
1 <= weights[i] <= 500
```

### Solution

Simple brute force solution:
``` go
func shipWithinDays(weights []int, D int) int {
    n := len(weights)
    sum := 0
    maxWeight := weights[0]
    for i := 0; i < n; i++ {
        sum += weights[i]
        maxWeight = max(maxWeight, weights[i])
    }

    for i := max(sum / D, maxWeight); i <= sum; i++ {

        if fit(weights, n, D, i) {
            return i
        }

    }

    return -1
}

func fit(weights []int, n, D, lot int) bool {

    j := 0
    s := weights[0]
    for i := 1; i < n; i++ {
        if s + weights[i] > lot {
            j++
            s = weights[i]
        } else if s + weights[i] == lot {
            j++
            s = 0
        } else {
            s += weights[i]
        }
    }

    if s > 0 {
        j++
    }

    return j <= D
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

### Explanation

Lets calculate sum of array and divide it on `D`, it will give is average lot size.
Lets take maximum from avg lot size and max weight.
That would be out starting lot size that we need to if ship will fix all weights in `D` days.
Going incrementally, so by using brute force we can find a minimum lot size.


Lets modify solution by using binary search.

### Solution

Binary search solution:
``` go
func shipWithinDays(weights []int, D int) int {
    n := len(weights)
    sum := 0
    maxWeight := weights[0]
    for i := 0; i < n; i++ {
        sum += weights[i]
        maxWeight = max(maxWeight, weights[i])
    }

    lo := max(sum / D, maxWeight)
    hi := sum + 1

    for lo < hi {
        mi := lo + (hi - lo) / 2
        days := fit(weights, n, mi)
        if days > D {
            lo = mi + 1
        } else {
            hi = mi
        }
    }

    return lo
}

func fit(weights []int, n, lot int) int {

    j := 0
    s := weights[0]
    for i := 1; i < n; i++ {
        if s + weights[i] > lot {
            j++
            s = weights[i]
        } else if s + weights[i] == lot {
            j++
            s = 0
        } else {
            s += weights[i]
        }
    }

    if s > 0 {
        j++
    }

    return j
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

### Explanation

We improved the solution by using binary search and it works 3 times faster. Good job!
