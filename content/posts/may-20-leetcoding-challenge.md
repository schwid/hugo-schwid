+++
date = "2020-05-20"
title = "Kth Smallest Element in a BST"
slug = "may 20 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a binary search tree, write a function kthSmallest to find the kth smallest element in it.

Example 1:
```
Input: root = [3,1,4,null,2], k = 1
   3
  / \
 1   4
  \
   2
Output: 1
```

Example 2:
```
Input: root = [5,3,6,2,4,null,null,1], k = 3
       5
      / \
     3   6
    / \
   2   4
  /
 1
Output: 3
```

Follow up:
What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently? How would you optimize the kthSmallest routine?

Constraints:
```
The number of elements of the BST is between 1 to 10^4.
You may assume k is always valid, 1 ≤ k ≤ BST's total elements.
```

## Solution

Let's use simple DFS search, so we can traverse the binary tree from left to right.
Each time on root node we will decrement k until reach zero, that would be the result.

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func kthSmallest(root *TreeNode, k int) int {
    _, val := dfs(root, k)
    return val
}

// if found, return val, if not found return k
func dfs(root *TreeNode, k int) (found bool, ret int) {
    if root == nil {
        return false, k
    }
    if found, ret = dfs(root.Left, k); found {
        return
    }
    k = ret-1
    if k == 0 {
        return true, root.Val
    }
    return dfs(root.Right, k)
}
```
