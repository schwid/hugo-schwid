+++
date = "2019-04-27"
title = "Sort Linked List"
slug = "Sort Linked List"
tags = []
categories = []
+++

## Introduction

Sort a linked list in O(n log n) time using constant space complexity.

Example 1:
```
Input: 4->2->1->3
Output: 1->2->3->4
```
Example 2:
```
Input: -1->5->3->4->0
Output: -1->0->3->4->5
```

### Solution

Quicksort:
``` go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func sortList(head *ListNode) *ListNode {

    var last *ListNode
    for i := head; i != nil; i = i.Next {
        last = i
    }

    quicksort(head, last)
    return head
}

func quicksort(first *ListNode, last *ListNode) {
    if first == nil || first == last {
        return
    }
    if first.Next == last {
        if first.Val > last.Val {
            last.Val, first.Val = first.Val, last.Val
        }
        return
    }
    p, prev := partition(first, last)
    if prev != nil {
        quicksort(first, prev)
    }
    if p != last {
        quicksort(p.Next, last)
    }
}

func partition(first *ListNode, last *ListNode) (*ListNode, *ListNode) {
    pivot := last.Val
    var prev *ListNode
    i := first
    for j := first; j != last; j = j.Next {
        if j.Val < pivot {
            i.Val, j.Val = j.Val, i.Val
            prev = i
            i = i.Next
        }
    }
    i.Val, last.Val = last.Val, i.Val
    return i, prev
}
```

Mergesort:
``` go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func sortList(head *ListNode) *ListNode {
    return mergesort(head, nil)
}

func mergesort(head, tail *ListNode) *ListNode {

    if head == tail {
        return nil
    }

    if head.Next == tail {
        return &ListNode{head.Val, nil}
    }

    if head.Next.Next == tail {
        first := head
        second := head.Next

        if first.Val > second.Val {
            first, second = second, first
        }
        return &ListNode{ first.Val, &ListNode{ second.Val, nil } }
    }

    slow, fast := head, head
    for ; fast != tail; slow = slow.Next {
        fast = fast.Next
        if fast != tail {
            fast = fast.Next
        }
    }

    left := mergesort(head, slow)
    right := mergesort(slow, tail)

    return merge(left, right)
}

func merge(left, right *ListNode) *ListNode {

    var root, node *ListNode
    i, j := left, right

    for {
        var add *ListNode

        if i != nil {
            if j != nil {
                if i.Val < j.Val {
                    add = i
                    i = i.Next
                } else {
                    add = j
                    j = j.Next
                }
            } else {
                add = i
                i = i.Next                
            }
        } else if j != nil {
            add = j
            j = j.Next            
        } else {
            break
        }
        if root == nil {
            root = &ListNode{ add.Val, nil }
            node = root
        } else {
            node.Next = &ListNode{ add.Val, nil }
            node = node.Next
        }
    }

    return root
}
```

### Explanation

Quick sort solution on each iteration takes last element in the range and compare other elements with this one by divinding the range for lower and higher. That selected element has a fixed position in finally sorted array.

 Merge sort is another faster solution, it works better because it constantly has complexity O(n*log(n)), whereas quicksort in some cases can have complexity up to O(n*n)
