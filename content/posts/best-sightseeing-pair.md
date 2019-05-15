+++
date = "2019-05-15"
title = "Best Sightseeing Pair"
slug = "Best Sightseeing Pair"
tags = []
categories = []
+++

## Introduction

Given an array A of positive integers, A[i] represents the value of the i-th sightseeing spot, and two sightseeing spots i and j have distance j - i between them.

The score of a pair (i < j) of sightseeing spots is (A[i] + A[j] + i - j) : the sum of the values of the sightseeing spots, minus the distance between them.

Return the maximum score of a pair of sightseeing spots.

 

Example 1:
```
Input: [8,1,5,2,6]
Output: 11
Explanation: i = 0, j = 2, A[i] + A[j] + i - j = 8 + 5 + 0 - 2 = 11
```

Note:
```
2 <= A.length <= 50000
1 <= A[i] <= 1000
```

### Solution

Golang:
``` go
func maxScoreSightseeingPair(A []int) int {
    n := len(A)
    if n <= 1 {
        return 0
    }
    
    maxSoFar, spotA := 0, A[0] + 0 - 1
    
    for j := 1; j < n; j, spotA = j + 1, spotA - 1 {
        maxSoFar = max(maxSoFar, A[j] + spotA)
        spotA = max(spotA, A[j])
    }
        
    return maxSoFar
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

Track max value for if spot A located in `spotA`. Every time decrement, to match requirement `i-j`. On each step update spotA by moving this spot forward.

