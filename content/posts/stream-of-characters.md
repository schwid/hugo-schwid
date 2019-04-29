+++
date = "2019-04-29"
title = "Stream of Characters"
slug = "Stream of Characters"
tags = []
categories = []
+++

## Introduction

mplement the StreamChecker class as follows:

StreamChecker(words): Constructor, init the data structure with the given words.
query(letter): returns true if and only if for some k >= 1, the last k characters queried (in order from oldest to newest, including this letter just queried) spell one of the words in the given list.
 

Example:
```
StreamChecker streamChecker = new StreamChecker(["cd","f","kl"]); // init the dictionary.
streamChecker.query('a');          // return false
streamChecker.query('b');          // return false
streamChecker.query('c');          // return false
streamChecker.query('d');          // return true, because 'cd' is in the wordlist
streamChecker.query('e');          // return false
streamChecker.query('f');          // return true, because 'f' is in the wordlist
streamChecker.query('g');          // return false
streamChecker.query('h');          // return false
streamChecker.query('i');          // return false
streamChecker.query('j');          // return false
streamChecker.query('k');          // return false
streamChecker.query('l');          // return true, because 'kl' is in the wordlist
```

Note:
```
1 <= words.length <= 2000
1 <= words[i].length <= 2000
Words will only consist of lowercase English letters.
Queries will only consist of lowercase English letters.
The number of queries is at most 40000.
```

### Solution

Trie solution:
``` go
const (
    alfabet = 26
)

type trie struct {
    leaf   bool
    list   []*trie
}

func newTrie(leaf bool) *trie {
    return &trie{leaf, make([]*trie, alfabet)}
}

type StreamChecker struct {
    dict    *trie
    q       []*trie
}

func Constructor(words []string) StreamChecker {
    
    var s StreamChecker
    s.dict = newTrie(false)
    s.q = []*trie{ s.dict }
    
    for _, w := range words {
        node := s.dict
        for _, l := range w {
            idx := int(l) - 'a'
            if node.list[idx] == nil {
                node.list[idx] = newTrie(false)
            }
            node = node.list[idx]
        }
        node.leaf = true
    }
    return s
}

func (s *StreamChecker) Query(letter byte) bool {
    idx := int(letter) - 'a'
    newQ := []*trie{ s.dict }
    leaf := false
    for _, parent := range s.q {
        node := parent.list[idx]
        if node != nil {
            newQ = append(newQ, node)
            leaf = leaf || node.leaf
        }
    }
    s.q = newQ
    return leaf
}
```

Reverse Trie Solution:
``` go
const (
    alfabet = 26
)

type trie struct {
    leaf   bool
    list   []*trie
}

func newTrie(leaf bool) *trie {
    return &trie{leaf, make([]*trie, alfabet)}
}

type StreamChecker struct {
    dict    *trie
    q       []int
    maxLen    int
}

func Constructor(words []string) StreamChecker {
    
    var s StreamChecker
    s.dict = newTrie(false)
    s.q = []int{}
    
    for _, w := range words {
        
        n := len(w)
        
        node := s.dict
        for i := n-1; i >= 0; i-- {
            idx := int(w[i]) - 'a'
            if node.list[idx] == nil {
                node.list[idx] = newTrie(false)
            }
            node = node.list[idx]            
        }

        node.leaf = true
        
        if s.maxLen < n {
            s.maxLen = n
        }
    }
    
    return s
}

func (s *StreamChecker) Query(letter byte) bool {

    idx := int(letter) - 'a'
    s.q = append(s.q, idx)
    
    n := len(s.q)
    if n > s.maxLen {
        s.q = s.q[1:]
        n--
    }    
    
    node := s.dict
    for i := n-1; i >= 0; i-- {
        node = node.list[s.q[i]]
        
        if node == nil {
            return false
        }
        if node.leaf {
            return true
        }
    }
    return false
}

```

### Explanation

There are two solutions, both are using trie approach. One is the forward tries, seconds one is reverse trie. Second one works faster.
