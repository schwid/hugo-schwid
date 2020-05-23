+++
date = "2020-05-22"
title = "Sort Characters By Frequency"
slug = "may 22 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a string, sort it in decreasing order based on the frequency of characters.

Example 1:

Input:
"tree"

Output:
"eert"

Explanation:
'e' appears twice while 'r' and 't' both appear once.
So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
Example 2:

Input:
"cccaaa"

Output:
"cccaaa"

Explanation:
Both 'c' and 'a' appear three times, so "aaaccc" is also a valid answer.
Note that "cacaca" is incorrect, as the same characters must be together.
Example 3:

Input:
"Aabb"

Output:
"bbAa"

Explanation:
"bbaA" is also a valid answer, but "Aabb" is incorrect.
Note that 'A' and 'a' are treated as two different characters.

## Solution

Let's calculate frequency table and sort it with payload (character) and format output.

``` go
type IntPriority []int

func (p IntPriority) Len() int           { return len(p)/2 }
func (p IntPriority) Less(i, j int) bool { return p[i*2] > p[j*2] }
func (p IntPriority) Swap(i, j int)      { p[i*2], p[j*2], p[i*2+1], p[j*2+1] = p[j*2], p[i*2], p[j*2+1], p[i*2+1] }


func frequencySort(s string) string {
    freq := make([]int, 512)
    for i := 0; i <= 255; i++ {
        freq[i*2+1] = i  // payload is letter
    }
    for _, ch := range []byte(s) {
        freq[int(ch)*2]++
    }
    sort.Sort(IntPriority(freq))
    out := make([]byte, len(s))
    for i, k := 0, 0; i < 512 && freq[i] > 0; i += 2 {
        for j := 0; j < freq[i]; j++ {
            out[k] = byte(freq[i+1])
            k++
        }
    }
    return string(out)
}
```

Performance of this solution:
```
Runtime: 0 ms, faster than 100.00% of Go online submissions for Sort Characters By Frequency.
Memory Usage: 5 MB, less than 100.00% of Go online submissions for Sort Characters By Frequency.
```
