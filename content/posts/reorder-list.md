+++
date = "2019-04-25"
title = "Reorder List"
slug = "Reorder List"
tags = []
categories = []
+++

## Introduction

Given a singly linked list L: L0→L1→…→Ln-1→Ln,
reorder it to: L0→Ln→L1→Ln-1→L2→Ln-2→…

You may not modify the values in the list's nodes, only nodes itself may be changed.

Example 1:
```
Given 1->2->3->4, reorder it to 1->4->2->3.
```
Example 2:
```
Given 1->2->3->4->5, reorder it to 1->5->2->4->3.
```

### Solution

Memory solution:
``` C++
/**
 * Definition for singly-linked list.
 * struct ListNode {
 *     int val;
 *     ListNode *next;
 *     ListNode(int x) : val(x), next(NULL) {}
 * };
 */
class Solution {
public:
    void reorderList(ListNode* head) {

        std::vector<ListNode*> list;

        for (ListNode* i = head; i != NULL; i = i->next) {
            list.push_back(i);
        }

        int n = list.size();
        int m = n / 2;

        for (int i = 0; i < m; i++) {
            list[i]->next = list[n-i-1];
            list[n-i-1]->next = list[i+1];
        }

        if (m < n) {
            list[m]->next = NULL;
        }

    }
};
```

Memory solution:
``` go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reorderList(head *ListNode)  {

    list := []*ListNode{}

    for i := head; i != nil; i = i.Next {
        list = append(list, i)
    }

    n := len(list)
    m := n / 2

    for i := 0; i < m; i++ {
        list[i].Next = list[n-i-1]
        list[n-i-1].Next = list[i+1]
    }

    if m < n {
        list[m].Next = nil
    }

}
```

Reference solution
``` go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func reorderList(head *ListNode)  {

    slow := head
    for fast := head; fast != nil; slow = slow.Next {
        fast = fast.Next
        if fast != nil {
            fast = fast.Next
        }
    }

    even := revert(slow)

    prevj, i, j := &ListNode{}, head, even
    for j != nil {  
        prevj.Next = i
        i.Next, i = j, i.Next
        prevj, j = j, j.Next
    }
    if i != nil && i.Next == slow {
        prevj.Next = i
        i.Next = nil
    }


}

func revert(head *ListNode) *ListNode {

    var p *ListNode
    i := head

    for i != nil {
        i, i.Next, p = i.Next, p, i
    }

    return p
}
```

### Explanation

Memory solution is fast enough, it reverts the list in the array.
But there is a way to solve this problem without memory consumption.
Golang code looks slightly more simple than C++ code and works faster.
