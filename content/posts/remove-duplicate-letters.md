+++
date = "2020-03-31"
title = "Remove Duplicate Letters"
slug = "Remove Duplicate Letters"
tags = []
categories = []
+++

## Introduction

Given a string which contains only lowercase letters, remove duplicate letters so that every letter appears once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.

Example 1:
```
Input: "bcabc"
Output: "abc"
```
Example 2:
```
Input: "cbacdcbc"
Output: "acdb"
```

This task is similar to 'Smallest Subsequence of Distinct Characters'.

Return the lexicographically smallest subsequence of text that contains all the distinct characters of text exactly once.

Example 1:
```
Input: "cdadabcc"
Output: "adbc"
```

Example 2:
```
Input: "abcd"
Output: "abcd"
```

Example 3:
```
Input: "ecbacba"
Output: "eacb"
```

Example 4:
```
Input: "leetcode"
Output: "letcod"
```

Example 5:
```
Input: "degbgjchgibedhgcdicccdhjjcegicgjejfbhijedbafgjigff"
Output: "bcdefhagji"
```

Constraints:
```
    1 <= text.length <= 1000
    text consists of lowercase English letters.
```


### Solution


The fastest solution on golang.
```
Runtime: 0 ms, faster than 100.00% of Go online submissions for Remove Duplicate Letters.
Memory Usage: 2.1 MB, less than 100.00% of Go online submissions for Remove Duplicate Letters.
```

We need to go through all letters one by one and check two options:
* Include letter at the end of building sequence
* Not-Include letter at the end of building sequence

If we include letter at the end of building sequence, then we delete previous inserted position in building sequence.

We adding the letter only if this can improve our result.


Here is the solution:
``` go
func removeDuplicateLetters(text string) string {

	n := len(text)
	if n == 0 {
		return ""
	}

	freq := make([]int, 27)
	for i := 0; i < n; i++ {
		freq[text[i] - 'a']++
	}

	var out []byte

	for i := 0; i < n; i++ {
		ch := text[i]

		idx := bytes.IndexByte(out, ch)
		if idx == -1 {
			out = append(out, ch)
		} else if willBeBetter(out[idx+1:], ch, freq) {
			out = append(out[:idx], out[idx+1:]...)
			out = append(out, ch)
		}

		freq[text[i] - 'a']--

	}

	return string(out)
}

func willBeBetter(outSuffix []byte, ch byte, freq []int) bool {
	m := len(outSuffix)
	for j := 0; j < m; j++ {
		nextCh := outSuffix[j]
		if nextCh < ch {
			return true
		}
		if freq[nextCh - 'a'] == 0 {
			return false
		}
	}
	return false
}
```

I am using frequency (freq) of letters to detect, would it be better to retain  or append double visited letter or not.
If frequency of characters that are greater than visiting one greater zero, we can ignore them
```
		if freq[nextCh - 'a'] == 0 {
			return false
		}
```
If next character is less than visiting one, then it could be better if we remove visiting prev letter and append at the end.
```
		nextCh := outSuffix[j]
		if nextCh < ch {
			return true
		}
```

