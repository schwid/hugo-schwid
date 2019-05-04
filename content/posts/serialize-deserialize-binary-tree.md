+++
date = "2019-05-02"
title = "Deserialize and serialize a binary tree"
slug = "Deserialize and serialize a binary tree"
tags = []
categories = []
+++

## Introduction

Write the serializer and deserializer to int array for binary tree.

Binary tree structure 
``` go
type Node struct {
	Val int
	Left *Node
	Right *Node
}

func (n *Node) String() string {
	if n == nil {
		return "nil"
	}
	return fmt.Sprintf("Node{ Val=%d, Left=%v, Right=%v }", n.Val, n.Left, n.Right)
}
```

### Solution

DFS solution:
``` go
func Serialize(root *Node) []int {
	var list []int
	if root != nil {
		list = dfsSerialize(root, 0, 0, list)
	}
	return list
}

func dfsSerialize(node *Node, level, sign int, list []int) []int {
	list = append(list, level * sign)
	list = append(list, node.Val)
	if node.Left != nil {
		list = dfsSerialize(node.Left, level + 1, 1, list)
	}
	if node.Right != nil {
		list = dfsSerialize(node.Right, level + 1, -1, list)
	}
	return list
}

func Deserialize(list []int) *Node {
	node, _ := dfsDeserialize(list, 0, 0, 0)
	return node
}

func dfsDeserialize(list []int, pos, level, sign int) (*Node, int) {
	if pos + 2 > len(list) {
		return nil, pos
	}
	if list[pos] != level * sign {
		return nil, pos
	}
	node := &Node{list[pos+1], nil, nil}
	pos += 2
	node.Left, pos = dfsDeserialize(list, pos, level+1, 1)
	node.Right, pos = dfsDeserialize(list, pos, level+1, -1)
	return node, pos
}
```

Tests:
``` go
func create() *Node {
	root := &Node{3,
		&Node{2, nil, nil},
		&Node{7,
			&Node{7, nil, nil},
			&Node{8, nil, nil},
		},
	}
	return root
}

func TestDfs(t *testing.T) {
	node := create()
	fmt.Print(node, "\n")
	list := Serialize(node)
	fmt.Print(list, "\n")
	n := Deserialize(list)
	fmt.Print(n, "\n")
}
```

Output of tests:
```
Node{ Val=3, Left=Node{ Val=2, Left=nil, Right=nil }, Right=Node{ Val=7, Left=Node{ Val=7, Left=nil, Right=nil }, Right=Node{ Val=8, Left=nil, Right=nil } } }
[0 3 1 2 -1 7 2 7 -2 8]
Node{ Val=3, Left=Node{ Val=2, Left=nil, Right=nil }, Right=Node{ Val=7, Left=Node{ Val=7, Left=nil, Right=nil }, Right=Node{ Val=8, Left=nil, Right=nil } } }
PASS
```

### Explanation

Lets use DFS (Deep First Search) approach with "Preorder" to store the tree in to array by encoding root by `0`, left nodes by `+level` and right nodes by `-level` control codes before values.
This gives ability to use stack to implement serializer and deserializer by using recursion.


