+++
date = "2019-05-11"
title = "Robot Bounded In Circle"
slug = "Robot Bounded In Circle"
tags = []
categories = []
+++

## Introduction

On an infinite plane, a robot initially stands at (0, 0) and faces north.  The robot can receive one of three instructions:

```
"G": go straight 1 unit;
"L": turn 90 degrees to the left;
"R": turn 90 degress to the right.
```

The robot performs the instructions given in order, and repeats them forever.

Return true if and only if there exists a circle in the plane such that the robot never leaves the circle.



Example 1:
```
Input: "GGLLGG"
Output: true
Explanation:
The robot moves from (0,0) to (0,2), turns 180 degrees, and then returns to (0,0).
When repeating these instructions, the robot remains in the circle of radius 2 centered at the origin.
```

Example 2:
```
Input: "GG"
Output: false
Explanation:
The robot moves north indefinetely.
```

Example 3:
```
Input: "GL"
Output: true
Explanation:
The robot moves from (0, 0) -> (0, 1) -> (-1, 1) -> (-1, 0) -> (0, 0) -> ...
```

Note:
```
1 <= instructions.length <= 100
instructions[i] is in {'G', 'L', 'R'}
```


### Solution

Simple emulator solution:
``` go
func isRobotBounded(instructions string) bool {

    x, y := 0, 0
    d := 0
    for i := 0; i < 1000; i++ {

        for _, ins := range instructions {

            if ins == 'G' {

                switch d {
                    case 0:
                        x++
                    case 1:
                        y--
                    case 2:
                        x--
                    case 3:
                        y++
                }

            } else if ins == 'L' {
                if d == 3 {
                    d = 0
                } else {
                    d++
                }                
            } else if ins == 'R' {
                if d == 0 {
                    d = 3
                } else {
                    d--
                }
            }

        }

         if x == 0 && y == 0 {
            return true
        }        

    }

    return false
}
```

### Explanation

This problem is good example how to build emulator solutions.
I selected `1000` at a big number to detect loops, it could be other way to do this (to check how far became points from time to time).
