+++
date = "2020-05-11"
title = "Flood Fill"
slug = "may 11 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

An image is represented by a 2-D array of integers, each integer representing the pixel value of the image (from 0 to 65535).

Given a coordinate (sr, sc) representing the starting pixel (row and column) of the flood fill, and a pixel value newColor, "flood fill" the image.

To perform a "flood fill", consider the starting pixel, plus any pixels connected 4-directionally to the starting pixel of the same color as the starting pixel, plus any pixels connected 4-directionally to those pixels (also with the same color as the starting pixel), and so on. Replace the color of all of the aforementioned pixels with the newColor.

At the end, return the modified image.

Example 1:
Input:
image = [[1,1,1],[1,1,0],[1,0,1]]
sr = 1, sc = 1, newColor = 2
Output: [[2,2,2],[2,2,0],[2,0,1]]
Explanation:
From the center of the image (with position (sr, sc) = (1, 1)), all pixels connected
by a path of the same color as the starting pixel are colored with the new color.
Note the bottom corner is not colored 2, because it is not 4-directionally connected
to the starting pixel.

Note:
```
The length of image and image[0] will be in the range [1, 50].
The given starting pixel will satisfy 0 <= sr < image.length and 0 <= sc < image[0].length.
The value of each color in image[i][j] and newColor will be an integer in [0, 65535].
```

## Solution

Let's use DFS algorithm to traverse all neighbors and call coloring for them immediatelly.

``` go
func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    rows := len(image)
    if rows == 0 {
        return image
    }
    cols := len(image[0])
    oldColor := image[sr][sc]

    dfs(image, sr, sc, rows, cols, oldColor, -newColor)

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if image[r][c] < 0 {
                image[r][c] = -image[r][c]
            }
        }
    }

    return image
}

func dfs(image [][]int, r, c, rows, cols, oldColor, newColor int) {
    if r < 0 || r >= rows || c < 0 || c >= cols {
        return
    }
    if image[r][c] == newColor {
        return
    }
    if image[r][c] == oldColor {
        image[r][c] = newColor
        dfs(image, r-1, c, rows, cols, oldColor, newColor)
        dfs(image, r, c-1, rows, cols, oldColor, newColor)
        dfs(image, r+1, c, rows, cols, oldColor, newColor)
        dfs(image, r, c+1, rows, cols, oldColor, newColor)
    }
}
```

This is nice entry point algorithm that gives the following performance:\
```
Runtime: 8 ms
Memory Usage: 4.2 MB
```

Let's rewrite it a little bit:

``` go
func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    rows := len(image)
    if rows == 0 {
        return image
    }
    cols := len(image[0])
    oldColor := image[sr][sc]

    dfs(image, sr, sc, rows, cols, oldColor, -newColor)

    for r := 0; r < rows; r++ {
        for c := 0; c < cols; c++ {
            if image[r][c] < 0 {
                image[r][c] = -image[r][c]
            }
        }
    }

    return image
}

func dfs(image [][]int, r, c, rows, cols, oldColor, newColor int) {
    if r < 0 || r >= rows || c < 0 || c >= cols {
        return
    }
    if image[r][c] == newColor {
        return
    }
    if image[r][c] == oldColor {
        image[r][c] = newColor
        ids := []int {-1, 0, 0, -1, 1, 0, 0, 1}
        for i := 0; i < len(ids); i += 2 {
            dfs(image, r+ids[i], c+ids[i+1], rows, cols, oldColor, newColor)
        }
    }
}
```

In this case we are not calling the dfs method sequentually, but in loop, and it immediatelly gives improves in performance 2x

```
Runtime: 4 ms
Memory Usage: 4.2 MB
```

Let's reimplement this task in queue without recursion:

``` go
func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    rows := len(image)
    if rows == 0 {
        return image
    }
    cols := len(image[0])
    oldColor := image[sr][sc]
    if oldColor == newColor {
        return image
    }

    ids := []int {-1, 0, 0, -1, 1, 0, 0, 1}
    q := []int{sr, sc}

    for len(q) > 0 {

        r := q[len(q)-2]
        c := q[len(q)-1]
        q = q[:len(q)-2]

        image[r][c] = newColor
        for i := 0; i < len(ids); i += 2 {
            rr, cc := r+ids[i], c+ids[i+1]
            if rr >= 0 && rr < rows && cc >= 0 && cc < cols && image[rr][cc] == oldColor {
                q = append(q, r+ids[i], c+ids[i+1])
            }
        }

    }

    return image
}
```

Now, instead of using stack memory, we a using array `q`.

Performance that we have in heap DFS is
```
Runtime: 8 ms
Memory Usage: 4.2 MB
```

Let's change a little to get BFS

```
func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    rows := len(image)
    if rows == 0 {
        return image
    }
    cols := len(image[0])
    oldColor := image[sr][sc]
    if oldColor == newColor {
        return image
    }

    ids := []int {-1, 0, 0, -1, 1, 0, 0, 1}
    q := []int{sr, sc}

    for len(q) > 0 {

        r := q[0]
        c := q[1]
        q = q[2:]

        image[r][c] = newColor
        for i := 0; i < len(ids); i += 2 {
            rr, cc := r+ids[i], c+ids[i+1]
            if rr >= 0 && rr < rows && cc >= 0 && cc < cols && image[rr][cc] == oldColor {
                q = append(q, r+ids[i], c+ids[i+1])
            }
        }

    }

    return image
}
```

BFS performance is significantly better:

```
Runtime: 4 ms
Memory Usage: 4.2 MB
```

It happens like this, because the nature of always growing array in golang is memory friendly solution.
In BFS we always write in the tail and pool only head, so the array is growing organically forward.
For golang is usually means incrementing cap in array, that is GC friendly.


Let's try LinkedList for BFS queue:

``` go
type Entry struct {
    row  int
    col  int
    next *Entry
}

func floodFill(image [][]int, sr int, sc int, newColor int) [][]int {
    rows := len(image)
    if rows == 0 {
        return image
    }
    cols := len(image[0])
    oldColor := image[sr][sc]
    if oldColor == newColor {
        return image
    }

    ids := []int {-1, 0, 0, -1, 1, 0, 0, 1}
    q_head := &Entry{ sr, sc, nil }
    q_tail := q_head

    for q_head != nil {

        r, c := q_head.row, q_head.col

        image[r][c] = newColor
        for i := 0; i < len(ids); i += 2 {
            rr, cc := r+ids[i], c+ids[i+1]
            if rr >= 0 && rr < rows && cc >= 0 && cc < cols && image[rr][cc] == oldColor {
                q_tail.next = &Entry{ r+ids[i], c+ids[i+1], nil }
                q_tail = q_tail.next
            }
        }

        q_head = q_head.next
    }

    return image
}
```

Looks good, in fact performance is the same:
```
Runtime: 4 ms
Memory Usage: 4.2 MB
```

That's because arrays in golang already super-fast. But the latest solution is more universal and more "enterprise".
