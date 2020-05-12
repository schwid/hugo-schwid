+++
date = "2020-05-12"
title = "Single Element in a Sorted Array"
slug = "may 12 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You are given a sorted array consisting of only integers where every element appears exactly twice, except for one element which appears exactly once. Find this single element that appears only once.


Example 1:

Input: [1,1,2,3,3,4,4,8,8]
Output: 2
Example 2:

Input: [3,3,7,7,10,11,11]
Output: 10


Note: Your solution should run in O(log n) time and O(1) space.

## Solution

This task is for binary logic. If all elements appear twice, that if we xor all of them, they will disappear.

``` go
func singleNonDuplicate(nums []int) int {
    x := 0
    for _, num := range nums {
        x ^= num
    }
    return x
}
```
