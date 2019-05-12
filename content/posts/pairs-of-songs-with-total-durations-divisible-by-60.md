+++
date = "2019-05-11"
title = "Pairs of Songs With Total Durations Divisible by 60"
slug = "Pairs of Songs With Total Durations Divisible by 60"
tags = []
categories = []
+++

## Introduction

In a list of songs, the i-th song has a duration of time[i] seconds.

Return the number of pairs of songs for which their total duration in seconds is divisible by 60.  Formally, we want the number of indices i < j with (time[i] + time[j]) % 60 == 0.



Example 1:
```
Input: [30,20,150,100,40]
Output: 3
Explanation: Three pairs have a total duration divisible by 60:
(time[0] = 30, time[2] = 150): total duration 180
(time[1] = 20, time[3] = 100): total duration 120
(time[1] = 20, time[4] = 40): total duration 60
```

Example 2:
```
Input: [60,60,60]
Output: 3
Explanation: All three pairs have a total duration of 120, which is divisible by 60.
```

Note:
```
1 <= time.length <= 60000
1 <= time[i] <= 500
```

### Solution

Cache approach:
``` go
func numPairsDivisibleBy60(time []int) int {
    cache := make(map[int]int)
    cnt := 0
    for _, t := range time {
        reminder := t % 60
        other := (60 - reminder) % 60
        cnt += cache[other]
        cache[reminder]++
    }
    return cnt
}
```

### Explanation

Lets cache all reminders and their occurrences in Hash Map.
That will give us O(n) solution.
