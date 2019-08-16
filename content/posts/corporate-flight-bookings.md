+++
date = "2019-08-16"
title = "Corporate Flight Bookings"
slug = "Corporate Flight Bookings"
tags = []
categories = []
+++

## Introduction

There are n flights, and they are labeled from 1 to n.

We have a list of flight bookings.  The i-th booking bookings[i] = [i, j, k] means that we booked k seats from flights labeled i to j inclusive.

Return an array answer of length n, representing the number of seats booked on each flight in order of their label.

 

Example 1:
```
Input: bookings = [[1,2,10],[2,3,20],[2,5,25]], n = 5
Output: [10,55,45,25,25]
```

Constraints:
```
1 <= bookings.length <= 20000
1 <= bookings[i][0] <= bookings[i][1] <= n <= 20000
1 <= bookings[i][2] <= 10000
```

### Solution

Simple strait-forward solution would be a bruteforce one. Let's implement it first.

``` go
func corpFlightBookings(bookings [][]int, n int) []int {
    
    out := make([]int, n)
    
    for _, b := range bookings {
        x, y, k := b[0], b[1], b[2]
        for i := x; i <= y; i++ {
            out[i-1] += k
        }
    }
    
    return out
    
}
```


