+++
date = "2019-09-19"
title = "Maximum Number of Balloons"
slug = "Maximum Number of Balloons"
tags = []
categories = []
+++

## Introduction



Given a string text, you want to use the characters of text to form as many instances of the word "balloon" as possible.

You can use each character in text at most once. Return the maximum number of instances that can be formed.

 

Example 1:
```
Input: text = "nlaebolko"
Output: 1
```

Example 2:
```
Input: text = "loonbalxballpoon"
Output: 2
```

Example 3:
```
Input: text = "leetcode"
Output: 0
```
 

Constraints:
```
    1 <= text.length <= 10^4
    text consists of lower case English letters only.
```

### Solution

``` go
func maxNumberOfBalloons(text string) int {
    cache := make([]int, 27)
    for _, ch := range text {
        i := ch - 'a'
        cache[i]++
    }
    cnt := 0
    s := "balloon"
    for {
        for _, ch := range s {
            i := ch - 'a'
            if cache[i] == 0 {
                return cnt
            }
            cache[i]--
        }
        cnt++
    }
    return cnt
}
```
