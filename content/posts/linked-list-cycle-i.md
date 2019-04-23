+++
date = "2019-04-19"
title = "Linked List Cycle"
slug = "Linked List Cycle"
tags = []
categories = []
+++

## Introduction

Given a linked list, determine if it has a cycle in it.

To represent a cycle in the given linked list, we use an integer pos which represents the position (0-indexed) in the linked list where tail connects to. If pos is -1, then there is no cycle in the linked list.

Example 1:
```
Input: head = [3,2,0,-4], pos = 1
Output: true
Explanation: There is a cycle in the linked list, where tail connects to the second node.
```

Example 2:
```
Input: head = [1,2], pos = 0
Output: true
Explanation: There is a cycle in the linked list, where tail connects to the first node.
```

Example 3:
```
Input: head = [1], pos = -1
Output: false
Explanation: There is no cycle in the linked list.
```

##### Follow up:

Can you solve it using O(1) (i.e. constant) memory?

### Solution

Simple solution:
``` go
type ListNode struct {
    Val int
    Next *ListNode
}

func hasCycle(head *ListNode) bool {

    if head == nil {
        return false
    }

    for i, j := one(head), two(head); i != nil && j != nil; i, j = one(i), two(j) {
       if i == j {
            return true
       }
    }

    return false
}

func one(node *ListNode) *ListNode {
    return node.Next
}

func two(node *ListNode) *ListNode {
    next := node.Next
    if next == nil {
        return nil
    } else {
        return next.Next
    }
}
```

### Explanation

We need two pointers, `i` will do one step a time, `j` will do two steps a time. We have cycle only if they meet each other.
