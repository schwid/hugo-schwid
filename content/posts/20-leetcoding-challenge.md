+++
date = "2020-04-20"
title = "Construct Binary Search Tree from Preorder Traversal"
slug = "20 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Return the root node of a binary search tree that matches the given preorder traversal.

(Recall that a binary search tree is a binary tree where for every node, any descendant of node.left has a value < node.val, and any descendant of node.right has a value > node.val.  Also recall that a preorder traversal displays the value of the node first, then traverses node.left, then traverses node.right.)



Example 1:
```
Input: [8,5,1,7,10,12]
Output: [8,5,10,1,7,null,12]
```

Note:
```
1 <= preorder.length <= 100
The values of preorder are distinct.
```

## Solution

First of all we need to check corner case if array is empty.
Then we need to init root node and search for right value tail.
Finally, we can recursively construct the binary tree.


``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func bstFromPreorder(preorder []int) *TreeNode {
    n := len(preorder)
    if n == 0 {
        return nil
    }
    node := &TreeNode { Val: preorder[0] }
    for i := 1; i < n; i++ {
        if preorder[i] > preorder[0] {
            node.Left = bstFromPreorder(preorder[1:i])
            node.Right = bstFromPreorder(preorder[i:])
            return node
        }
    }
    node.Left = bstFromPreorder(preorder[1:])
    return node
}

```

This is the fastest solution that gives 0ms
