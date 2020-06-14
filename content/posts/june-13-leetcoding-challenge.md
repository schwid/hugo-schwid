+++
date = "2020-06-13"
title = "Largest Divisible Subset"
slug = "june 13 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Given a set of distinct positive integers, find the largest subset such that every pair (Si, Sj) of elements in this subset satisfies:

Si % Sj = 0 or Sj % Si = 0.

If there are multiple solutions, return any subset is fine.

Example 1:
```
Input: [1,2,3]
Output: [1,2] (of course, [1,3] will also be ok)
```

Example 2:
```
Input: [1,2,4,8]
Output: [1,2,4,8]
```

## Solution

Let's sort integers and build sequences in the map. Keep track on largest sequence.

``` go
func largestDivisibleSubset(nums []int) []int {
    if len(nums) == 0 {
        return nums
    }
    sort.Ints(nums)

    cache := make(map[int][]int)

    maxKey := -1
    maxCnt := -1

    for _, val := range nums {
        seqKey, seqCnt := findMax(cache, val)
        if seqCnt > 0 {
            cnt := seqCnt + 1
            cache[val] = []int { seqKey, cnt }
            if maxCnt < cnt {
                maxKey = val
                maxCnt = cnt
            }
        } else {
            cache[val] = []int { -1,  1 }
            if maxCnt < 1 {
                maxCnt = 1
                maxKey = val
            }            
        }
    }

    var out []int
    out = append(out, maxKey)
    for p := cache[maxKey]; p[0] != -1; p = cache[p[0]] {
        out = append(out, p[0])
    }

    return out
}

func findMax(cache map[int][]int, val int) (int, int) {
    maxKey := -1
    maxCnt := -1
    for k, pair := range cache {
        if val % k == 0 {
            cnt := pair[1]
            if cnt > maxCnt {
                maxKey = k
                maxCnt = cnt
            }
        }
    }
    return maxKey, maxCnt
}
```

Performance of this solution is:
```
Runtime: 164 ms
Memory Usage: 4.9 MB
```

Let's solve this problem by using dynamic programming


``` go

func largestDivisibleSubset(nums []int) []int {

    n := len(nums)
    sort.Ints(nums)

    dp := make([]int, n)
    cnt := make([]int, n)

    maxSoFar := -1
    maxIndex := -1

    for i := 0; i < n; i++ {

        dp[i] = -1
        cnt[i] = 1

        for j := i-1; j >= 0; j-- {

            if nums[i] % nums[j] == 0 && cnt[j] >= cnt[i] {
                cnt[i] = cnt[j] + 1
                dp[i] = j
            }

        }

        if cnt[i] > maxSoFar {
            maxSoFar = cnt[i]
            maxIndex = i
        }

    }

    var out []int
    for i := maxIndex; i != -1; i = dp[i] {
		   out = append(out, nums[i])
	  }    

    return out
}
```

Performance is better:
```
Runtime: 56 ms
Memory Usage: 2.9 MB
```
