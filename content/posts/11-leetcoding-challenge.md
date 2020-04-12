+++
date = "2020-04-11"
title = "Diameter of Binary Tree"
slug = "Diameter of Binary Tree"
tags = []
categories = []
+++

## Introduction

Given a binary tree, you need to compute the length of the diameter of the tree. The diameter of a binary tree is the length of the longest path between any two nodes in a tree. This path may or may not pass through the root.

Example:
Given a binary tree
          1
         / \
        2   3
       / \     
      4   5    
Return 3, which is the length of the path [4,2,1,3] or [5,2,1,3].

Note: The length of path between two nodes is represented by the number of edges between them.

## Solution

The simple recursion solution would be to compare on each node sum of heights and max diameter of childs.

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func diameterOfBinaryTree(root *TreeNode) int {
    if root == nil {
        return 0
    }
    h := height(root.Left) + height(root.Right)
    d := max(diameterOfBinaryTree(root.Left), diameterOfBinaryTree(root.Right))
    return max(h, d)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}

func height(root *TreeNode) int {
    if root == nil {
        return 0
    }
    return 1 + max(height(root.Left), height(root.Right))
}
```

Faster solution would be to use DFS search in the tree.

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func diameterOfBinaryTree(root *TreeNode) int {
    maxSoFar := 0
    dfs(root, &maxSoFar)
    return maxSoFar
}

func dfs(node *TreeNode, maxSoFar *int) int {
    if node == nil {
        return -1
    }
    left := 1 + dfs(node.Left, maxSoFar)
    right := 1 + dfs(node.Right, maxSoFar)
    *maxSoFar = max(*maxSoFar, left + right)
    return max(left, right)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```
