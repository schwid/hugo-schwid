+++
date = "2020-06-15"
title = "Search in a Binary Search Tree"
slug = "june 15 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given the root node of a binary search tree (BST) and a value. You need to find the node in the BST that the node's value equals the given value. Return the subtree rooted with that node. If such node doesn't exist, you should return NULL.

For example,

Given the tree:
```
        4
       / \
      2   7
     / \
    1   3
```

And the value to search: 2
You should return this subtree:
```
      2     
     / \   
    1   3
```

In the example above, if we want to search the value 5, since there is no node with value 5, we should return NULL.

Note that an empty tree is represented by NULL, therefore you would see the expected output (serialized tree format) as [], not null.

## Solution

Recursion solution is the best choice for this simple task.

``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func searchBST(root *TreeNode, val int) *TreeNode {
    if root == nil {
        return nil
    }
    if root.Val == val {
        return root
    } else if val < root.Val {
        return searchBST(root.Left, val)
    } else {
        return searchBST(root.Right, val)
    }
}
```

Performance of this solution is:
```
Runtime: 24 ms
Memory Usage: 6.7 MB
```


Let's try to optimize this task and replace recursion by loop

```go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func searchBST(root *TreeNode, val int) *TreeNode {
    i := root
    for i != nil {
        if i.Val == val {
            return i
        } else if i.Val > val {
            i = i.Left
        } else {
            i = i.Right
        }   
    }
    return i    
}
```

Performance of this solution is:
```
Runtime: 24 ms
Memory Usage: 6.6 MB
```

As we see, recursion solution have no difference with loop in small tasks.
