+++
date = "2019-08-12"
title = "Longest Well-Performing Interval"
slug = "Longest Well-Performing Interval"
tags = []
categories = []
+++

## Introduction

We are given hours, a list of the number of hours worked per day for a given employee.

A day is considered to be a tiring day if and only if the number of hours worked is (strictly) greater than 8.

A well-performing interval is an interval of days for which the number of tiring days is strictly larger than the number of non-tiring days.

Return the length of the longest well-performing interval.

 

Example 1:
```
Input: hours = [9,9,6,0,6,6,9]
Output: 3
Explanation: The longest well-performing interval is [9,9,6].
```

Constraints:
```
1 <= hours.length <= 10000
0 <= hours[i] <= 16
```

### Solution

Let's solve this problem by simple straitforward way. Assume that in array we potencially can have a sub-array hours[i:j] in 
wich the number of tiring days strictly greater than non tiring days, all my weeks are like this :) 

So, therefore, let's go through all combinations O(n**2) to find the max interval:

``` go
func longestWPI(hours []int) int {
    
    n := len(hours)
    max := 0
    
    for i := 0; i < n; i++ {
        
        tiringDays := 0
        
        for j := i; j < n; j++ {
            
            if hours[j] > 8 {
                tiringDays++
            }
            
            cnt := j - i + 1
            
            if tiringDays > cnt - tiringDays {
                if max < cnt {
                    max = cnt
                }
            }
            
        }
        
    }
    
    return max 
}
```

Another way to solve this problem is to track the last seen max index in map and use it for improving maxSoFar.
All we are looking for is the sum > 0 of the elements 1 (tiring day) and -1 (non tiring day). The goal is to find the max length interval with that condition.

``` go
func longestWPI(hours []int) int {

	n := len(hours)
	if n == 0 {
		return 0
	}

	maxSoFar := 0
	seen := make(map[int]int)
	score := 0
    
	for i := 0; i < n; i++ {
		if hours[i] > 8 {
			score += 1
		} else {
			score += -1
		}
		if score > 0 {
			maxSoFar = max(maxSoFar, i+1)
		} else {
			if _, ok := seen[score]; !ok {
				seen[score] = i
			}
			if v, ok := seen[score-1]; ok {
				maxSoFar = max(maxSoFar, i - v)
			}
		}
	}

	return maxSoFar
}

func max(a, b int) int {
	if a > b {
		return a
	} else {
		return b
	}
}
```

As we see here, for score>0, we always have interval that starts from 0, therefore `max(maxSoFar, i+1)`.

