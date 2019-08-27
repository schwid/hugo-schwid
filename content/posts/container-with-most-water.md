+++
date = "2019-08-26"
title = "Container With Most Water"
slug = "Container With Most Water"
tags = []
categories = []
+++

### Introduction

Given n non-negative integers a1, a2, ..., an , where each represents a point at coordinate (i, ai). n vertical lines are drawn such that the two endpoints of line i is at (i, ai) and (i, 0). Find two lines, which together with x-axis forms a container, such that the container contains the most water.

Note: You may not slant the container and n is at least 2.

![image](/images/container-with-most-water.jpg)
The above vertical lines are represented by array [1,8,6,2,5,4,8,3,7]. In this case, the max area of water (blue section) the container can contain is 49.

 

Example:
```
Input: [1,8,6,2,5,4,8,3,7]
Output: 49
```

### Solution

Let's solve this problem by using brute force method:

``` go
func maxArea(height []int) int {
    n := len(height)
    s := 0
    for i := 0; i < n; i++ {
        for j := n-1; j > i; j-- {
            s = max(s, min(height[i], height[j]) * (j - i))
        }
    }
    return s
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

This approach works 296ms and does not looks like an optional one.
Another way to solve this problem is to use two pointers in start and end of array.

``` go
func maxArea(height []int) int {
    n := len(height)
    if n < 2 {
        return 0
    }
    i, j, s := 0, n-1, 0
    for i < j {
        s = max(s, min(height[i], height[j]) * (j-i))
        if height[i] < height[j] {
            i++
        } else {
            j--
        }
    }
    return s
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

This solution gives 12ms and has complexity O(n), that could be the best way to go.
