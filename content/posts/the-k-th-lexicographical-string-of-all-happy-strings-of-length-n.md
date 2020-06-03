+++
date = "2020-06-02"
title = "The k-th Lexicographical String of All Happy Strings of Length n"
slug = "1415. The k-th Lexicographical String of All Happy Strings of Length n"
tags = []
categories = []
+++

## Introduction

A happy string is a string that:

consists only of letters of the set ['a', 'b', 'c'].
s[i] != s[i + 1] for all values of i from 1 to s.length - 1 (string is 1-indexed).
For example, strings "abc", "ac", "b" and "abcbabcbcb" are all happy strings and strings "aa", "baa" and "ababbc" are not happy strings.

Given two integers n and k, consider a list of all happy strings of length n sorted in lexicographical order.

Return the kth string of this list or return an empty string if there are less than k happy strings of length n.


Example 1:
```
Input: n = 1, k = 3
Output: "c"
Explanation: The list ["a", "b", "c"] contains all happy strings of length 1. The third string is "c".
```

Example 2:
```
Input: n = 1, k = 4
Output: ""
Explanation: There are only 3 happy strings of length 1.
```

Example 3:
```
Input: n = 3, k = 9
Output: "cab"
Explanation: There are 12 different happy string of length 3 ["aba", "abc", "aca", "acb", "bab", "bac", "bca", "bcb", "cab", "cac", "cba", "cbc"]. You will find the 9th string = "cab"
```

Example 4:
```
Input: n = 2, k = 7
Output: ""
```

Example 5:
```
Input: n = 10, k = 100
Output: "abacbabacb"
```

Constraints:
```
1 <= n <= 10
1 <= k <= 100
```

## Solution

Let's calculate all possible combinations in sorted order and take k-th one.

``` go
func getHappyString(n int, k int) string {

    m := 3 << (n-1)
    if k > m {
        return ""
    }

    list := HappyList(n)
    if len(list) >= k {
        return list[k-1]
    }

    return ""

}

func HappyList(n int) []string {
    if n == 0 {
        return []string{}
    }
    if n == 1 {
        return []string { "a", "b", "c" }
    }
    var out []string
    for _, one := range HappyList(1) {
        for _, s := range HappyList(n-1) {
            if s[0] != one[0] {
                out = append(out, one + s)
            }
        }
    }
    return out
}
```

## Preformance

```
Runtime: 696 ms, faster than 5.71% of Go online submissions for The k-th Lexicographical String of All Happy Strings of Length n.
Memory Usage: 6.8 MB, less than 100.00% of Go online submissions for The k-th Lexicographical String of All Happy Strings of Length n.
```

Performance of this solution is very low.
In this case let's generate only k-th element.
On each step we have 3 intervals: [a...], [b...], [c...], so the selection of the interval is based on k.
Then we switch to previous intervals that were used to build current ones, we can not have two letters one after another,
therefore [a...] interval built by `"a" + [b..]` and `"a" + [c..]`

```
[a...] -> [skip], [b..], [c..] -> plus half
[b...] -> [a..], [skip], [c..] -> plus half if greater than half
[c...] -> [a..], [b..], [skip] -> the same
```


``` go
func getHappyString(n int, k int) string {

    var out []byte

    for i := n-1; i >= 0; i-- {
        a := 1 << i
        b := 2 << i
        c := 3 << i
        h := a >> 1
        if k <= a {
            out = append(out, 'a')
            k += h
        } else if k <= b {
            out = append(out, 'b')
            k -= a
            if k > h {
                k += h
            }
        } else if k <= c {
            out = append(out, 'c')
            k -= b
        } else {
            return ""
        }
    }

    return string(out)
}
```

## Performance

Now we have fastest performance

```
Runtime: 0 ms, faster than 100.00% of Go online submissions for The k-th Lexicographical String of All Happy Strings of Length n.
Memory Usage: 2.1 MB, less than 100.00% of Go online submissions for The k-th Lexicographical String of All Happy Strings of Length n.
```
