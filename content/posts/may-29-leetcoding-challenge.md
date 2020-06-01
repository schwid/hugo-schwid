+++
date = "2020-05-29"
title = "Course Schedule"
slug = "may 29 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

There are a total of numCourses courses you have to take, labeled from 0 to numCourses-1.

Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is expressed as a pair: [0,1]

Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?


Example 1:

Input: numCourses = 2, prerequisites = [[1,0]]
Output: true
Explanation: There are a total of 2 courses to take.
             To take course 1 you should have finished course 0. So it is possible.
Example 2:

Input: numCourses = 2, prerequisites = [[1,0],[0,1]]
Output: false
Explanation: There are a total of 2 courses to take.
             To take course 1 you should have finished course 0, and to take course 0 you should
             also have finished course 1. So it is impossible.


Constraints:
```
The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how a graph is represented.
You may assume that there are no duplicate edges in the input prerequisites.
1 <= numCourses <= 10^5
```


## Solution

Let's try to solve it by using BFS.
Every time when we visit graph that starts form course `i`, we mark it by `i+1` color.

``` go
func canFinish(numCourses int, prerequisites [][]int) bool {
    requiredBy := make([][]int, numCourses)

    for _, p := range prerequisites {
        i, j := p[0], p[1]
        requiredBy[j] = append(requiredBy[j], i)
    }

    visited := make([]int, numCourses)
    for i := 0; i < numCourses; i++ {
        q := []int { i }
        for len(q) > 0 {
            k := q[len(q)-1]
            q = q[:len(q)-1]
            if visited[k] == i+1 {
                continue
            }
            visited[k] = i+1
            for _, p := range requiredBy[k] {
                if p == i {
                    return false
                }
                q = append(q, p)
            }
        }
    }
    return true
}
```

Performance of this reference solution is:
```
Runtime: 20 ms
Memory Usage: 5.9 MB
```
