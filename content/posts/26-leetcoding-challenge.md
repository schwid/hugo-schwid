+++
date = "2020-04-26"
title = "Longest Common Subsequence"
slug = "26 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given two strings text1 and text2, return the length of their longest common subsequence.

A subsequence of a string is a new string generated from the original string with some characters(can be none) deleted without changing the relative order of the remaining characters. (eg, "ace" is a subsequence of "abcde" while "aec" is not). A common subsequence of two strings is a subsequence that is common to both strings.


If there is no common subsequence, return 0.


Example 1:

Input: text1 = "abcde", text2 = "ace"
Output: 3  
Explanation: The longest common subsequence is "ace" and its length is 3.
Example 2:

Input: text1 = "abc", text2 = "abc"
Output: 3
Explanation: The longest common subsequence is "abc" and its length is 3.
Example 3:

Input: text1 = "abc", text2 = "def"
Output: 0
Explanation: There is no such common subsequence, so the result is 0.


Constraints:
```
1 <= text1.length <= 1000
1 <= text2.length <= 1000
The input strings consist of lowercase English characters only.
```

## Solution

This is a classical task for dynamic programming.
You, probably can solve it with recursion and memorization, but it would be a lot of coding and it would not show performance of DP (dynamic programming).

How to solve it?

First of all we have two strings and we need to calculate their lengths:
``` go
  n, m := len(text1), len(text2)
```

We would need O(n*m) complexity to go through all letters and M((n+1) * (m+1)) memory to keep DP table.

What would be in DP cell? The answer is in task requirements: "return the length ..."

So, let's take the last letter from the first string.
We have two options:
* the last letter of the first string is participating in longest common subsequence
* not participating

Suppose, it is participating, therefore it would be found one or more times the same letter in the second string.
Let's consider this loop:
``` go
i := n-1
for j := 0; j < m; j++ {
  if text1[i] == text2[j] {
    // FOUND
  }
}
```

Let's shift the loop for one to the left, logic is the same, but it more useful later:
``` go
i := n
for j := 1; j <= m; j++ {
  if text1[i-1] == text2[j-1] {
    // FOUND
  }
}
```

Every time when we found the matching letter in the second string, we can reduce the current task in to the smaller one `longestCommonSubsequence(text1[:i-1], text2[:j-1])` plus one for matching letter.

If  we did not found the letter, we have two options:
* reduce the last character from text1 `longestCommonSubsequence(text1[:i-1], text2[:j])`
* reduce the last character from text2 `longestCommonSubsequence(text1[:i], text2[:j-1])`

As we see, this task is easy to solve with recursion, but this solution would be too slow, because of repeating calls. With memorization you can get much better performance and pass.
But it would be easy to use memory table with size `(n+1) * (m+1)` to store all results from execution of `longestCommonSubsequence(text[:i], text[:j])`, that called dynamic programming.
We reserve additional space dp[0][0...m+1] equal 0 in order to simplify loop and computations.

On recursion it would be like this:
``` go
if text1[i-1] == text2[j-1] {
    lcs = longestCommonSubsequence(text1[:i-1], text2[:j-1]) + 1
} else {
    lcs = max(longestCommonSubsequence(text1[:i-1], text2[:j]), longestCommonSubsequence(text1[:i], text2[:j-1]) )
}
maxSoFar = max(maxSoFar, lcs)
```

We can rewrite this code in DP approach by replacing calling the function by the memory cell on `dp[i][j]`.

``` go
if text1[i-1] == text2[j-1] {
    dp[i][j] = dp[i-1][j-1] + 1
} else {
    dp[i][j] = max(dp[i-1][j], dp[i][j-1])
}
```

So, finally we need to initialize `dp` array and iterate all strings from beginning.

DP solution is:
``` go
func longestCommonSubsequence(text1 string, text2 string) int {

    n, m := len(text1), len(text2)

    dp := make([][]int, n+1)
    dp[0] = make([]int, m+1)

    for i := 1; i <= n; i++ {
         dp[i] = make([]int, m+1)

        for j := 1; j <= m; j++ {

            if text1[i-1] == text2[j-1] {
                dp[i][j] = dp[i-1][j-1] + 1
            } else {
                dp[i][j] = max(dp[i-1][j], dp[i][j-1])
            }
        }
    }

    return dp[n][m]
}

func max(a, b int) int {
    if a > b {
        return a
    }
    return b
}
```

Performance.
This is the best possible solution.
```
Runtime: 0 ms
Memory Usage: 10.4 MB
```
