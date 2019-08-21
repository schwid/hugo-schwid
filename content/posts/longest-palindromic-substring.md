+++
date = "2019-08-21"
title = "Longest Palindromic Substring"
slug = "Longest Palindromic Substring"
tags = []
categories = []
+++

## Introduction

Given a string s, find the longest palindromic substring in s. You may assume that the maximum length of s is 1000.

Example 1:
```
Input: "babad"
Output: "bab"
Note: "aba" is also a valid answer.
```
Example 2:
```
Input: "cbbd"
Output: "bb"
```

### Solution

Let's start from less efficient but easy to implement bruteforce solution.
We assume that each character in string could be in the middle of the longest palindromic substring.
In this case we have two options: a) pattern *C* b) pattern *CC*.
We need to check both cases to find the longest palindromic substring.


``` go
func longestPalindrome(s string) string {
    
    n := len(s)
    if n == 0 {
        return ""
    }
    
    longest := s[:1]
    maxLength := 1
    
    for i := 0; i < n; i++ {
        
        cnt := min(i, n-i-1)
        
        left := s[i]
        right := s[i]
        
        for j := 1; j <= cnt && left == right; j++ {
            left ^= s[i-j]
            right ^= s[i+j]
            l := (i+j+1)-(i-j)
            if left == right && l > maxLength {
                longest = s[i-j:i+j+1]
                maxLength = l
            } 
        }
        
        if i+1 < n {
            
            cnt := min(i, n-i-2)   
            
            left := byte(0)
            right := byte(0)
            
            for j := 0; j <= cnt && left == right; j++ {
                left ^= s[i-j]
                right ^= s[i+1+j]
                l := (i+j+2)-(i-j)
                if left == right && l > maxLength {
                    longest = s[i-j:i+j+2]
                    maxLength = l
                } 
            }            
            
        }
        
    }
    
    return longest
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}
```

This is a good brute force solution that gives 8ms and pass the task, but let's improve it.

Let's add small optimization to this solution and to achieve faster performance.
In this case we need to check maxLength before going with counter for both cases.

``` go
func longestPalindrome(s string) string {
    
    n := len(s)
    if n == 0 {
        return ""
    }
    
    longest := s[:1]
    maxLength := 1
    
    for i := 0; i < n; i++ {
        
        cnt := min(i, n-i-1)
        
        if 1 + 2*cnt > maxLength {
        
            left := s[i]
            right := s[i]

            for j := 1; j <= cnt && left == right; j++ {
                left ^= s[i-j]
                right ^= s[i+j]
                l := (i+j+1)-(i-j)
                if left == right && l > maxLength {
                    longest = s[i-j:i+j+1]
                    maxLength = l
                } 
            }
        }
        
        if i+1 < n {
            
            cnt := min(i, n-i-2)   
            
            if (1+cnt) * 2 > maxLength {
            
                left := byte(0)
                right := byte(0)

                for j := 0; j <= cnt && left == right; j++ {
                    left ^= s[i-j]
                    right ^= s[i+1+j]
                    l := (i+j+2)-(i-j)
                    if left == right && l > maxLength {
                        longest = s[i-j:i+j+2]
                        maxLength = l
                    } 
                }        
                
            }
            
        }
        
    }
    
    return longest
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}
```

This gives 4ms execution for all test cases and shows that very minor optimization can give amazing results.
Let's go forward and take in account that the longest possible palindromic subscring is likely would have a middle character
in the middle of input string. Let's shift the ring of iterating from `[0, n)` on `n/2` steps forward, by adding

``` go
    m := n/2
    for k := 0; k < n; k++ {
        i := (k + m) % n
        ...
    }
```

So, finally we will have the fastest golang solution that works on 0ms.

``` go
func longestPalindrome(s string) string {
    
    n := len(s)
    if n == 0 {
        return ""
    }
    
    longest := s[:1]
    maxLength := 1
    m := n/2
    
    for k := 0; k < n; k++ {
        
        i := (k + m) % n
        cnt := min(i, n-i-1)
        
        if 1 + 2*cnt > maxLength {
        
            left := s[i]
            right := s[i]

            for j := 1; j <= cnt && left == right; j++ {
                left ^= s[i-j]
                right ^= s[i+j]
                l := (i+j+1)-(i-j)
                if left == right && l > maxLength {
                    longest = s[i-j:i+j+1]
                    maxLength = l
                } 
            }
        }
        
        if i+1 < n {
            
            cnt := min(i, n-i-2)   
            
            if (1+cnt) * 2 > maxLength {
            
                left := byte(0)
                right := byte(0)

                for j := 0; j <= cnt && left == right; j++ {
                    left ^= s[i-j]
                    right ^= s[i+1+j]
                    l := (i+j+2)-(i-j)
                    if left == right && l > maxLength {
                        longest = s[i-j:i+j+2]
                        maxLength = l
                    } 
                }        
                
            }
            
        }
        
    }
    
    return longest
    
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}
```

