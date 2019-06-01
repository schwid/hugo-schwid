+++
date = "2019-05-22"
title = "Construct Binary Search Tree from Preorder Traversal"
slug = "Construct Binary Search Tree from Preorder Traversal"
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

### Solution

Simple solution:
``` go
func bstFromPreorder(preorder []int) *TreeNode {   
    n := len(preorder)
    if n == 0 {
        return nil
    }
    v := preorder[0]
    node := &TreeNode { v, nil, nil }
    i := 1
    for ;i < n && preorder[i] < v; i++ {}
    node.Left = bstFromPreorder(preorder[1:i])
    node.Right = bstFromPreorder(preorder[i:])
    return node
}
```

Solution with rebuilding tree from the bottom (more difficult):

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
    i, n := 0, len(preorder)
    if i == n {
        return nil
    }
    root := &TreeNode { preorder[i], nil, nil }
    i++
    i = bstFromPreorderRec(preorder, i, n, true, root, nil, root)
    i = bstFromPreorderRec(preorder, i, n, false, root, nil, nil)
    return root
}


func bstFromPreorderRec(preorder []int, i, n int, left bool, parent, parentOfParent, lastLeft *TreeNode) int {
    
    if i == n {
        return i
    }
    
    val := preorder[i]
        
    var node *TreeNode    
    if left && val < parent.Val {
        node = &TreeNode { val, nil, nil }
        parent.Left = node
    } else if !left && val > parent.Val {  
        if parentOfParent == nil || (parentOfParent != nil && val < parentOfParent.Val) || (lastLeft != nil && val < lastLeft.Val) || (lastLeft == nil) {
            node = &TreeNode { val, nil, nil }
            parent.Right = node
        }
    }
    
    if node != nil {
        i++
        i = bstFromPreorderRec(preorder, i, n, true, node, parent, node)
        i = bstFromPreorderRec(preorder, i, n, false, node, parent, lastLeft)    
    }
        
    return i
}
```

### Explanation

This solution is simple.

