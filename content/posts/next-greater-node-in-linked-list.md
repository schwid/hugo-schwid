+++
date = "2019-05-01"
title = "Next Greater Node In Linked List"
slug = "Next Greater Node In Linked List"
tags = []
categories = []
+++

## Introduction

We are given a linked list with head as the first node.  Let's number the nodes in the list: node_1, node_2, node_3, ... etc.

Each node may have a next larger value: for node_i, next_larger(node_i) is the node_j.val such that j > i, node_j.val > node_i.val, and j is the smallest possible choice.  If such a j does not exist, the next larger value is 0.

Return an array of integers answer, where answer[i] = next_larger(node_{i+1}).

Note that in the example inputs (not outputs) below, arrays such as [2,1,5] represent the serialization of a linked list with a head node value of 2, second node value of 1, and third node value of 5.

 

Example 1:
```
Input: [2,1,5]
Output: [5,5,0]
```
Example 2:
```
Input: [2,7,4,3,5]
Output: [7,0,5,5,0]
```
Example 3:
```
Input: [1,7,5,1,9,2,5,1]
Output: [7,9,9,9,0,5,0,0]
```

Note:
```
1 <= node.val <= 10^9 for each node in the linked list.
The given list has length in the range [0, 10000].
```

### Solution

Simple O(n*n) solution:
``` go
/**
 * Definition for singly-linked list.
 * type ListNode struct {
 *     Val int
 *     Next *ListNode
 * }
 */
func nextLargerNodes(head *ListNode) []int {
    ret := []int{}
    
    for node := head; node != nil; node = node.Next{
        ret = append(ret, node.Val)     
    }
    
    n := len(ret)
    if n == 0 {
        return ret
    }

    for i := 0; i < n; i++ {
        ret[i] = nextLarger(ret[i+1:], ret[i])
    }
  
    return ret
}

func nextLarger(nums []int, val int) int {
    for _, n := range nums {
        if n > val {
            return n
        }
    }
    return 0
}
```


### Explanation

The simple O(n*n) solution could be to store data in array and use calculation function to find next bigger element in array.
