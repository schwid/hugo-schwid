+++
date = "2019-08-16"
title = "Delete Nodes And Return Forest"
slug = "Delete Nodes And Return Forest"
tags = []
categories = []
+++

## Introduction

Given the root of a binary tree, each node in the tree has a distinct value.

After deleting all nodes with a value in to_delete, we are left with a forest (a disjoint union of trees).

Return the roots of the trees in the remaining forest.  You may return the result in any order.

 

Example 1:
```
Input: root = [1,2,3,4,5,6,7], to_delete = [3,5]
Output: [[1,2,null,4],[6],[7]]
```

Constraints:
```
The number of nodes in the given tree is at most 1000.
Each node has a distinct value between 1 and 1000.
to_delete.length <= 1000
to_delete contains distinct values between 1 and 1000.
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
func delNodes(root *TreeNode, to_delete []int) []*TreeNode {
    
    del := make([]bool, 1000)
    for _, val := range to_delete {
        del[val-1] = true
    }
    
    roots := make([]*TreeNode, 1000)
    roots[root.Val-1] = root
    
    q := []*TreeNode { root }
    for len(q) > 0 {
        
        node := q[0]
        q = q[1:]
        
        if del[node.Val-1] {
            roots[node.Val-1] = nil
            if node.Left != nil {
                roots[node.Left.Val-1] = node.Left
            }
            if node.Right != nil {
                roots[node.Right.Val-1] = node.Right
            }
        }
        
        if node.Left != nil {
            q = append(q, node.Left)
            if del[node.Left.Val-1] {
                node.Left = nil
            }
        }
        
        if node.Right != nil {
            q = append(q, node.Right)
            if del[node.Right.Val-1] {
                node.Right = nil
            }
        }        
    }

    out := []*TreeNode{}
    for _, v := range roots {
        if v != nil {
            out = append(out, v)
        }
    }
    
    return out
}
```

### Explanation

Let's go by BFS through nodes and check deletes. Keep track of roots in special array (can be map). Return final values.
Do not forget to delete actual nodes.


