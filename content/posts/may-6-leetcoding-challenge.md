+++
date = "2020-05-06"
title = "First Unique Character in a String"
slug = "may 6 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given an array of size n, find the majority element. The majority element is the element that appears more than ⌊ n/2 ⌋ times.

You may assume that the array is non-empty and the majority element always exist in the array.

Example 1:

Input: [3,2,3]
Output: 3
Example 2:

Input: [2,2,1,1,1,2,2]
Output: 2

## Solution

Major element needs to have count greater as minimum on one of count all the rest element.
Let's consider situation when all non major elements goes first in array, and then major elements comes.
In this case all negative count of non major elements would be compensated by positive count of major element
plus one.


``` go
func majorityElement(nums []int) int {
    major, majorCnt := 0, 0
    for _, val := range nums {
        if major == val {
            majorCnt++
        } else if majorCnt == 0 {
            major, majorCnt = val, 1
        } else {
            majorCnt--
        }
    }
    return major
}
```
