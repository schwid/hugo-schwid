+++
date = "2019-05-17"
title = "Magical Candy Bags"
slug = "Magical Candy Bags"
tags = []
categories = []
+++

## Introduction

You have N bags of candy. The ith bag contains arr[i] pieces of candy, and each of the bags is magical!
It takes you 1 minute to eat all of the pieces of candy in a bag (irrespective of how many pieces of candy are inside), and as soon as you finish, the bag mysteriously refills. If there were x pieces of candy in the bag at the beginning of the minute, then after you've finished you'll find that floor(x/2) pieces are now inside.
You have K minutes to eat as much candy as possible. How many pieces of candy can you eat?
Signature
int maxCandies(int[] arr, int K)

Input
```
1 ≤ N ≤ 10,000
1 ≤ arr[i] ≤ 1,000,000,000
```

Output
A single integer, the maximum number of candies you can eat in K minutes.

Example 1
```
N = 5
K = 3
arr = [2, 1, 7, 4, 2]
output = 14
```

```
In the first minute you can eat 7 pieces of candy. That bag will refill with floor(7/2) = 3 pieces.
In the second minute you can eat 4 pieces of candy from another bag. That bag will refill with floor(4/2) = 2 pieces.
In the third minute you can eat the 3 pieces of candy that have appeared in the first bag that you ate.
In total you can eat 7 + 4 + 3 = 14 pieces of candy.
```

### Solution

Simple greedy algorithm is good for this task.
We need to select max candy jar on every minute.

One way to implement this is to use sorting.
We also need filter for zero elements.

``` go
func maxCandies(arr []int, k int) int {
  total := 0
  for j := 0; j < k; j++ {
    sort.Ints(arr)
    skip := 0
    for ; arr[skip] == 0; skip++ {}
    arr = arr[skip:]
    n := len(arr)
    if n == 0 {
      return total
    }
    last := arr[n-1]
    total += last
    arr[n-1] = last / 2
  }
	return total
}
```

### Tests

``` go
func main() {
  arr := []int {2, 1, 7, 4, 2}
  out := maxCandies(arr, 3)
  println(out)
  arr = []int{19, 78, 76, 72, 48, 8, 24, 74, 29}
  out = maxCandies(arr, 3)
  println(out)
}
```

Expected
```
14
228
```


### Another solution

This is inefficient sort inside the loop in the first solution.
In fact, it would be totally enough to have just a first sort `O(n*log(n))` and then manipulation with merge of sorted arrays.

We know that jars are sorted and after eating candies that fill only on half. That is also sorted array but in reverse.
Therefore, we can continue eat jars until we need to merge array with halfs when last element of array became greater than first element of halfs.

Here is the solution:
``` go
func maxCandies(arr []int, k int) int {
  total := 0
  sort.Ints(arr)
  skip := 0
  for ; arr[skip] == 0; skip++ {}
  arr = arr[skip:]
  var half []int
  for len(arr) > 0 && k > 0 {
    lastIdx := len(arr)-1
    last := arr[lastIdx]
    if half != nil && last < half[0] {
      arr = mergeWithReversed(arr, half)
      half = nil
    } else {
      total += last
      k--
      last >>= 1
      if last > 0 {
        half = append(half, last)
      }
      arr = arr[:lastIdx]
      if lastIdx == 0 && half != nil {
        arr = reverse(half)
        half = nil
      }
    }
  }
  return total
}

func mergeWithReversed(a, rb []int) []int {
  n, m := len(a), len(rb)
  var out []int
  for i, j := 0, m-1; i < n || j >= 0; {
    if i < n {
      if j >= 0 {
        if a[i] <= rb[j] {
          out = append(out, a[i])
          i++
        } else {
          out = append(out, rb[j])
          j--
        }
      } else {
        out = append(out, a[i])
        i++
      }
    } else {
      out = append(out, rb[j])
      j--
    }
  }
  return out
}

func reverse(arr []int) []int {
  for i, j := 0, len(arr); i < j; i, j = i+1, j-1 {
    arr[i], arr[j] = arr[j], arr[i]
  }
  return arr
}
```

Complexity of this soluition would be `O(n*log(n)*2)
