+++
date = "2019-04-25"
title = "LFU Cache"
slug = "LFU Cache"
tags = []
categories = []
+++

## Introduction

Design and implement a data structure for [Least Frequently Used (LFU) cache](https://en.wikipedia.org/wiki/Least_frequently_used). It should support the following operations: get and put.

get(key) - Get the value (will always be positive) of the key if the key exists in the cache, otherwise return -1.
put(key, value) - Set or insert the value if the key is not already present. When the cache reaches its capacity, it should invalidate the least frequently used item before inserting a new item. For the purpose of this problem, when there is a tie (i.e., two or more keys that have the same frequency), the least recently used key would be evicted.

Follow up:
Could you do both operations in O(1) time complexity?

Example:
```
LFUCache cache = new LFUCache( 2 /* capacity */ );

cache.put(1, 1);
cache.put(2, 2);
cache.get(1);       // returns 1
cache.put(3, 3);    // evicts key 2
cache.get(2);       // returns -1 (not found)
cache.get(3);       // returns 3.
cache.put(4, 4);    // evicts key 1.
cache.get(1);       // returns -1 (not found)
cache.get(3);       // returns 3
cache.get(4);       // returns 4
```

### Solution

Linked-list solution
``` go

type dequeue struct {
    head   *entry
    tail   *entry
}

type entry struct {
    key    int
    value  int
    prev   *entry
    next   *entry
    block  *block
}

func (q dequeue) empty() bool {
    return q.tail == nil
}

func (q dequeue) single(e *entry) bool {
    return q.head == e && q.tail == e
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

func (q *dequeue) remove(e *entry) {

    if e.prev == nil {
        q.head = e.next
    } else {
        e.prev.next = e.next
    }

    if e.next == nil {
        q.tail = e.prev
    } else {
        e.next.prev = e.prev
    }

    e.next, e.prev = nil, nil    

}

type block struct {
    hits     int
    queue    dequeue
    next     *block
}

func (b* block) attach(e* entry) {
    b.queue.push(e)
    e.block = b
}

func (b* block) detach(e* entry) {
    b.queue.remove(e)
    e.block = nil
}

type LFUCache struct {
    cache    map[int]*entry
    size     int
    capacity int  
    ones     *block
}

func Constructor(capacity int) LFUCache {
    return LFUCache{ make(map[int]*entry), 0, capacity, &block{ 1, dequeue{nil, nil}, nil } }
}

func (this *LFUCache) evictOne() {

    e := this.ones.queue.pop()

    for b := this.ones.next; b != nil && e == nil; b = b.next {
        e = b.queue.pop()
        if b.queue.empty() {
            this.ones.next = b
        }
    }

    if e != nil {
        delete(this.cache, e.key)
        this.size--
    }

}

func (this *LFUCache) touch(e *entry) {

    currB := e.block
    hits := currB.hits + 1

    var nextB *block

    if currB.next == nil || currB.next.hits != hits {
        if currB != this.ones && currB.queue.single(e) {
            currB.hits = hits
            return
        }
        nextB = &block{hits, dequeue{nil, nil}, currB.next}
        currB.next = nextB
    } else {
        nextB = currB.next       
    }

    currB.detach(e)
    nextB.attach(e)  
}

func (this *LFUCache) Get(key int) int {
    if e, ok := this.cache[key]; ok {
        this.touch(e)
        return e.value
    }
    return -1
}

func (this *LFUCache) Put(key int, value int)  {

    if e, ok := this.cache[key]; ok {
        e.value = value
        this.touch(e)
    } else {

        if this.size >= this.capacity {
            this.evictOne()
        }        

        if this.size < this.capacity {
            e = &entry{key, value, nil, nil, this.ones}
            this.ones.queue.push(e)
            this.cache[key] = e
            this.size++
        }
    }    
}

/**
 * Your LFUCache object will be instantiated and called as such:
 * obj := Constructor(capacity);
 * param_1 := obj.Get(key);
 * obj.Put(key,value);
 */
```

### Explanation

This solution is based on LRU Cache plus we have additional linked list to store hits.

Complexity O(1) for get and put
