+++
date = "2019-05-20"
title = "Number of Segments in a String"
slug = "434. Number of Segments in a String"
tags = []
categories = []
+++

## Introduction

Count the number of segments in a string, where a segment is defined to be a contiguous sequence of non-space characters.

Please note that the string does not contain any non-printable characters.

Example:
```
Input: "Hello, my name is John"
Output: 5
```

### Solution

The trick here is that `strings.Split` function returns also empty tokens, that we need to escape.
Therefore, I am using `strings.FieldsFunc`

``` go
func countSegments(s string) int {
    return len(strings.FieldsFunc(s, func(c rune) bool {
            return c == ' '
    }))
}
```

### Performance

Nothing is to improve.

```
Runtime: 0 ms, faster than 100.00% of Go online submissions for Number of Segments in a String.
Memory Usage: 2 MB, less than 100.00% of Go online submissions for Number of Segments in a String.
```
