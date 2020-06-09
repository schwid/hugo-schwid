+++
date = "2020-05-24"
title = "Count of Smaller Numbers After Self"
slug = "315. Count of Smaller Numbers After Self"
tags = []
categories = []
+++

## Introduction

You are given an integer array nums and you have to return a new counts array. The counts array has the property where counts[i] is the number of smaller elements to the right of nums[i].

Example:
```
Input: [5,2,6,1]
Output: [2,1,1,0]
```

Explanation:
```
To the right of 5 there are 2 smaller elements (2 and 1).
To the right of 2 there is only 1 smaller element (1).
To the right of 6 there is 1 smaller element (1).
To the right of 1 there is 0 smaller element.
```

### Solution

Let's solve it with brute force method and use just a simple cache to store visited numbers.

``` go
func countSmaller(nums []int) []int {
    n := len(nums)
    out := make([]int, n)
    cache := make(map[int]int)
    for i := n-1; i >= 0; i-- {
        out[i] = count(cache, nums[i])
        cache[nums[i]]++
    }
    return out
}

func count(cache map[int]int, current int) int {
    cnt := 0
    for num, val := range cache {
        if current > num {
            cnt += val
        }
    }
    return cnt
}
```

This solution gives a pattern, but performance is not good

```
Runtime: 1756 ms, faster than 5.15% of Go online submissions for Count of Smaller Numbers After Self.
Memory Usage: 5 MB, less than 100.00% of Go online submissions for Count of Smaller Numbers After Self.
```

Let's optimize it by replacing hash map (cache) by binary tree

``` go
type binaryTree struct {
    val   int
    cnt   int
    left  *binaryTree
    right *binaryTree
}

func newNode(value int) *binaryTree {
    return &binaryTree { val: value, cnt: 1 }
}

func (t *binaryTree) insert(value int) int {
    total := 0
    node := t
    for {
        if node.val >= value {
            node.cnt++
            if node.left == nil {
                node.left = newNode(value)
                break
            }
            node = node.left
        } else {
            total += node.cnt
            if node.right == nil {
                node.right = newNode(value)
                break
            }
            node = node.right
        }
    }
    return total
}

func countSmaller(nums []int) []int {
    n := len(nums)
    if n == 0 {
        return nums
    }
    out := make([]int, n)
    out[n-1] = 0
    tree := newNode(nums[n-1])
    for i := n-2; i >= 0; i-- {
        out[i] = tree.insert(nums[i])
    }
    return out
}
```

This solution runs much better:
```
Runtime: 8 ms, faster than 98.52% of Go online submissions for Count of Smaller Numbers After Self.
Memory Usage: 5 MB, less than 100.00% of Go online submissions for Count of Smaller Numbers After Self.
```
