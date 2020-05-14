+++
date = "2020-05-14"
title = "Implement Trie (Prefix Tree)"
slug = "may 14 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Implement a trie with insert, search, and startsWith methods.

Example:
```
Trie trie = new Trie();

trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");   
trie.search("app");     // returns true
```

Note:
```
You may assume that all inputs are consist of lowercase letters a-z.
All inputs are guaranteed to be non-empty strings.
```

## Solution

Let's use the fact that we have only a-z characters in the words.
Therefore, the first data structure support to be an array `childs [26]*Trie`.
Also, we need a marker that particular node has the word. I am using `leaf`, event it could have childs, because I like it.
You can use whatever you like.

``` go

type Trie struct {
    childs [26]*Trie
    leaf   bool
}

func (t *Trie) get(ch byte) *Trie {
    return t.childs[ch - 'a']
}

func (t *Trie) getOrCreate(ch byte) *Trie {
    node := t.childs[ch - 'a']
    if node == nil {
        node = &Trie{}
        t.childs[ch - 'a'] = node
    }
    return node
}

/** Initialize your data structure here. */
func Constructor() Trie {
    return Trie{}
}


/** Inserts a word into the trie. */
func (this *Trie) Insert(word string)  {
    node := this
    for _, ch := range []byte(word) {
        node = node.getOrCreate(ch)
    }
    node.leaf = true
}


/** Returns if the word is in the trie. */
func (this *Trie) Search(word string) bool {
    node := this
    for _, ch := range []byte(word) {
        node = node.get(ch)
        if node == nil {
            return false
        }
    }
    return node.leaf
}


/** Returns if there is any word in the trie that starts with the given prefix. */
func (this *Trie) StartsWith(prefix string) bool {
    node := this
    for _, ch := range []byte(prefix) {
        node = node.get(ch)
        if node == nil {
            return false
        }
    }
    return true
}


/**
 * Your Trie object will be instantiated and called as such:
 * obj := Constructor();
 * obj.Insert(word);
 * param_2 := obj.Search(word);
 * param_3 := obj.StartsWith(prefix);
 */
```

Performance of this solution is
```
Runtime: 52 ms
Memory Usage: 15.9 MB
```

Hard to make it significantly faster...
