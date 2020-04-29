+++
date = "2020-04-28"
title = "First Unique Number"
slug = "28 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You have a queue of integers, you need to retrieve the first unique integer in the queue.

Implement the FirstUnique class:

FirstUnique(int[] nums) Initializes the object with the numbers in the queue.
int showFirstUnique() returns the value of the first unique integer of the queue, and returns -1 if there is no such integer.
void add(int value) insert value to the queue.


Example 1:
```
Input:
["FirstUnique","showFirstUnique","add","showFirstUnique","add","showFirstUnique","add","showFirstUnique"]
[[[2,3,5]],[],[5],[],[2],[],[3],[]]
Output:
[null,2,null,2,null,3,null,-1]
```

Explanation:
```
FirstUnique firstUnique = new FirstUnique([2,3,5]);
firstUnique.showFirstUnique(); // return 2
firstUnique.add(5);            // the queue is now [2,3,5,5]
firstUnique.showFirstUnique(); // return 2
firstUnique.add(2);            // the queue is now [2,3,5,5,2]
firstUnique.showFirstUnique(); // return 3
firstUnique.add(3);            // the queue is now [2,3,5,5,2,3]
firstUnique.showFirstUnique(); // return -1
```

Example 2:
```
Input:
["FirstUnique","showFirstUnique","add","add","add","add","add","showFirstUnique"]
[[[7,7,7,7,7,7]],[],[7],[3],[3],[7],[17],[]]
Output:
[null,-1,null,null,null,null,null,17]
```

Explanation:
```
FirstUnique firstUnique = new FirstUnique([7,7,7,7,7,7]);
firstUnique.showFirstUnique(); // return -1
firstUnique.add(7);            // the queue is now [7,7,7,7,7,7,7]
firstUnique.add(3);            // the queue is now [7,7,7,7,7,7,7,3]
firstUnique.add(3);            // the queue is now [7,7,7,7,7,7,7,3,3]
firstUnique.add(7);            // the queue is now [7,7,7,7,7,7,7,3,3,7]
firstUnique.add(17);           // the queue is now [7,7,7,7,7,7,7,3,3,7,17]
firstUnique.showFirstUnique(); // return 17
```

Example 3:
```
Input:
["FirstUnique","showFirstUnique","add","showFirstUnique"]
[[[809]],[],[809],[]]
Output:
[null,809,null,-1]
```

Explanation:
```
FirstUnique firstUnique = new FirstUnique([809]);
firstUnique.showFirstUnique(); // return 809
firstUnique.add(809);          // the queue is now [809,809]
firstUnique.showFirstUnique(); // return -1
```

Constraints:

```
1 <= nums.length <= 10^5
1 <= nums[i] <= 10^8
1 <= value <= 10^8
At most 50000 calls will be made to showFirstUnique and add.
```

## Solution

This task is a general engineering task with tradeoff between CPU usage and memorry.
Let's rely on golang capability to have cheap and fast maps to cache unique and non-unique numbers.
In this case the only complex thing left is implementation of dual-linked queue with two primary methods: push_back and remove.
For 20 years in industry I implemented 100+ times dual queue remove and add methods, so just remember this solution and repeat it any time you need.

``` go
type Node struct {
    val  int
    prev *Node
    next *Node
}

type FirstUnique struct {
    non_unique  map[int]bool   
    unique      map[int]*Node
    head        *Node
    tail        *Node
}


func Constructor(nums []int) FirstUnique {
    cache := make(map[int]int)
    for _, num := range nums {
        cache[num]++
    }

    this := FirstUnique { make(map[int]bool), make(map[int]*Node), nil, nil }

    for _, num := range nums {
        if cache[num] == 1 {
            this.unique[num] = this.push_back(num)
        } else {
            this.non_unique[num] = true
        }
    }
    return this
}


func (this *FirstUnique) ShowFirstUnique() int {
    if this.head != nil {
        return this.head.val
    }
    return -1
}


func (this *FirstUnique) Add(value int)  {
    if this.non_unique[value] {
        return
    }
    if node, ok := this.unique[value]; ok {
        delete(this.unique, value)
        this.remove(node)
        this.non_unique[value] = true
    } else {
        this.unique[value] = this.push_back(value)
    }
}


func (this *FirstUnique) push_back(value int) *Node {
    if this.head == nil || this.tail == nil {
        node := &Node { val: value }
        this.head = node
        this.tail = node
        return node
    } else {
        node := &Node {
             val: value,
             prev: this.tail,
        }
        this.tail.next = node
        this.tail = node
        return node
    }
}

func (this *FirstUnique) remove(node *Node)  {
    if this.tail == node {
        if this.head == this.tail {
            this.head = nil
            this.tail = nil
            return
        }    
        newTail := this.tail.prev
        newTail.next = nil
        this.tail = newTail
        return
    }
    if this.head == node {
        newHead := this.head.next
        newHead.prev = nil
        this.head = newHead
        return
    }
    left := node.prev
    right := node.next
    left.next = right
    right.prev = left
}


/**
 * Your FirstUnique object will be instantiated and called as such:
 * obj := Constructor(nums);
 * param_1 := obj.ShowFirstUnique();
 * obj.Add(value);
 */
```
