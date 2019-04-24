+++
date = "2019-04-23"
title = "Two Sum II - Input array is sorted"
slug = "Two Sum II - Input array is sorted"
tags = []
categories = []
+++

## Introduction

Given an array of integers that is already sorted in ascending order, find two numbers such that they add up to a specific target number.

The function twoSum should return indices of the two numbers such that they add up to the target, where index1 must be less than index2.

Note:

Your returned answers (both index1 and index2) are not zero-based.
You may assume that each input would have exactly one solution and you may not use the same element twice.
Example:
```
Input: numbers = [2,7,11,15], target = 9
Output: [1,2]
Explanation: The sum of 2 and 7 is 9. Therefore index1 = 1, index2 = 2.
```

### Solution

Simple solution:
``` go
func twoSum(numbers []int, target int) []int {

    for i, n := range numbers {

        if j, ok := binarySearch(numbers[i+1:], target-n); ok {
            return []int {i+1, i+1+j+1}
        }

    }

    return nil
}

func binarySearch(arr []int, val int) (int, bool) {

    low, hi := 0, len(arr)-1

    for low <= hi {
        mid := low + (hi-low) / 2
        v := arr[mid]
        if v == val {
            return mid, true
        } else if v > val {
            hi = mid - 1
        } else if v < val {
            low = mid + 1
        }

    }

    return 0, false
}
```

### Explanation

Binary search solution.
