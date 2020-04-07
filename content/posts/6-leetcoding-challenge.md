+++
date = "2020-04-06"
title = "Group Anagrams"
slug = "Group Anagrams"
tags = []
categories = []
+++

## Introduction

Given an array of strings, group anagrams together.

Example:
```
Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
Output:
[
  ["ate","eat","tea"],
  ["nat","tan"],
  ["bat"]
]
Note:
```

All inputs will be in lowercase.
The order of your output does not matter.

## Solution

One of the possible solutions could be a creation of unique key that does not depends on the order of letters in string.

``` go
func getKey(s string) string {
	var stack [27]int
	for i := 0; i < len(stack); i++ {
		stack[i] = 0
	}
	for _, ch := range s {
		stack[ch-'a']++
	}
	var out strings.Builder
	for i, v := range stack {
		if v > 0 {
			out.WriteByte(byte(i + 'a'))
			out.WriteString(strconv.Itoa(v))
		}
	}
	return out.String()
}

func groupAnagrams(strs []string) [][]string {
	cache := make(map[string][]string)
	for _, s := range strs {
		key := getKey(s)
		cache[key] = append(cache[key], s)
	}
	var out [][]string
	for _, arr := range cache {
		out = append(out, arr)
	}
	return out
}
```

Another possible solution is to use in-place sorting of the letters to create a key

``` go
import "sort"

type ByteSlice []byte

func (p ByteSlice) Len() int           { return len(p) }
func (p ByteSlice) Less(i, j int) bool { return p[i] < p[j] }
func (p ByteSlice) Swap(i, j int)      { p[i], p[j] = p[j], p[i] }

func getKey(s string) string {
    arr := []byte(s)
    sort.Sort(ByteSlice(arr))
    return string(arr)
}

func groupAnagrams(strs []string) [][]string {
    cache := make(map[string][]string)
    for _, s := range strs {
        key := getKey(s)
        cache[key] = append(cache[key], s)
    }
    var out [][]string
    for _, arr := range cache {
        out = append(out, arr)
    }
    return out
}
```
