+++
date = "2019-04-19"
title = "Linked List Cycle II"
slug = "Linked List Cycle II"
tags = []
categories = []
+++

## Introduction

Given a linked list, return the node where the cycle begins. If there is no cycle, return null.

To represent a cycle in the given linked list, we use an integer pos which represents the position (0-indexed) in the linked list where tail connects to. If pos is -1, then there is no cycle in the linked list.

Note: Do not modify the linked list.


Example 1:
```
Input: head = [3,2,0,-4], pos = 1
Output: tail connects to node index 1
Explanation: There is a cycle in the linked list, where tail connects to the second node.
```

Example 2:
```
Input: head = [1,2], pos = 0
Output: tail connects to node index 0
Explanation: There is a cycle in the linked list, where tail connects to the first node.
```

Example 3:
```
Input: head = [1], pos = -1
Output: no cycle
Explanation: There is no cycle in the linked list.
```

##### Follow up:
Can you solve it without using extra space?

### Solution

Simple solution:
``` go

type ListNode struct {
    Val  int
    Next *ListNode
}
func detectCycle(head *ListNode) *ListNode {

    if head == nil || head == head.Next {
        return head
    }

    for i, j := one(head), two(head); i != nil && j != nil; i, j = one(i), two(j) {
       if i == j {
           meet := i
           if meet == head {
               return meet
           }
           for i, j := one(meet), one(head); i != nil && j != nil; i, j = one(i), one(j) {
               if i == j {
                   return i
               }
           }  
       }
    }

    return nil

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

First `i` pointer goes one step a time, whereas second `j` pointer goes two steps a time.
When they meet, first `i` pointer will ahead in `T+X` steps, whereas seconds pointer `j` will go ahead on `N*2` steps.
Second pointer `j` will definitely do one loop before meeting `i`, because it is faster, so it will go `N+M` steps ahead.
At the same time `j` do two steps in one iteration, therefore `N+M`, must divide on `2`, that gives `M=N` and `N*2` steps for `j`.
We know that `N=T+X`, whereas `N` is the loop size, `T` is the tail size and `X` is unknown position where pointers will meet.
By using simple calculous we can find that `T=N-X`
To find the `T` in loop, we need to continue going till the end of the loop using pointer `i`, that will give us `N-X` steps, and start `j` pointer from the head, since it will go exactly `T` steps, they will definitely meet with each other.
