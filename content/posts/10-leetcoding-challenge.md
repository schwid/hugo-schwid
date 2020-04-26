+++
date = "2020-04-10"
title = "Min Stack"
slug = "10 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Design a stack that supports push, pop, top, and retrieving the minimum element in constant time.
```
push(x) -- Push element x onto stack.
pop() -- Removes the element on top of the stack.
top() -- Get the top element.
getMin() -- Retrieve the minimum element in the stack.
```

Example:
```
MinStac```k minStack = new MinStack();
minStack.push(-2);
minStack.push(0);
minStack.push(-3);
minStack.getMin();   --> Returns -3.
minStack.pop();
minStack.top();      --> Returns 0.
minStack.getMin();   --> Returns -2.
```

## Solution

Let's keep minSoFar together with value. This is stack, so it no need to be recalculated after pop().
For queue it could be more fun task.

``` go
type Node struct {
    val      int
    minSoFar int
}

type MinStack struct {
    stack []Node
    size  int
}


/** initialize your data structure here. */
func Constructor() MinStack {
    return MinStack {
    }
}


func (this *MinStack) Push(x int)  {
    if this.size == 0 {
        this.stack = []Node {  Node{ x, x } }
    } else {
        this.stack = append(this.stack, Node{ x, min(x, this.stack[this.size-1].minSoFar) })
    }
    this.size++
}


func (this *MinStack) Pop()  {
    if this.size > 0 {
        this.stack = this.stack[:this.size-1]
        this.size--
    }
}


func (this *MinStack) Top() int {
    if this.size > 0 {
        return this.stack[this.size-1].val
    }
    return -1
}


func (this *MinStack) GetMin() int {
    if this.size > 0 {
        return this.stack[this.size-1].minSoFar
    }
    return -1
}

func min(a, b int) int {
    if a < b {
        return a
    }
    return b
}


/**
 * Your MinStack object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Push(x);
 * obj.Pop();
 * param_3 := obj.Top();
 * param_4 := obj.GetMin();
 */
```
