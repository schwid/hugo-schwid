+++
date = "2019-08-12"
title = "Lowest Common Ancestor of Deepest Leaves"
slug = "Lowest Common Ancestor of Deepest Leaves"
tags = []
categories = []
+++

## Introduction

Given a rooted binary tree, return the lowest common ancestor of its deepest leaves.

Recall that:
```
The node of a binary tree is a leaf if and only if it has no children
The depth of the root of the tree is 0, and if the depth of a node is d, the depth of each of its children is d+1.
The lowest common ancestor of a set S of nodes is the node A with the largest depth such that every node in S is in the subtree with root A.
```

Example 1:
```
Input: root = [1,2,3]
Output: [1,2,3]
Explanation: 
The deepest leaves are the nodes with values 2 and 3.
The lowest common ancestor of these leaves is the node with value 1.
The answer returned is a TreeNode object (not an array) with serialization "[1,2,3]".
```

Example 2:
```
Input: root = [1,2,3,4]
Output: [4]
```

Example 3:
```
Input: root = [1,2,3,4,5]
Output: [2,4,5]
``` 

Constraints:
```
The given tree will have between 1 and 1000 nodes.
Each node of the tree will have a distinct value between 1 and 1000.
```

### Solution

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func lcaDeepestLeaves(root *TreeNode) *TreeNode {
    maxD := 0
    ret := root
    
    lcaRecur(root, 1, func(d int, node *TreeNode) {
        if d >= maxD {
            maxD = d
            ret = node
        }
    })
    
    return ret
}

func lcaRecur(node *TreeNode, d int, visit func(int, *TreeNode)) int {
    if node == nil {
        return d-1
    }
    if isLeaf(node) {
        visit(d, node)
        return d
    }
    left := lcaRecur(node.Left, d+1, visit)
    right := lcaRecur(node.Right, d+1, visit)
    if left == right {
        visit(left, node)
    }
    return max(left, right)
}

func isLeaf(node *TreeNode) bool {
    return node.Left == nil && node.Right == nil 
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

### Explanation

Let's use recursion to visit all nodes in binary tree. Each time we need to check if node is Leaf. For leaf node we can setup MaxDepth in callback function.
For the rest of nodes we need to make sure that depth of left and right sub-trees are the same and equal to MaxDepth. If this condition works, then we found lowest common ancestor.
