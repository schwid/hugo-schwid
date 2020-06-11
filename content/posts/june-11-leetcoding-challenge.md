+++
date = "2020-06-11"
title = "Sort Colors"
slug = "june 11 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an array with n objects colored red, white or blue, sort them in-place so that objects of the same color are adjacent, with the colors in the order red, white and blue.

Here, we will use the integers 0, 1, and 2 to represent the color red, white, and blue respectively.

Note: You are not suppose to use the library's sort function for this problem.

Example:
```
Input: [2,0,2,1,1,0]
Output: [0,0,1,1,2,2]
```

Follow up:

A rather straight forward solution is a two-pass algorithm using counting sort.
* First, iterate the array counting number of 0's, 1's, and 2's, then overwrite array with total number of 0's, then 1's and followed by 2's.
* Could you come up with a one-pass algorithm using only constant space?


## Solution

Let's solve it in one loop

``` go
func sortColors(nums []int)  {
    n := len(nums)
    for i, j, k := 0, n-1, 0; k <= j; {
        switch nums[k] {
            case 0:
                if i < k {
                    nums[i], nums[k] = nums[k], nums[i]
                    i++
                } else {
                    i++
                    k++
                }
            case 1:
                k++
            case 2:
                nums[k], nums[j] = nums[j], nums[k]
                j--
        }
    }
}
```

Performance of this solution is:
```
Runtime: 0 ms
Memory Usage: 2.1 MB
```
