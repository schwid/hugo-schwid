+++
date = "2020-06-04"
title = "String Compression"
slug = "443. String Compression"
tags = []
categories = []
+++

## Introduction
Given an array of characters, compress it in-place.

The length after compression must always be smaller than or equal to the original array.

Every element of the array should be a character (not int) of length 1.

After you are done modifying the input array in-place, return the new length of the array.


Follow up:
Could you solve it using only O(1) extra space?


Example 1:

Input:
```
["a","a","b","b","c","c","c"]
```

Output:
```
Return 6, and the first 6 characters of the input array should be: ["a","2","b","2","c","3"]
```

Explanation:
```
"aa" is replaced by "a2". "bb" is replaced by "b2". "ccc" is replaced by "c3".
```

Example 2:

Input:
```
["a"]
```

Output:
```
Return 1, and the first 1 characters of the input array should be: ["a"]
```

Explanation:
Nothing is replaced.


Example 3:

Input:
```
["a","b","b","b","b","b","b","b","b","b","b","b","b"]
```

Output:
```
Return 4, and the first 4 characters of the input array should be: ["a","b","1","2"].
```

Explanation:
```
Since the character "a" does not repeat, it is not compressed. "bbbbbbbbbbbb" is replaced by "b12".
Notice each digit has it's own entry in the array.
```

Note:
```
All characters have an ASCII value in [35, 126].
1 <= len(chars) <= 1000.
```

### Solution

Let's solve this problem by using internal function `strconv.Itoa`.

``` go
func compress(chars []byte) int {
    prev := byte(0)
    cnt := 0
    j := 0
    for _, ch := range chars {
        if ch == prev {
            cnt++
            continue
        }
        if prev != 0 {
            j = writeLem(prev, cnt, chars, j)
        }
        prev = ch
        cnt = 1
    }
    if prev != 0 {
        j = writeLem(prev, cnt, chars, j)
    }
    return j
}

func writeLem(ch byte, cnt int, chars []byte, j int) int {
    chars[j] = ch
    j++
    if cnt > 1 {
        bs := []byte(strconv.Itoa(cnt))
        copy(chars[j:], bs)
        j += len(bs)
    }
    return j
}
```

Performance of this solution is
```
Runtime: 4 ms
Memory Usage: 2.8 MB
```

Let's improve it by replacing the Itoa

``` go
const MAX_LEN_POW10 = 1000

func compress(chars []byte) int {
    prev := byte(0)
    cnt := 0
    j := 0
    for _, ch := range chars {
        if ch == prev {
            cnt++
            continue
        }
        if prev != 0 {
            j = writeLem(prev, cnt, chars, j)
        }
        prev = ch
        cnt = 1
    }
    if prev != 0 {
        j = writeLem(prev, cnt, chars, j)
    }
    return j
}

func writeLem(ch byte, cnt int, chars []byte, j int) int {
    chars[j] = ch
    j++
    if cnt > 1 {
        leading := true
        for i := MAX_LEN_POW10; i >= 1; i /= 10 {
            digit := (cnt / i) % 10
            if digit == 0 && leading {
                continue
            }
            leading = false
            chars[j] = byte('0' + digit)
            j++
        }
    }
    return j
}
```


Performance of this solution is
```
Runtime: 4 ms, faster than 98.36% of Go online submissions for String Compression.
Memory Usage: 2.8 MB, less than 100.00% of Go online submissions for String Compression.
```

Let's combine all functions together in one loop
``` go
const MAX_LEN_POW10 = 1000

func compress(chars []byte) int {
    j, cnt := 0, 1
    n := len(chars)
    for i := 0; i < n; i++ {
        if i+1 < n && chars[i] == chars[i+1] {
            cnt++
            continue
        }
        chars[j] = chars[i]
        j++
        if cnt > 1 {
            leading := true
            for i := MAX_LEN_POW10; i >= 1; i /= 10 {
                digit := (cnt / i) % 10
                if digit == 0 && leading {
                    continue
                }
                leading = false
                chars[j] = byte('0' + digit)
                j++
            }
        }
        cnt = 1
    }
    return j
}
```

Performance is the same:
```
Runtime: 4 ms, faster than 98.36% of Go online submissions for String Compression.
Memory Usage: 2.8 MB, less than 100.00% of Go online submissions for String Compression.
```
