+++
date = "2020-04-24"
title = "LRU Cache"
slug = "24 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Design and implement a data structure for Least Recently Used (LRU) cache. It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

The cache is initialized with a positive capacity.

Follow up:
Could you do both operations in O(1) time complexity?

Example:

LRUCache cache = new LRUCache( 2 );
```
cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.put(4, 4);    // evicts key 1
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4
```

## Solution

Classical task for version control. Let's add global revision for the cache and revision of each entry.


``` go
type entry struct {
    key    int
    value  int
    rev    int    
}

type keyrev struct {
    key    int
    rev    int
}

type LRUCache struct {
    cache    map[int]*entry
    q        []keyrev
    size     int
    capacity int  
    grev     int
}


func Constructor(capacity int) LRUCache {
    return LRUCache{ make(map[int]*entry), make([]keyrev, 0, capacity), 0, capacity, 1 }
}

func (this *LRUCache) touch(e *entry) {
    e.rev = this.grev
    this.grev++
    this.q = append(this.q, keyrev {e.key, e.rev} )
}

func (this *LRUCache) evictOne() {
    for len(this.q) > 0 {
        r := this.q[0]
        this.q = this.q[1:]
        if e, ok := this.cache[r.key]; ok && e.rev == r.rev {
            delete(this.cache, r.key)
            this.size--
            return
        }
    }
}


func (this *LRUCache) Get(key int) int {
    if e, ok := this.cache[key]; ok {
        this.touch(e)
        return e.value
    }
    return -1
}


func (this *LRUCache) Put(key int, value int)  {

    if e, ok := this.cache[key]; ok {
        e.value = value
        this.touch(e)
    } else {

        if this.size == this.capacity {
            this.evictOne()
        }        

        e = &entry{key, value, 0}
        this.cache[key] = e
        this.touch(e)

        this.size++
    }
}

/**
 * Your LRUCache object will be instantiated and called as such:
 * obj := Constructor(capacity);
 * param_1 := obj.Get(key);
 * obj.Put(key,value);
 */
```
