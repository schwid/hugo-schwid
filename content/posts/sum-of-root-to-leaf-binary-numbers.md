+++
date = "2019-04-30"
title = "Sum of Root To Leaf Binary Numbers"
slug = "Sum of Root To Leaf Binary Numbers"
tags = []
categories = []
+++

## Introduction


Given a binary tree, each node has value 0 or 1.  Each root-to-leaf path represents a binary number starting with the most significant bit.  For example, if the path is 0 -> 1 -> 1 -> 0 -> 1, then this could represent 01101 in binary, which is 13.

For all leaves in the tree, consider the numbers represented by the path from the root to that leaf.

Return the sum of these numbers.


Example 1:
![image](/images/sum-of-root-to-leaf-binary-numbers/1.png)


```
Input: [1,0,1,0,1,0,1]
Output: 22
Explanation: (100) + (101) + (110) + (111) = 4 + 5 + 6 + 7 = 22
```

Note:
```
The number of nodes in the tree is between 1 and 1000.
node.val is 0 or 1.
The answer will not exceed 2^31 - 1.
```

### Solution

DFS solution
``` go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func sumRootToLeaf(root *TreeNode) int {
    var sum int
    if root != nil {
        dfs(root, 0, &sum)
    }
    return sum
}

func dfs(node *TreeNode, val int, sum *int) {
    val <<= 1
    val = val | node.Val

    if node.Left == nil && node.Right == nil {
        // leaf
        *sum = *sum + val
        return
    }

    if node.Left != nil {
        dfs(node.Left, val, sum)
    }
    if node.Right != nil {
        dfs(node.Right, val, sum)
    }
}
```

### Explanation

This problem is the good template for DFS (Deep First Search) solutions.
