+++
date = "2020-05-02"
title = "Jewels and Stones"
slug = "may 2 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You're given strings J representing the types of stones that are jewels, and S representing the stones you have.  Each character in S is a type of stone you have.  You want to know how many of the stones you have are also jewels.

The letters in J are guaranteed distinct, and all characters in J and S are letters. Letters are case sensitive, so "a" is considered a different type of stone from "A".

Example 1:

Input: J = "aA", S = "aAAbbbb"
Output: 3

Example 2:
Input: J = "z", S = "ZZ"
Output: 0
Note:
S and J will consist of letters and have length at most 50.
The characters in J are distinct.


## Solution

We need to cache Jewels for O(1) check. Array works better than map, because it is faster and we can use it (limited max 256 variations of Jewels).

``` go
func numJewelsInStones(J string, S string) int {
    cache := make([]bool, 256)
    for _, ch := range J {
        cache[int(ch)] = true
    }
    cnt := 0
    for _, ch := range S {
        if cache[int(ch)] {
            cnt++
        }
    }
    return cnt
}
```
