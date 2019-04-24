+++
date = "2019-04-23"
title = "First Missing Positive"
slug = "First Missing Positive"
tags = []
categories = []
+++

## Introduction

Given an unsorted integer array, find the smallest missing positive integer.

Example 1:
```
Input: [1,2,0]
Output: 3
```
Example 2:
```
Input: [3,4,-1,1]
Output: 2
```
Example 3:
```
Input: [7,8,9,11,12]
Output: 1
```

Note:
* Your algorithm should run in O(n) time and uses constant extra space.

### Solution

Simple sort solution:
``` go
func firstMissingPositive(nums []int) int {

    if len(nums) == 0 {
        return 1
    }

    pos := make([]int, 0, 100)
    for _, n := range nums {
        if n > 0 {
            pos = append(pos, n)
        }    
    }

    m := len(pos)

    if m == 0 {
        return 1
    }

    sort.Ints(pos)

    if pos[0] > 1 {
        return 1
    }

    for i := 1; i < m; i++ {

        if pos[i] == pos[i-1] {
            // doubles are ok
            continue
        }

        if pos[i] != pos[i-1] + 1 {
            return pos[i-1] + 1
        }
    }

    return pos[m-1] + 1
}
```

Array solution:
``` go
func firstMissingPositive(nums []int) int {

    n := len(nums)

    if n == 0 {
        return 1
    }

    seen := make([]bool, n)

    for _, v := range nums {

        if v > 0 && v <= n {
            seen[v-1] = true
        }

    }

    for i, b := range seen {
        if !b {
            return i + 1
        }
    }

    return len(seen) + 1

}
```

### Explanation

Simple first solution is to filter all positive numbers, sort them and find missing number in sorted array.

Another way to solve with problem without sort is to use values from nums[] as indexes of `seen` array.
It is possible, because in our worst case the sequence [1,2,3,4,5,6,7...missing] is indexable.
