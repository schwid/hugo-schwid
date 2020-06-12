+++
date = "2020-06-12"
title = "Insert Delete GetRandom O(1)"
slug = "june 12 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Design a data structure that supports all following operations in average O(1) time.

insert(val): Inserts an item val to the set if not already present.
remove(val): Removes an item val from the set if present.
getRandom: Returns a random element from current set of elements. Each element must have the same probability of being returned.
Example:

// Init an empty set.
RandomizedSet randomSet = new RandomizedSet();

// Inserts 1 to the set. Returns true as 1 was inserted successfully.
randomSet.insert(1);

// Returns false as 2 does not exist in the set.
randomSet.remove(2);

// Inserts 2 to the set, returns true. Set now contains [1,2].
randomSet.insert(2);

// getRandom should return either 1 or 2 randomly.
randomSet.getRandom();

// Removes 1 from the set, returns true. Set now contains [2].
randomSet.remove(1);

// 2 was already in the set, so return false.
randomSet.insert(2);

// Since 2 is the only number in the set, getRandom always return 2.
randomSet.getRandom();

## Solution

Let's solve it with two maps, one is to store association between val and pos, another is opposite one.

``` go
import "math/rand"


type RandomizedSet struct {
    valToPos  map[int]int
    posToVal  map[int]int
}


/** Initialize your data structure here. */
func Constructor() RandomizedSet {
    return RandomizedSet { valToPos: make(map[int]int), posToVal: make(map[int]int) }
}


/** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
func (t *RandomizedSet) Insert(val int) bool {
    if _, ok := t.valToPos[val]; !ok {
        pos := len(t.valToPos)
        t.valToPos[val] = pos
        t.posToVal[pos] = val
        return true
    }
    return false
}


/** Removes a value from the set. Returns true if the set contained the specified element. */
func (t *RandomizedSet) Remove(val int) bool {
    if pos, ok := t.valToPos[val]; ok {
        delete(t.valToPos, val)
        n := len(t.posToVal)
        if n > 1 && n-1 != pos {
            lastPos := n-1
            lastVal := t.posToVal[lastPos]
            t.posToVal[pos] = lastVal
            t.valToPos[lastVal] = pos
            delete(t.posToVal, lastPos)
        } else {
            delete(t.posToVal, pos)  
        }
        return true
    }
    return false
}


/** Get a random element from the set. */
func (t *RandomizedSet) GetRandom() int {
    n := len(t.posToVal)
    switch n {
        case 0:
            return 0
        case 1:
            return t.posToVal[0]
        default:
            pos := rand.Intn(n)
            return t.posToVal[pos]
    }
}

/**
 * Your RandomizedSet object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Insert(val);
 * param_2 := obj.Remove(val);
 * param_3 := obj.GetRandom();
 */
```

Performance of this solution is:
```
Runtime: 28 ms
Memory Usage: 7.9 MB
```


Let's improve performance by replacing the second map by array

``` go
import "math/rand"


type RandomizedSet struct {
    valToPos  map[int]int
    posToVal  []int
}


/** Initialize your data structure here. */
func Constructor() RandomizedSet {
    return RandomizedSet { valToPos: make(map[int]int) }
}


/** Inserts a value to the set. Returns true if the set did not already contain the specified element. */
func (t *RandomizedSet) Insert(val int) bool {
    if _, ok := t.valToPos[val]; !ok {
        t.valToPos[val] = len(t.posToVal)
        t.posToVal = append(t.posToVal, val)
        return true
    }
    return false
}


/** Removes a value from the set. Returns true if the set contained the specified element. */
func (t *RandomizedSet) Remove(val int) bool {
    if pos, ok := t.valToPos[val]; ok {
        delete(t.valToPos, val)
        n := len(t.posToVal)
        if n > 1 && n-1 != pos {
            lastPos := n-1
            lastVal := t.posToVal[lastPos]
            t.posToVal[pos] = lastVal
            t.valToPos[lastVal] = pos
        }
        t.posToVal = t.posToVal[:n-1]
        return true
    }
    return false
}


/** Get a random element from the set. */
func (t *RandomizedSet) GetRandom() int {
    n := len(t.posToVal)
    switch n {
        case 0:
            return 0
        case 1:
            return t.posToVal[0]
        default:
            pos := rand.Intn(n)
            return t.posToVal[pos]
    }
}


/**
 * Your RandomizedSet object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Insert(val);
 * param_2 := obj.Remove(val);
 * param_3 := obj.GetRandom();
 */
```

Performance is the same:
```
Runtime: 28 ms
Memory Usage: 7.6 MB
```
