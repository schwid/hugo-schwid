+++
date = "2020-06-01"
title = "Invert Binary Tree"
slug = "june 1 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Invert a binary tree.

Example:

Input:
```
     4
   /   \
  2     7
 / \   / \
1   3 6   9
```

Output:
```
     4
   /   \
  7     2
 / \   / \
9   6 3   1
```

Trivia:

This problem was inspired by this original tweet by Max Howell:

Google: 90% of our engineers use the software you wrote (Homebrew), but you can’t invert a binary tree on a whiteboard so f*** off.

## Solution

Let's invert it by recursive calls.

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func invertTree(root *TreeNode) *TreeNode {
    if root != nil {
        root.Right, root.Left = invertTree(root.Left), invertTree(root.Right)
    }
    return root
}
```

Performance of this solution is:
```
Runtime: 0 ms
Memory Usage: 2.2 MB
```
