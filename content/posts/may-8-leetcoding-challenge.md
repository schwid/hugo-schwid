+++
date = "2020-05-08"
title = "Check If It Is a Straight Line"
slug = "may 8 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You are given an array coordinates, coordinates[i] = [x, y], where [x, y] represents the coordinate of a point. Check if these points make a straight line in the XY plane.


Example 1:

Input: coordinates = [[1,2],[2,3],[3,4],[4,5],[5,6],[6,7]]
Output: true
Example 2:

Input: coordinates = [[1,1],[2,2],[3,4],[4,5],[5,6],[7,7]]
Output: false


Constraints:
```
2 <= coordinates.length <= 1000
coordinates[i].length == 2
-10^4 <= coordinates[i][0], coordinates[i][1] <= 10^4
coordinates contains no duplicate point.
```

## Solution

As we know from the base course of geometry, we can center our coordinates to any point.
Let's select the first point to be the center.
The second point will be our angle point to calculate the slope.
Finally we can test all points without float numbers that all have the same slope.

``` go
func checkStraightLine(coordinates [][]int) bool {
    n := len(coordinates)
    if n < 2 {
        return false
    } else if n == 2 {
        return true
    }
    center := coordinates[0]
    base := move(center, coordinates[1])
    for _, point := range coordinates[2:] {
        test := move(center, point)
        if base[1] *  test[0] != test[1] * base[0] {
            return false
        }
    }
    return true
}

func move(center, point []int) []int {
    return []int {  point[0] - center[0], point[1] - center[1] }
}
```
