+++
date = "2019-04-29"
title = "Maximum XOR of Two Numbers in an Array"
slug = "Maximum XOR of Two Numbers in an Array"
tags = []
categories = []
+++

## Introduction

Given a non-empty array of numbers, a0, a1, a2, … , an-1, where 0 ≤ ai < 231.

Find the maximum result of ai XOR aj, where 0 ≤ i, j < n.

Could you do this in O(n) runtime?

Example:
```
Input: [3, 10, 5, 25, 2, 8]
Output: 28
Explanation: The maximum result is 5 ^ 25 = 28.
```

### Solution

Trie solution:
``` go
type trie struct {
    f *trie
    t *trie
}

func (root *trie) maxXor(num int) int {
    v := 0
    node := root
    if node.f == nil && node.t == nil {
        return 0
    }
    for i := 31; i >= 0; i-- {
        ui := uint(i)
        if ((num >> ui) & 1) > 0 {
            if node.f != nil {
                v |= (1 << ui)
                node = node.f
            } else if node.t != nil {
                node = node.t
            }
        } else {
            if node.t != nil {
                v |= (1 << ui)
                node = node.t
            } else if node.f != nil {
                node = node.f
            }   
        }
    }
    return v
}

func (root *trie) save(num int) {
    node := root
    for i := 31; i >= 0; i-- {
        ui := uint(i)
        if ((num >> ui) & 1) > 0 {
            if node.t == nil {
                node.t = &trie{nil, nil}
            }
            node = node.t
        } else {
            if node.f == nil {
                node.f = &trie{nil, nil}
            }
            node = node.f 
        }
    }   
}

func findMaximumXOR(nums []int) int {
    
    if len(nums) < 2 {
        return 0
    }
    
    root := &trie{nil, nil}
    maxSoFar := 0
    for _, num := range nums {
        v := root.maxXor(num)
        if maxSoFar < v {
            maxSoFar = v
        }
        root.save(num)
    }
    
    return maxSoFar
}
```

### Explanation

Lets store all bits in Trie from the most significat to less significant (BigEndian). 
In this case when we will search best opposite bit for xor operation the most significant bit will play more important role in max result than all the rest bits.
