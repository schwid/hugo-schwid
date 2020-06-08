+++
date = "2020-06-06"
title = "Queue Reconstruction by Height"
slug = "june 6 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Suppose you have a random list of people standing in a queue. Each person is described by a pair of integers (h, k), where h is the height of the person and k is the number of people in front of this person who have a height greater than or equal to h. Write an algorithm to reconstruct the queue.

Note:
The number of people is less than 1,100.

Example

Input:
```
[[7,0], [4,4], [7,1], [5,0], [6,1], [5,2]]
```

Output:
```
[[5,0], [7,0], [5,2], [6,1], [4,4], [7,1]]
```

## Solution

Let's first solve this problem with brute force method and then try to optimize.


For example this simple solution on arrays easy to understand:
``` go
func higherCnt(p []int, line [][]int) int {
	cnt := 0
	for _, inFront := range line {
		if p[0] <= inFront[0] {
			cnt++
		}
	}
	return cnt
}

func reconstructQueue(people [][]int) [][]int {
	var line [][]int
	for len(people) > 0 {
		minHeightGuy := -1
		for i, p := range people {
			if higherCnt(p, line) == p[1] {
				if minHeightGuy == -1 || people[minHeightGuy][0] > p[0] {
					minHeightGuy = i
				}
			}
		}
		if minHeightGuy == -1 {
			panic("can not reconstruct queue")
		}
		line = append(line, people[minHeightGuy])
		people = append(people[:minHeightGuy], people[minHeightGuy+1:]...)
	}
	return line
}
```

Performance of this solution is:
```
Runtime: 1412 ms
Memory Usage: 5.9 MB
```


Let's pre-sort all people by height and very small modification of code gives 3x performance.

``` go

type People  [][]int

func (p People) Len() int           { return len(p) }
func (p People) Less(i, j int) bool { return p[i][0]  < p[j][0] }
func (p People) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func higherCnt(p []int, line [][]int) int {
	cnt := 0
	for _, inFront := range line {
		if p[0] <= inFront[0] {
			cnt++
		}
	}
	return cnt
}

func reconstructQueue(people [][]int) [][]int {
	var line [][]int
	sort.Sort(People(people))
	for len(people) > 0 {
		minHeightGuy := -1
		for i, p := range people {
			if higherCnt(p, line) == p[1] {
				minHeightGuy = i
				break
			}
		}
		if minHeightGuy == -1 {
			panic("can not build queue")
		}
		line = append(line, people[minHeightGuy])
		people = append(people[:minHeightGuy], people[minHeightGuy+1:]...)
	}
	return line
}
```

Performance:
```
Runtime: 696 ms
Memory Usage: 5.8 MB
```

Let's replace ordered array of people with dual linked list

``` go
type People  [][]int

func (p People) Len() int           { return len(p) }
func (p People) Less(i, j int) bool { return p[i][0]  < p[j][0] }
func (p People) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func higherCnt(p []int, line [][]int) int {
	cnt := 0
	for _, inFront := range line {
		if p[0] <= inFront[0] {
			cnt++
		}
	}
	return cnt
}

type person struct {
	val  []int
	prev *person
	next *person
}

type orderedPeople struct {
	head *person
	tail *person
}

func (t orderedPeople) isEmpty() bool {
	return t.head == nil
}

func (t *orderedPeople) pushBack(p *person) {
	if t.head == nil {
		t.head, t.tail = p, p
	} else {
		p.prev = t.tail
		t.tail.next = p
		t.tail = p
	}
}

func (t *orderedPeople) remove(p *person) {
	if t.head == p {
		if t.tail == p {
			t.head, t.tail = nil, nil
		} else {
			newHead := t.head.next
			newHead.prev, p.next = nil, nil
			t.head = newHead
		}
	} else if t.tail == p {
		newTail := t.tail.prev
		newTail.next, p.prev = nil, nil
		t.tail = newTail
	} else {
		prev, next := p.prev, p.next
		prev.next, next.prev = next, prev
		p.next, p.prev = nil, nil
	}
}


func reconstructQueue(people [][]int) [][]int {
	var line [][]int
	var order orderedPeople
	sort.Sort(People(people))
	for _, p := range people {
		order.pushBack( &person{ p, nil, nil } )
	}
	for !order.isEmpty() {
		var minHeightGuy *person
		for i := order.head; i != nil; i = i.next {
			if higherCnt(i.val, line) == i.val[1] {
				minHeightGuy = i
				break
			}
		}
		if minHeightGuy == nil {
			panic("can not reconstruct queue")
		}
		line = append(line, minHeightGuy.val)
		order.remove(minHeightGuy)
	}
	return line
}
```

Performance:
```
Runtime: 708 ms
Memory Usage: 5.8 MB
```

Let's replace line of people by binary tree

``` go

type People  [][]int

func (p People) Len() int           { return len(p) }
func (p People) Less(i, j int) bool { return p[i][0]  < p[j][0] }
func (p People) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }


type person struct {
	val  []int
	prev *person
	next *person
}

type orderedPeople struct {
	head *person
	tail *person
}

func (t orderedPeople) isEmpty() bool {
	return t.head == nil
}

func (t *orderedPeople) pushBack(p *person) {
	if t.head == nil {
		t.head, t.tail = p, p
	} else {
		p.prev = t.tail
		t.tail.next = p
		t.tail = p
	}
}

func (t *orderedPeople) remove(p *person) {
	if t.head == p {
		if t.tail == p {
			t.head, t.tail = nil, nil
		} else {
			newHead := t.head.next
			newHead.prev, p.next = nil, nil
			t.head = newHead
		}
	} else if t.tail == p {
		newTail := t.tail.prev
		newTail.next, p.prev = nil, nil
		t.tail = newTail
	} else {
		prev, next := p.prev, p.next
		prev.next, next.prev = next, prev
		p.next, p.prev = nil, nil
	}
}

type node struct {
	val int
	cntGreaterOrEqual int
	left *node
	right *node
}

func (t *node) increment(val int) {
	if t.val == val {
		t.cntGreaterOrEqual++
	} else if t.val > val {
		if t.left == nil {
			t.left = &node { val, 1, nil, nil }
		} else {
			t.left.increment(val)
		}
	} else {
		t.cntGreaterOrEqual++
		if t.right == nil {
			t.right = &node { val, 1, nil, nil }
		} else {
			t.right.increment(val)
		}
	}
}

func (t *node) countGreaterOrEqual(val int) int {
	if t.val == val {
		return t.cntGreaterOrEqual
	} else if t.val > val {
		cnt := t.cntGreaterOrEqual
		if t.left != nil {
			cnt += t.left.countGreaterOrEqual(val)
		}
		return cnt
	} else if t.right != nil {
		return t.right.countGreaterOrEqual(val)
	} else {
		return 0
	}
}


type tree struct {
	root *node
}

func (t *tree) increment(val int) {
	if t.root == nil {
		t.root = &node { val, 1, nil, nil }
	} else {
		t.root.increment(val)
	}
}

func (t *tree) countGreaterOrEqual(val int) int {
	if t.root == nil {
		return 0
	} else {
		return t.root.countGreaterOrEqual(val)
	}
}

func reconstructQueue(people [][]int) [][]int {
	var counter tree
	var line [][]int
	var order orderedPeople
	sort.Sort(People(people))
	for _, p := range people {
		order.pushBack( &person{ p, nil, nil } )
	}
	for !order.isEmpty() {
		var minHeightGuy *person
		for i := order.head; i != nil; i = i.next {
			if counter.countGreaterOrEqual(i.val[0]) == i.val[1] {
				minHeightGuy = i
				break
			}
		}
		if minHeightGuy == nil {
			panic("can not reconstruct queue")
		}
		line = append(line, minHeightGuy.val)
		counter.increment(minHeightGuy.val[0])
		order.remove(minHeightGuy)
	}
	return line
}
```

This solution gives this performance
```
Runtime: 96 ms
Memory Usage: 5.9 MB
```

And finally, elegant solution is to track indexes of possible candidates

``` go
type People  [][]int

func (p People) Len() int           { return len(p) }
func (p People) Less(i, j int) bool {
    if p[i][0] == p[j][0] {
        return p[i][1] > p[j][1]
    }
    return p[i][0] < p[j][0]
}
func (p People) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func reconstructQueue(people [][]int) [][]int {
	sort.Sort(People(people))
  n := len(people)
  idx := make([]int, n)
	for i := 0; i < n; i++ {
		idx[i] = i
	}
	line := make([][]int, n)
	for _, p := range people {
		line[idx[p[1]]] = p
		idx = append(idx[:p[1]], idx[p[1]+1:]...)
	}
	return line
}
```


This solution gives this performance
```
Runtime: 12 ms
Memory Usage: 5.9 MB
```
