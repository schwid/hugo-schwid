+++
date = "2019-05-15"
title = "Minimum Cost For Tickets"
slug = "Minimum Cost For Tickets"
tags = []
categories = []
+++

## Introduction

In a country popular for train travel, you have planned some train travelling one year in advance.  The days of the year that you will travel is given as an array days.  Each day is an integer from 1 to 365.

Train tickets are sold in 3 different ways:

a 1-day pass is sold for costs[0] dollars;
a 7-day pass is sold for costs[1] dollars;
a 30-day pass is sold for costs[2] dollars.
The passes allow that many days of consecutive travel.  For example, if we get a 7-day pass on day 2, then we can travel for 7 days: day 2, 3, 4, 5, 6, 7, and 8.

Return the minimum number of dollars you need to travel every day in the given list of days.

 

Example 1:
```
Input: days = [1,4,6,7,8,20], costs = [2,7,15]
Output: 11
Explanation: 
For example, here is one way to buy passes that lets you travel your travel plan:
On day 1, you bought a 1-day pass for costs[0] = $2, which covered day 1.
On day 3, you bought a 7-day pass for costs[1] = $7, which covered days 3, 4, ..., 9.
On day 20, you bought a 1-day pass for costs[0] = $2, which covered day 20.
In total you spent $11 and covered all the days of your travel.
```

Example 2:
```
Input: days = [1,2,3,4,5,6,7,8,9,10,30,31], costs = [2,7,15]
Output: 17
Explanation: 
For example, here is one way to buy passes that lets you travel your travel plan:
On day 1, you bought a 30-day pass for costs[2] = $15 which covered days 1, 2, ..., 30.
On day 31, you bought a 1-day pass for costs[0] = $2 which covered day 31.
In total you spent $17 and covered all the days of your travel.
```

Note:
```
1 <= days.length <= 365
1 <= days[i] <= 365
days is in strictly increasing order.
costs.length == 3
1 <= costs[i] <= 1000
```

### Solution

Dynamic Programming Solution:
``` go
func mincostTickets(days []int, costs []int) int {
    n := len(days)
    dp := make([]int, n+1)
    i7 := 1
    i30 := 1
    for i := 1; i <= n; i++ {
        for ;i > i7 && days[i-1] - days[i7-1] + 1 > 7; i7++ {
        }
        for ;i > i30 && days[i-1] - days[i30-1] + 1 > 30; i30++ {
        }
        dp[i] = dp[i-1] + costs[0]
        dp[i] = min(dp[i], dp[i7-1] + costs[1])
        dp[i] = min(dp[i], dp[i30-1] + costs[2])
        
    }
    return dp[n]
}

func min(a, b int) int {
    if a < b {
        return a
    } else {
        return b
    }
}
```

### Explanation

Lets solve this problem by using dynamic programming approach. We have 3 intervals: 1 day, 7 days and 30 days, therefore we need to track 3 pointers `i-1, i7, i30`.
Inverval could be just a single element or more elements that we can replace by better cost. Therefore on each step we need to compare between 3 options:
* i-th day does to 1-day pass
* i-th day does to 7-day pass and some previous days if has
* i-th day does to 30-day pass and some previous days if has


