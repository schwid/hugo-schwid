+++
date = "2019-05-11"
title = "Flower Planting With No Adjacent"
slug = "Flower Planting With No Adjacent"
tags = []
categories = []
+++

## Introduction


You have N gardens, labelled 1 to N.  In each garden, you want to plant one of 4 types of flowers.

paths[i] = [x, y] describes the existence of a bidirectional path from garden x to garden y.

Also, there is no garden that has more than 3 paths coming into or leaving it.

Your task is to choose a flower type for each garden such that, for any two gardens connected by a path, they have different types of flowers.

Return any such a choice as an array answer, where answer[i] is the type of flower planted in the (i+1)-th garden.  The flower types are denoted 1, 2, 3, or 4.  It is guaranteed an answer exists.



Example 1:
```
Input: N = 3, paths = [[1,2],[2,3],[3,1]]
Output: [1,2,3]
```

Example 2:
```
Input: N = 4, paths = [[1,2],[3,4]]
Output: [1,2,1,2]
```

Example 3:
```
Input: N = 4, paths = [[1,2],[2,3],[3,4],[4,1],[1,3],[2,4]]
Output: [1,2,3,4]
```

Note:
```
1 <= N <= 10000
0 <= paths.size <= 20000
No garden has 4 or more paths coming into or leaving it.
It is guaranteed an answer exists.
```

### Solution

Simple Solution
``` go
func gardenNoAdj(N int, paths [][]int) []int {

    gardens := make([]int, N+1)

    for i := 1; i <= N; i++ {

        if gardens[i] == 0 {

            used := []bool {false, false, false, false, false}

            for _, p := range paths {

                if p[0] == i && gardens[p[1]] != 0 {
                    used[gardens[p[1]]] = true
                }

                if p[1] == i && gardens[p[0]] != 0 {
                    used[gardens[p[0]]] = true
                }

            }

            for j, u := range used[1:] {
                if !u {
                    gardens[i] = j + 1
                    break
                }
            }

        }

    }

    return gardens[1:]
}
```


### Explanation

All we need is to ask neighbors about already using color, and select one that no one neighbor is using.
Lets improve this solution by using maps to store paths.

Therefore, the fastest solution would be like this:
``` go
type garden struct {
    color      int
    neighbors  map[int]bool
}

func gardenNoAdj(N int, paths [][]int) []int {

    gardens := make([]*garden, N+1)

    for i := 0; i <= N; i++ {
        gardens[i] = &garden{ 0, make(map[int]bool) }
    }

    for _, p := range paths {
        gardens[p[0]].neighbors[p[1]] = true
        gardens[p[1]].neighbors[p[0]] = true        
    }

    for i := 1; i <= N; i++ {

        if gardens[i].color == 0 {

            used := []bool {false, false, false, false, false}

            for nb, _ := range gardens[i].neighbors {
                used[gardens[nb].color] = true
            }

            for j, u := range used[1:] {
                if !u {
                    gardens[i].color = j + 1
                    break
                }
            }

        }

    }

    colors := make([]int, N)
    for i, g := range gardens[1:] {
        colors[i] = g.color
    }

    return colors
}
```
