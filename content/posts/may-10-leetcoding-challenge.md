+++
date = "2020-05-10"
title = "Find the Town Judge"
slug = "may 10 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

In a town, there are N people labelled from 1 to N.  There is a rumor that one of these people is secretly the town judge.

If the town judge exists, then:

The town judge trusts nobody.
Everybody (except for the town judge) trusts the town judge.
There is exactly one person that satisfies properties 1 and 2.
You are given trust, an array of pairs trust[i] = [a, b] representing that the person labelled a trusts the person labelled b.

If the town judge exists and can be identified, return the label of the town judge.  Otherwise, return -1.



Example 1:
```
Input: N = 2, trust = [[1,2]]
Output: 2
```

Example 2:
```
Input: N = 3, trust = [[1,3],[2,3]]
Output: 3
```

Example 3:
```
Input: N = 3, trust = [[1,3],[2,3],[3,1]]
Output: -1
```

Example 4:
```
Input: N = 3, trust = [[1,2],[2,3]]
Output: -1
```

Example 5:
```
Input: N = 4, trust = [[1,3],[1,4],[2,3],[2,4],[4,3]]
Output: 3
```

Note:
```
1 <= N <= 1000
trust.length <= 10000
trust[i] are all different
trust[i][0] != trust[i][1]
1 <= trust[i][0], trust[i][1] <= N
```

## Solution

Every time when we see trust struct, we know that first `a` person definitly can not be a judge.
So we need to add him to memory structure to remember about this fact `non_judge[t[0]] = true`.
In contrary, second person in trust object `b` potencially could be a judge, therefore we need to add
him to the memory structure `possible_judge` and record the count when someone trust to him.
But before adding him, we need to make sure that he is not in list of `non_judge`.

``` go
if !non_judge[t[1]] {
  possible_judge[t[1]]++
}
```

Additionally, if we see that person `a` is not judge, then we need to delete him from potencial judge structure if
we added him before:

``` go
if _, ok := possible_judge[t[0]]; ok {
   delete(possible_judge, t[0])
}
```

The full code is here:

``` go
func findJudge(N int, trust [][]int) int {

	non_judge := make(map[int]bool)
	possible_judge := make(map[int]int)
  possible_judge[1] = 0

	for _, t := range trust {

    if _, ok := possible_judge[t[0]]; ok {
			 delete(possible_judge, t[0])
		}

    non_judge[t[0]] = true

		if !non_judge[t[1]] {
			possible_judge[t[1]]++
		}

	}

	for judge, cnt := range possible_judge {
		if cnt == N-1 {
			return judge
		}
	}

	return -1
}
```

### Peformance

```
Runtime: 116 ms
Memory Usage: 7.2 MB
```

It could be better, let's join the existing structires for non_judge and potencial_judge and add a corner case if town has only one citizen and he is a judge.

``` go
func findJudge(N int, trust [][]int) int {
    if N == 1 && len(trust) == 0 {
        return 1
    }
    judge := -1
    dp := make([]int, N+1, N+1)
    for _, t := range trust {
        dp[t[0]] = -1
        if t[0] == judge {
            judge = -1
        }
        if dp[t[1]] != -1 {
            dp[t[1]]++
            if dp[t[1]] == N-1 {
                judge = t[1]
            } else if t[1] == judge {
                judge = -1
            }
        }
    }
    return judge
}
```


Let's simplify this code:

``` go
func findJudge(N int, trust [][]int) int {
    if len(trust) < N-1 {
      return -1
    }
    dp := make([]int, N+1, N+1)
    for _, t := range trust {
        dp[t[0]]--
        dp[t[1]]++
    }
    for i := 1; i <= N; i++ {
        if dp[i] == N-1 {
            return i
        }
    }
    return -1
}
```
