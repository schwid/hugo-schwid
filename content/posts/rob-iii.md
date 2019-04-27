+++
date = "2019-04-26"
title = "House Robber III"
slug = "House Robber III"
tags = []
categories = []
+++

## Introduction

The thief has found himself a new place for his thievery again. There is only one entrance to this area, called the "root." Besides the root, each house has one and only one parent house. After a tour, the smart thief realized that "all houses in this place forms a binary tree". It will automatically contact the police if two directly-linked houses were broken into on the same night.

Determine the maximum amount of money the thief can rob tonight without alerting the police.

Example 1:
```
Input: [3,2,3,null,3,null,1]

     3
    / \
   2   3
    \   \ 
     3   1

Output: 7 
Explanation: Maximum amount of money the thief can rob = 3 + 3 + 1 = 7.
```
Example 2:
```
Input: [3,4,5,1,3,null,1]

     3
    / \
   4   5
  / \   \ 
 1   3   1

Output: 9
Explanation: Maximum amount of money the thief can rob = 4 + 5 = 9.
```


### Solution

Recursive solution:
``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func rob(root *TreeNode) int {
    return max(robR(root))    
}

func robR(root *TreeNode) (int, int) {
    
    if root == nil {
        return 0, 0
    }

    l1, l2 := robR(root.Left)
    r1, r2 := robR(root.Right)

    return max(root.Val + l2 + r2, l1 + r1), max(l1, l2) + max(r1, r2)
}

func max(a, b int) int {
    if a >= b {
        return a
    } else {
        return b
    }
}
```

### Explanation

Let's create a recursive function that will return two maximized revenues: with included root value, and not included root value.
Based on that we can make decision on upper level and also return two cases:
* (root value plus left w/o their root plus right w/o their root) vs (left with their possible root plus right with their possible root )
* maximize all left or right values without current root value



