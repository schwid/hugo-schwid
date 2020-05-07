+++
date = "2020-05-07"
title = "Cousins in Binary Tree"
slug = "may 7 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

In a binary tree, the root node is at depth 0, and children of each depth k node are at depth k+1.

Two nodes of a binary tree are cousins if they have the same depth, but have different parents.

We are given the root of a binary tree with unique values, and the values x and y of two different nodes in the tree.

Return true if and only if the nodes corresponding to the values x and y are cousins.



Example 1:


Input: root = [1,2,3,4], x = 4, y = 3
Output: false
Example 2:


Input: root = [1,2,3,null,4,null,5], x = 5, y = 4
Output: true
Example 3:



Input: root = [1,2,3,null,4], x = 2, y = 3
Output: false


Note:
```
The number of nodes in the tree will be between 2 and 100.
Each node has a unique integer value from 1 to 100.
```

## Solution

Simple solution.

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func isCousins(root *TreeNode, x int, y int) bool {
    parentX, depthX := findNode(root, nil, x, 0)
    parentY, depthY := findNode(root, nil, y, 0)
    return parentX != parentY && depthX == depthY
}

func findNode(node, parent *TreeNode, target, depth int) ( *TreeNode, int) {
    if node == nil {
        return parent, -1
    }
    if node.Val == target {
        return parent, depth
    }
    if p, d := findNode(node.Left, node, target, depth+1); d != -1 {
        return p, d
    }
    if p, d := findNode(node.Right, node, target, depth+1); d != -1 {
        return p, d
    }
    return parent, -1
}
```
