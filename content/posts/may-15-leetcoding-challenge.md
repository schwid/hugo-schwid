+++
date = "2020-05-15"
title = "Maximum Sum Circular Subarray"
slug = "may 15 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a circular array C of integers represented by A, find the maximum possible sum of a non-empty subarray of C.

Here, a circular array means the end of the array connects to the beginning of the array.  (Formally, C[i] = A[i] when 0 <= i < A.length, and C[i+A.length] = C[i] when i >= 0.)

Also, a subarray may only include each element of the fixed buffer A at most once.  (Formally, for a subarray C[i], C[i+1], ..., C[j], there does not exist i <= k1, k2 <= j with k1 % A.length = k2 % A.length.)


Example 1:
```
Input: [1,-2,3,-2]
Output: 3
Explanation: Subarray [3] has maximum sum 3
```

Example 2:
```
Input: [5,-3,5]
Output: 10
Explanation: Subarray [5,5] has maximum sum 5 + 5 = 10
```

Example 3:
```
Input: [3,-1,2,-1]
Output: 4
Explanation: Subarray [2,-1,3] has maximum sum 2 + (-1) + 3 = 4
```

Example 4:
```
Input: [3,-2,2,-3]
Output: 3
Explanation: Subarray [3] and [3,-2,2] both have maximum sum 3
```

Example 5:
```
Input: [-2,-3,-1]
Output: -1
Explanation: Subarray [-1] has maximum sum -1
```

Note:
```
-30000 <= A[i] <= 30000
1 <= A.length <= 30000
```

## Solution

Just to remaind, there is a well known Kadane's algorithm to search "Maximum Sum Subarray that looks like this:

``` go
func maxSubarraySum(A []int) int {
	n := len(A)
  if n == 0 {
      return 0
  }
	dpMax, maxSoFar := A[0], A[0]
	for i := 1; i < n; i++ {
    dpMax = max(dpMax, 0) + A[i]
    maxSoFar = max(maxSoFar, dpMax)
	}
  return maxSoFar
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}
```

This algorithm works well, but for the flat array. Here we have a circular, therefore we can have two options:
* subarray in the middle [   MAXSUB   ]
* subarray in the corners [MAXSUB0    MAXSUB1]

For first case Kadane's algorithm will work well, but for second case we need to reverse the problem, let's find the min subarray:

[   MINSUB   ] that is equal to  [MAXSUB0    MAXSUB1] if we subtruct from total sum the MINSUB_SUM.


Here it is, the fastest possible solution:

``` go
func maxSubarraySumCircular(A []int) int {
	n := len(A)
  if n == 0 {
        return 0
  }
	dpMin, dpMax, sum, minSoFar, maxSoFar := A[0], A[0], A[0], A[0], A[0]
	for i := 1; i < n; i++ {
		dpMin = min(dpMin, 0) + A[i]
        dpMax = max(dpMax, 0) + A[i]
		sum += A[i]
		minSoFar = min(minSoFar, dpMin)
        maxSoFar = max(maxSoFar, dpMax)
	}
  if sum == minSoFar {
        return maxSoFar
  }
  return max(maxSoFar, sum - minSoFar)
}

func max(a, b int) int {
	if a > b {
		return a
	}
	return b
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}
```


One corner case we need to check if all elements are negative. I just added this condition

``` go
if sum == minSoFar {
    return maxSoFar
}
```

## Performance

```
Runtime: 56 ms
Memory Usage: 6.8 MB
```

Did not see anything faster. This is clear compute O(n) and space O(1).
