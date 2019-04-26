+++
date = "2019-04-25"
title = "LRU Cache"
slug = "LRU Cache"
tags = []
categories = []
+++

## Introduction

Design and implement a data structure for [Least Recently Used (LRU) cache](https://en.wikipedia.org/wiki/Cache_replacement_policies#LRU). It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reached its capacity, it should invalidate the least recently used item before inserting a new item.

Follow up:
Could you do both operations in O(1) time complexity?

Example:
```
LRUCache cache = new LRUCache( 2 /* capacity */ );

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

### Solution

MVCC solution:
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

### Explanation

The simplest solutions could be to add `revision` to each entry and global counter of revisions. Together with eviction list we can achieve required functionality.

Another way to implement LRUCache is to use double queue of entries and move entries to the tail on touch.

### Solution

Another solution is to use double linked-list.

``` go
type dequeue struct {
    head  *entry
    tail  *entry
}

type entry struct {
    key    int
    value  int
    prev   *entry
    next   *entry
}

func (q *dequeue) push(e *entry) {

    if q.tail == nil {
        q.head = e
        q.tail = e
    } else {    
        q.tail.next = e
        e.prev = q.tail
        q.tail = e
    }

}

func (q *dequeue) pop() *entry {

    if q.head != nil {

        e := q.head

        if e.next == nil {
            q.head, q.tail = nil, nil
        } else {
            q.head = e.next
            q.head.prev = nil
        }

        e.next, e.prev = nil, nil
        return e
    }
    return nil
}

func (q *dequeue) touch(e *entry) {

    if q.head == e {
        q.pop()
        q.push(e)
    } else if q.tail != e {
        e.prev.next = e.next
        e.next.prev = e.prev
        e.next, e.prev = nil, nil
        q.push(e)
    }

}

type LRUCache struct {
    cache    map[int]*entry
    size     int
    capacity int  
    queue    dequeue
}

func Constructor(capacity int) LRUCache {
    return LRUCache{ make(map[int]*entry), 0, capacity, dequeue{}}
}

func (this *LRUCache) evictOne() {

    e := this.queue.pop()
    if e != nil {
        delete(this.cache, e.key)
        this.size--
    }

}

func (this *LRUCache) Get(key int) int {
    if e, ok := this.cache[key]; ok {
        if this.size > 1 {
            this.queue.touch(e)
        }
        return e.value
    }
    return -1
}


func (this *LRUCache) Put(key int, value int)  {

    if e, ok := this.cache[key]; ok {
        e.value = value
        this.queue.touch(e)
    } else {

        if this.size == this.capacity {
            this.evictOne()
        }        

        e = &entry{key, value, nil, nil}
        this.queue.push(e)
        this.cache[key] = e
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

### Explanation

Double linked-list (dequeue) gives ability to remove entry in the middle on the queue and move it to the back. That what we need in case of touch of the entry.
