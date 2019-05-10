+++
date = "2019-05-09"
title = "Prefix and Suffix Search"
slug = "Prefix and Suffix Search"
tags = []
categories = []
+++

## Introduction

Given many words, words[i] has weight i.

Design a class WordFilter that supports one function, WordFilter.f(String prefix, String suffix). It will return the word with given prefix and suffix with maximum weight. If no word exists, return -1.

Examples:
```
Input:
WordFilter(["apple"])
WordFilter.f("a", "e") // returns 0
WordFilter.f("b", "") // returns -1
```

Note:
```
words has length in range [1, 15000].
For each test case, up to words.length queries WordFilter.f may be made.
words[i] has length in range [1, 10].
prefix, suffix have lengths in range [0, 10].
words[i] and prefix, suffix queries consist of lowercase letters only.
```

### Solution

Using hash map solution:
``` go
type WordFilter struct {
    cache map[string]int
}

func Constructor(words []string) WordFilter {
    
    cache := make(map[string]int)
    
    for index, w := range words {
        n := len(w)
        for i := 0; i <= min(n, 10); i++ {
            prefix := w[:i] 
            for j := max(0, n-10); j <= n; j++ {
                suffix := w[j:]                
                key := fmt.Sprintf("%s:%s", prefix, suffix)
                cache[key] = index
            }
        }
    }
    
    return WordFilter{cache}
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}

func (this *WordFilter) F(prefix string, suffix string) int {
    key := fmt.Sprintf("%s:%s", prefix, suffix)
    if v, ok := this.cache[key]; ok {
        return v
    }
    return -1
}

/**
 * Your WordFilter object will be instantiated and called as such:
 * obj := Constructor(words);
 * param_1 := obj.F(prefix,suffix);
 */
```

### Explanation

The first and very straigt forward solution is to use hash map. 
We can encode all combinations of the strings that possibly could be requested. 
All we need is to store hash map of prefixes joined with suffixes to make this possible. 

Lets optimize the task and move data from hash map to trait.
We already know that number of letters are 26 (from 'a' to 'z') and we need to reseve one slot for separator.
Let's keep the separator in the slot `0` and the rest of array will be references to other traits (26).

Here is the solution

### Another solution

Trait solution
``` go
const (
    trieSize = 27
)

type trie struct {
    list    []*trie   // lets keep separator in 0, and 1-26 are for letters a-z
    weight  int       // lets keep -1 for non-leaf nodes
}

var empty = &trie{ nil, -1 }

func (t *trie) find(idx int) *trie {
    if t.list == nil {
        return empty
    }
    c := t.list[idx]
    if c == nil {
        return empty
    } else {
        return c
    }
}

func (t *trie) upsert(idx int) *trie {
    if t.list == nil {
        t.list = make([]*trie, trieSize)
    }
    c := t.list[idx]
    if c == nil {
        c = &trie{nil, -1}
        t.list[idx] = c
    } 
    return c
}

func (t *trie) put(prefix, suffix string, weight int) {
    node := t
    for _, ch := range prefix {
        idx := int(ch - 'a' + 1)
        node = node.upsert(idx)    
    }
    node = node.upsert(0)
    for _, ch := range suffix {
        idx := int(ch - 'a' + 1)
        node = node.upsert(idx)    
    }    
    node.weight = weight
}

func (t *trie) get(prefix, suffix string) int {
    node := t
    for _, ch := range prefix {
        idx := int(ch - 'a' + 1)
        node = node.find(idx)    
    }
    node = node.find(0)
    for _, ch := range suffix {
        idx := int(ch - 'a' + 1)
        node = node.find(idx)    
    }    
    return node.weight   
}

type WordFilter struct {
    root *trie
}

func Constructor(words []string) WordFilter {
    
    root := &trie{ make([]*trie, trieSize), -1 }
    
    for index, w := range words {
        n := len(w)
        for i := 0; i <= min(n, 10); i++ {
            prefix := w[:i] 
            for j := max(0, n-10); j <= n; j++ {
                suffix := w[j:]         
                root.put(prefix, suffix, index)
            }
        }
    }
    
    return WordFilter{root}
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}

func (this *WordFilter) F(prefix string, suffix string) int {
    return this.root.get(prefix, suffix)
}

/**
 * Your WordFilter object will be instantiated and called as such:
 * obj := Constructor(words);
 * param_1 := obj.F(prefix,suffix);
 */
```

We can optimize a little bit put operation, just to remove not nesessary loop for prefix inside the trait and get better performance. 
Here we go:

``` go
const (
    trieSize = 27
)

type trie struct {
    list    []*trie   // lets keep separator in 0, and 1-26 are for letters a-z
    weight  int       // lets keep -1 for non-leaf nodes
}

var empty = &trie{ nil, -1 }

func (t *trie) find(idx int) *trie {
    if t.list == nil {
        return empty
    }
    c := t.list[idx]
    if c == nil {
        return empty
    } else {
        return c
    }
}

func (t *trie) upsert(idx int) *trie {
    if t.list == nil {
        t.list = make([]*trie, trieSize)
    }
    c := t.list[idx]
    if c == nil {
        c = &trie{nil, -1}
        t.list[idx] = c
    } 
    return c
}

func (t *trie) put(suffix string, weight int) {
    node := t
    for _, ch := range suffix {
        idx := int(ch - 'a' + 1)
        node = node.upsert(idx)
    }
    node.weight = weight
}

func (t *trie) get(prefix, suffix string) int {
    node := t
    for _, ch := range prefix {
        idx := int(ch - 'a' + 1)
        node = node.find(idx)    
    }
    node = node.find(0)
    for _, ch := range suffix {
        idx := int(ch - 'a' + 1)
        node = node.find(idx)    
    }    
    return node.weight   
}

type WordFilter struct {
    root *trie
}

func Constructor(words []string) WordFilter {
    
    root := &trie{ make([]*trie, trieSize), -1 }
    
    for index, w := range words {
        n := len(w)
        var node *trie
        for i := 0; i <= min(n, 10); i++ {
            if i == 0 {
                node = root
            } else {
                idx := int(w[i-1] - 'a' + 1)
                node = node.upsert(idx)
            }
            prefix := node.upsert(0)
            for j := max(0, n-10); j <= n; j++ {
                suffix := w[j:]         
                prefix.put(suffix, index)
            }
        }
    }
    
    return WordFilter{root}
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}

func (this *WordFilter) F(prefix string, suffix string) int {
    return this.root.get(prefix, suffix)
}

/**
 * Your WordFilter object will be instantiated and called as such:
 * obj := Constructor(words);
 * param_1 := obj.F(prefix,suffix);
 */
```

### Explanation

Trait is always a faster solution compare to hash map.
