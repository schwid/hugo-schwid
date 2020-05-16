+++
date = "2019-05-15"
title = "Revenue Milestones"
slug = "Revenue Milestones"
tags = []
categories = []
+++

## Introduction

We keep track of the revenue we makes every day, and we want to know on what days we hits certain revenue milestones. Given an array of the revenue on each day, and an array of milestones we wants to reach, return an array containing the days on which we reached every milestone.

Signature
```
int[] getMilestoneDays(int[] revenues, int[] milestones)
```

Input
```
revenues is a length-N array representing how much revenue we made on each day (from day 1 to day N). milestones is a length-K array of total revenue milestones.
```

Output
```
Return a length-K array where K_i is the day on which FB first had milestones[i] total revenue.
```

Example
```
revenues = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
milestones = [100, 200, 500]
output = [4, 6, 10]
```

Explanation
```
On days 4, 5, and 6, FB has total revenue of $100, $150, and $210 respectively. Day 6 is the first time that FB has >= $200 of total revenue.
```

## Solution

The catch in this task is that the milestone list could be unsorted.
Therefore, one of the possible solution (except the opbvious O(n^2)) would he to sort priority list of milestones and
Achieve O(n*log(n)) for sorting plus O(n).


``` go
package main

import "fmt"
import "sort"

type PrList []int

func (p PrList) Len() int           { return len(p) >> 1 }
func (p PrList) Less(i, j int) bool { return p[i << 1] < p[j << 1] }
func (p PrList) Swap(i, j int)      { p[i << 1], p[j << 1],  p[(i << 1)+1], p[(j << 1)+1]  = p[j << 1], p[i << 1], p[(j << 1)+1], p[(i << 1)+1] }

func getMilestoneDays(revenues []int, milestones []int) []int {

  n, k := len(revenues), len(milestones)
  out := make([]int, k)

  p := make([]int, k << 1)
  for i := 0; i < k; i++ {
    p[i << 1] = milestones[i]
    p[(i << 1) + 1] = i
  }

  sort.Sort(PrList(p))

  sum := 0
  for i, j := 0, 0; j < k; {
    if sum >= p[j << 1] {
      out[p[(j << 1)+1]] = i
      j++
    } else if i < n {
      sum += revenues[i]
      i++
    } else {
      break
    }
  }
	return out;
}

func main() {

  revenues := []int {10, 20, 30, 40, 50, 60, 70, 80, 90, 100}
  milestones := []int {100, 200, 500}
  expected := []int {4, 6, 10}
  output := getMilestoneDays(revenues, milestones)
  fmt.Printf("Test#1 expected=%v, actual=%v\n", expected, output)

  revenues = []int {700, 800, 600, 400, 600, 700}
  milestones = []int {3100, 2200, 800, 2100, 1000}
  expected = []int {5, 4, 2, 3, 2}
  output = getMilestoneDays(revenues, milestones)

  fmt.Printf("Test#2 expected=%v, actual=%v\n", expected, output)

}
```
