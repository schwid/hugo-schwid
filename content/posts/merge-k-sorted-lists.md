+++
date = "2020-06-09"
title = "Merge k Sorted Lists"
slug = "23. Merge k Sorted Lists"
tags = []
categories = []
+++

## Introduction

Merge k sorted linked lists and return it as one sorted list. Analyze and describe its complexity.

Example:

Input:
```
[
  1->4->5,
  1->3->4,
  2->6
]
Output: 1->1->2->3->4->4->5->6
```

### Solution

Let's use golang heap internal implementation.

``` go
import "container/heap"

type HeapList []*ListNode

func (h HeapList) Len() int           { return len(h) }
func (h HeapList) Less(i, j int) bool { return h[i].Val < h[j].Val }
func (h HeapList) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h *HeapList) Push(x interface{}) {
	*h = append(*h, x.(*ListNode))
}

func (h *HeapList) Pop() interface{} {
	old := *h
	n := len(old)
	x := old[n-1]
	*h = old[0 : n-1]
	return x
}

/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func mergeKLists(lists []*ListNode) *ListNode {
    h := &HeapList{}
	heap.Init(h)
    for _, head := range lists {
        if head != nil {
            heap.Push(h, head)
        }
	}
    var head *ListNode
    var tail *ListNode
    for len(*h) > 0 {
        item := heap.Pop(h).(*ListNode)
        if item.Next != nil {
            heap.Push(h, item.Next)
        }
        item.Next = nil
        if head == nil {
            head, tail = item, item
        } else {
            tail.Next = item
            tail = item
        }
	}
    return head
}
```

Performance of golang heap is:
```
Runtime: 12 ms, faster than 70.63% of Go online submissions for Merge k Sorted Lists.
Memory Usage: 5.8 MB, less than 47.80% of Go online submissions for Merge k Sorted Lists.
```

Let's optimize by using own minHead impl for this task

``` go

type minheap struct {
    heapArray []*ListNode
    size      int
    maxsize   int
}

func newMinHeap(maxsize int) *minheap {
    minheap := &minheap{
        heapArray: []*ListNode{},
        size:      0,
        maxsize:   maxsize,
    }
    return minheap
}

func (m *minheap) empty() bool {
    return m.size == 0
}

func (m *minheap) leaf(index int) bool {
    if index >= (m.size/2) && index <= m.size {
        return true
    }
    return false
}

func (m *minheap) parent(index int) int {
    return (index - 1) / 2
}

func (m *minheap) leftchild(index int) int {
    return 2*index + 1
}

func (m *minheap) rightchild(index int) int {
    return 2*index + 2
}

func (m *minheap) insert(item *ListNode) error {
    if m.size >= m.maxsize {
        return fmt.Errorf("Heal is ful")
    }
    m.heapArray = append(m.heapArray, item)
    m.size++
    m.upHeapify(m.size - 1)
    return nil
}

func (m *minheap) swap(first, second int) {
    temp := m.heapArray[first]
    m.heapArray[first] = m.heapArray[second]
    m.heapArray[second] = temp
}

func (m *minheap) upHeapify(index int) {
    for m.heapArray[index].Val < m.heapArray[m.parent(index)].Val {
        m.swap(index, m.parent(index))
        index = m.parent(index)
    }
}

func (m *minheap) downHeapify(current int) {
    if m.leaf(current) {
        return
    }
    smallest := current
    leftChildIndex := m.leftchild(current)
    rightRightIndex := m.rightchild(current)
    //If current is smallest then return
    if leftChildIndex < m.size && m.heapArray[leftChildIndex].Val < m.heapArray[smallest].Val {
        smallest = leftChildIndex
    }
    if rightRightIndex < m.size && m.heapArray[rightRightIndex].Val < m.heapArray[smallest].Val {
        smallest = rightRightIndex
    }
    if smallest != current {
        m.swap(current, smallest)
        m.downHeapify(smallest)
    }
    return
}
func (m *minheap) buildMinHeap() {
    for index := ((m.size / 2) - 1); index >= 0; index-- {
        m.downHeapify(index)
    }
}

func (m *minheap) remove() *ListNode {
    top := m.heapArray[0]
    m.heapArray[0] = m.heapArray[m.size-1]
    m.heapArray = m.heapArray[:(m.size)-1]
    m.size--
    m.downHeapify(0)
    return top
}

/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func mergeKLists(lists []*ListNode) *ListNode {
    minHeap := newMinHeap(len(lists))
    for _, head := range lists {
        if head != nil {
            minHeap.insert(head)
        }
	}
    minHeap.buildMinHeap()
    var head *ListNode
    var tail *ListNode
    for !minHeap.empty() {
        item := minHeap.remove()
        if item.Next != nil {
            minHeap.insert(item.Next)
        }
        item.Next = nil
        if head == nil {
            head, tail = item, item
        } else {
            tail.Next = item
            tail = item
        }
	}
    return head
}
```


Performance of this custom solution is
```
Runtime: 8 ms, faster than 94.86% of Go online submissions for Merge k Sorted Lists.
Memory Usage: 5.8 MB, less than 46.78% of Go online submissions for Merge k Sorted Lists.
```
