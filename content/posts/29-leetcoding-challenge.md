+++
date = "2020-04-29"
title = "Binary Tree Maximum Path Sum"
slug = "29 leetcoding challenge"
tags = []
categories = []
+++

## Introduction


Given a non-empty binary tree, find the maximum path sum.

For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree along the parent-child connections. The path must contain at least one node and does not need to go through the root.

Example 1:

Input: [1,2,3]
```
       1
      / \
     2   3
```

Output: 6

Example 2:

Input: [-10,9,20,null,null,15,7]
```
   -10
   / \
  9  20
    /  \
   15   7
```
Output: 42


## Solution

Let's try to solve this task with recursicve approach.
Any time we can have a situation that path can go thought the root node and not.
If it does not go through root node, then it probably will go through left or right child `max(maxPathSum(root.Left), maxPathSum(root.Right))`.
Another option is that it would come through the root node.

```go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxPathSum(root *TreeNode) int {
    if root == nil {
        return math.MinInt64
    }
    notIncludingRoot := max(maxPathSum(root.Left), maxPathSum(root.Right))
    leftSum := max(0, maxSum(root.Left))
    rightSum := max(0, maxSum(root.Right))
    includingRoot := root.Val + leftSum + rightSum
    return max(includingRoot, notIncludingRoot)
}

func maxSum(root *TreeNode) int {
    if root == nil {
        return 0
    }
    maxChild := max(maxSum(root.Left), maxSum(root.Right))
    return root.Val + max(0, maxChild)
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```

Recursion solution is simple, but slow, it runs for 244ms.
Let's add small checking layer to improve performance.

```go
/**
 * Definition for a binary tree node.
 * type TreeNode struct {
 *     Val int
 *     Left *TreeNode
 *     Right *TreeNode
 * }
 */
func maxPathSum(root *TreeNode) int {
    if root == nil {
        return math.MinInt64
    }
    notIncludingRoot := max(maxPathSum(root.Left), maxPathSum(root.Right))
    leftSum := max(0, maxSum(root.Left))
    rightSum := max(0, maxSum(root.Right))
    includingRoot := root.Val + leftSum + rightSum
    return max(includingRoot, notIncludingRoot)
}

var cache map[*TreeNode]int

func maxSum(root *TreeNode) int {
    if root == nil {
        return 0
    }
    if cache == nil {
        cache = make(map[*TreeNode]int)
    }
    if score, ok := cache[root]; ok {
        return score
    }
    maxChild := max(maxSum(root.Left), maxSum(root.Right))
    score := root.Val + max(0, maxChild)
    cache[root] = score
    return score
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```

This final solution gives 28ms, so almost 10x faster than without memorization.



