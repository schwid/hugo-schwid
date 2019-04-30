+++
date = "2019-04-30"
title = "Camelcase Matching"
slug = "Camelcase Matching"
tags = []
categories = []
+++

## Introduction

A query word matches a given pattern if we can insert lowercase letters to the pattern word so that it equals the query. (We may insert each character at any position, and may insert 0 characters.)

Given a list of queries, and a pattern, return an answer list of booleans, where answer[i] is true if and only if queries[i] matches the pattern.

 

Example 1:
```
Input: queries = ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FB"
Output: [true,false,true,true,false]
Explanation: 
"FooBar" can be generated like this "F" + "oo" + "B" + "ar".
"FootBall" can be generated like this "F" + "oot" + "B" + "all".
"FrameBuffer" can be generated like this "F" + "rame" + "B" + "uffer".
```
Example 2:
```
Input: queries = ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FoBa"
Output: [true,false,true,false,false]
Explanation: 
"FooBar" can be generated like this "Fo" + "o" + "Ba" + "r".
"FootBall" can be generated like this "Fo" + "ot" + "Ba" + "ll".
```
Example 3:
```
Input: queries = ["FooBar","FooBarTest","FootBall","FrameBuffer","ForceFeedBack"], pattern = "FoBaT"
Output: [false,true,false,false,false]
Explanation: 
"FooBarTest" can be generated like this "Fo" + "o" + "Ba" + "r" + "T" + "est".
```

### Solution

Compile pattern solution:
``` go
type lemma struct {
    camel  bool
    s     string
}

func (l lemma) String() string {
    return fmt.Sprintf("camel=%v,s=%s", l.camel, l.s)
}

func isCamel(ch byte) bool {
    return ch >= 'A' && ch <= 'Z'
}

func readLemma(s string) (*lemma, string) {
    
    n := len(s)
    
    if n == 0 {
        return nil, ""
    }
    
    if isCamel(s[0]) {
        return &lemma{true, s[:1]}, s[1:]
    } else {
        i := 0
        for ; i < n && !isCamel(s[i]); i++ {
        }
        return &lemma{false, s[:i]}, s[i:]
    }
    
}

func compile(pattern string) []*lemma {
    
    ret := []*lemma{}

    s := pattern
    for len(s) > 0 {
        
        var lem *lemma
        lem, s = readLemma(s)
        
        if lem != nil {
            ret = append(ret, lem)
        }
        
    }
    
    return ret
    
}

func match(exp []*lemma, q string) bool {
    
    n := len(exp)
    m := len(q)
    
    i, j := 0, 0
    
    for ;i < n && j < m; i++ {
        
        e := exp[i]
        
        if e.camel {
            
            for ;j < m && !isCamel(q[j]); j++ {
            }
            
            if j == m {
                break
            }
            
            if q[j] != e.s[0] {
                return false
            }
            
            j++
            
        } else {
            
            slen := len(e.s)
            k := 0
            for ;j < m && !isCamel(q[j]); j++ {
                if k < slen && e.s[k] == q[j] {
                    k++
                }
            } 
            
            if k != slen {
                return false
            } 
            
        }
        
    }
    
    for ;j < m && !isCamel(q[j]); j++ {
    }    
    
    return i == n && j == m
}

func camelMatch(queries []string, pattern string) []bool {
 
    exp := compile(pattern)
    //fmt.Print(exp)
    
    ret := []bool{}
    for _, q := range queries {
        ret = append(ret, match(exp, q))
    }
    return ret
}
```

Skip lowercase solution
``` go

func isLowercase(ch byte) bool {
    return ch >= 'a' && ch <= 'z'
}

func camelMatch(queries []string, pattern string) []bool {
     
    n := len(pattern)
    
    ret := []bool{}
    
    for _, q := range queries {
        
        m := len(q)
        i, j := 0, 0
        
        for j < m {
            
            if i < n && q[j] == pattern[i] {
                j++
                i++
            } else if isLowercase(q[j]) {
                j++
            } else {
                break
            }
            
        }
        
        ret = append(ret, i == n && j == m)
    }

    return ret
}
```


### Explanation

We need to compile pattern in to the form where we split all lemmas that are substrings with upper or lower case.
Based on flag we have different compare logic between lemmas from queries.

Another way to solve this problem is to skip all lower case characters that does not exist in pattern.
