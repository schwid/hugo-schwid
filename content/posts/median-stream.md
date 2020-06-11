+++
date = "2020-06-10"
title = "Median Stream"
slug = "Median Stream"
tags = []
categories = []
+++

## Introduction

You're given a list of n integers arr[0..(n-1)]. You must compute a list output[0..(n-1)] such that, for each index i (between 0 and n-1, inclusive), output[i] is equal to the median of the elements arr[0..i] (rounded down to the nearest integer).

The median of a list of integers is defined as follows. If the integers were to be sorted, then:
If there are an odd number of integers, then the median is equal to the middle integer in the sorted order.
Otherwise, if there are an even number of integers, then the median is equal to the average of the two middle-most integers in the sorted order.

### Signature

int[] findMedian(int[] arr)

Input
```
n is in the range [1, 1,000,000].
Each value arr[i] is in the range [1, 1,000,000].
```
Output
```
Return a list of n integers output[0..(n-1)], as described above.
```
Example 1
```
n = 4
arr = [5, 15, 1, 3]
output = [5, 10, 5, 4]
```
The median of [5] is 5, the median of [5, 15] is (5 + 15) / 2 = 10, the median of [5, 15, 1] is 5, and the median of [5, 15, 1, 3] is (3 + 5) / 2 = 4.

Example 2
```
n = 2
arr = [1, 2]
output = [1, 1]
```
The median of [1] is 1, the median of [1, 2] is (1 + 2) / 2 = 1.5 (which should be rounded down to 1).

### Solution

Let's use two heaps: maxHeap for numbers less than median, minHeap for numbers greater than median.
On each step we need to balance heaps in the way that first one have to be equal or greater one size of second one.
Median is the top element on minHeap or if sizes are equal then average of top elements of both heaps.


``` go
package main

import (
	"container/heap"
	"encoding/json"
	"fmt"
)

type MinHeap []int

func (h MinHeap) Len() int           { return len(h) }
func (h MinHeap) Less(i, j int) bool { return h[i] < h[j] }
func (h MinHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h MinHeap) Top() int           { return h[0] }

func (h *MinHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MinHeap) Pop() interface{} {
	arr := *h
	n := len(arr)
	x := arr[n-1]
	*h = arr[0 : n-1]
	return x
}

type MaxHeap []int

func (h MaxHeap) Len() int           { return len(h) }
func (h MaxHeap) Less(i, j int) bool { return h[i] > h[j] }
func (h MaxHeap) Swap(i, j int)      { h[i], h[j] = h[j], h[i] }

func (h MaxHeap) Top() int           { return h[0] }

func (h *MaxHeap) Push(x interface{}) {
	*h = append(*h, x.(int))
}

func (h *MaxHeap) Pop() interface{} {
	arr := *h
	n := len(arr)
	x := arr[n-1]
	*h = arr[0 : n-1]
	return x
}

func findMedian(arr []int) []int {
	n := len(arr)
	out := make([]int, n)

	// lower elements
	maxHeap := &MaxHeap{}
	heap.Init(maxHeap)

	// Higher elements
	minHeap := &MinHeap{}
	heap.Init(minHeap)

	for i := 0; i < n; i++ {

		if minHeap.Len() > 0 && minHeap.Top() < arr[i] {
			heap.Push(minHeap, arr[i])

			if maxHeap.Len()-1 < minHeap.Len() {
				heap.Push(maxHeap, heap.Pop(minHeap))
			}

		} else {
			heap.Push(maxHeap, arr[i])

			if maxHeap.Len()-1 > minHeap.Len() {
				heap.Push(minHeap, heap.Pop(maxHeap))
			}
		}


		median := maxHeap.Top()
		if maxHeap.Len() == minHeap.Len() {
			median = ( median + minHeap.Top() ) / 2
		}
		out[i] = median

	}
	return out
}

func min(a, b int) int {
	if a < b {
		return a
	}
	return b
}

func main() {
	arrStr := "[5, 15, 1, 3]"

	var arr []int
	json.Unmarshal([]byte(arrStr), &arr)

	out := findMedian(arr)
	fmt.Printf("actual = %v\n", out)
	println("expected =  [5, 10, 5, 4]")

	arrStr = "[2, 4, 7, 1, 5, 3]"

	json.Unmarshal([]byte(arrStr), &arr)

	out = findMedian(arr)
	fmt.Printf("actual = %v\n", out)
	println("expected =  [2, 3, 4, 3, 4, 3]")

}
```

Performance is good.
