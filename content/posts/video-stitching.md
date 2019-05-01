+++
date = "2019-04-30"
title = "Video Stitching"
slug = "Video Stitching"
tags = []
categories = []
+++

## Introduction

You are given a series of video clips from a sporting event that lasted T seconds.  These video clips can be overlapping with each other and have varied lengths.

Each video clip clips[i] is an interval: it starts at time clips[i][0] and ends at time clips[i][1].  We can cut these clips into segments freely: for example, a clip [0, 7] can be cut into segments [0, 1] + [1, 3] + [3, 7].

Return the minimum number of clips needed so that we can cut the clips into segments that cover the entire sporting event ([0, T]).  If the task is impossible, return -1.


Example 1:
```
Input: clips = [[0,2],[4,6],[8,10],[1,9],[1,5],[5,9]], T = 10
Output: 3
Explanation: 
We take the clips [0,2], [8,10], [1,9]; a total of 3 clips.
Then, we can reconstruct the sporting event as follows:
We cut [1,9] into segments [1,2] + [2,8] + [8,9].
Now we have segments [0,2] + [2,8] + [8,10] which cover the sporting event [0, 10].
```

Example 2:
```
Input: clips = [[0,1],[1,2]], T = 5
Output: -1
Explanation: 
We can't cover [0,5] with only [0,1] and [0,2].
```

Example 3:
```
Input: clips = [[0,1],[6,8],[0,2],[5,6],[0,4],[0,3],[6,7],[1,3],[4,7],[1,4],[2,5],[2,6],[3,4],[4,5],[5,7],[6,9]], T = 9
Output: 3
Explanation: 
We can take clips [0,4], [4,7], and [6,9].
```

Example 4:
```
Input: clips = [[0,4],[2,8]], T = 5
Output: 2
Explanation: 
Notice you can have extra video after the event ends.
```

Note:
```
1 <= clips.length <= 100
0 <= clips[i][0], clips[i][1] <= 100
0 <= T <= 100
```


### Solution

Recursive solution with caching:
``` go
func use(clips [][]int, skipClip, useTime int) [][]int {
    ret := [][]int{}
    
    for i, clip := range clips {
        
        if i == skipClip {
            continue
        }
        
        start := max(0, clip[0] - useTime)
        end := max(0, clip[1] - useTime)
        
        if start != end {
            ret = append(ret, []int{start, end})
        }
        
    }
    
    return ret
    
}

var m map[string]int

func videoStitching(clips [][]int, T int) int {
    
    if m == nil {
        m = make(map[string]int)
    }
    
    key := fmt.Sprintf("%v,%v", clips, T)
    
    if v, ok := m[key]; ok {
        return v
    }
    
    minSoFar := -1
    
    for i, clip := range clips {
        
        if clip[0] == 0 {
            if clip[1] >= T {
                return 1
            }
             
            cnt := videoStitching(use(clips, i, clip[1]), T-clip[1])
            if cnt != -1 {
                if minSoFar == -1 || minSoFar > cnt + 1 {
                    minSoFar = cnt + 1
                }
            }
            
        }
        
    }
    
    m[key] = minSoFar
    return minSoFar
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

### Explanation

This is a good example of recursive solution with caching.

### Solutions

Another way to solve this problem is to use Dynamic Programming to transform it to the "Jump Game II".

``` go

func videoStitching(clips [][]int, T int) int {
    
    dp := make([]int, T+1)
    
    for _, clip := range clips {
        j := clip[0]
        if j < T {
            dp[j] = max(dp[j], clip[1])
        }
    }
 
    // make relative numbers
    for i := 0; i < T; i++ {
        dp[i] = max(0, dp[i] - i)
    }
    
    // now this is a jump game
    return jump(dp)
}

// this solution is from Jump Game II
func jump(nums []int) int {
    
    n := len(nums)
    if n <= 1 {
        return 0
    }

    steps := 1
    i, m := 0, nums[0]
    for m > 0 {
        if m >= n-1 {
            return steps
        }
        steps++
        maxSoFar := 0
        for ;i <= m; i++ {
            maxSoFar = max(maxSoFar, i + nums[i])
            if maxSoFar >= n-1 {
                return steps
            }
        }
        m = maxSoFar
    }
    return -1
}

func max(a, b int) int {
    if a > b {
        return a
    } else {
        return b
    }
}
```

### Explanation

This is the best performance solution with O(n) complexity. The part of the code took from "Jump Game II" post.

