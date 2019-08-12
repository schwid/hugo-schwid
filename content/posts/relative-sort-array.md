+++
date = "2019-08-12"
title = "Relative Sort Array"
slug = "Relative Sort Array"
tags = []
categories = []
+++

## Introduction

Given two arrays `arr1` and `arr2`, the elements of `arr2` are distinct, and all elements in `arr2` are also in `arr1`.

Sort the elements of `arr1` such that the relative ordering of items in `arr1` are the same as in `arr2`.  Elements that don't appear in `arr2` should be placed at the end of `arr1` in ascending order.


Example 1:

```
Input: arr1 = [2,3,1,3,2,4,6,7,9,2,19], arr2 = [2,1,4,3,9,6]
Output: [2,2,2,1,4,3,3,9,6,7,19]
```

Constraints:
```
arr1.length, arr2.length <= 1000
0 <= arr1[i], arr2[i] <= 1000
Each arr2[i] is distinct.
Each arr2[i] is in arr1.
```

### Solution

``` go
func relativeSortArray(arr1 []int, arr2 []int) []int {
    
    m := make(map[int]int)
    for _, v := range arr1 {
        m[v]++
    }
    
    var out []int
    for _, v := range arr2 {
        
        cnt := m[v]
        for j := 0; j < cnt; j++ {
            out = append(out, v)
        }
        
        delete(m, v)
        
    }
    
    var keys []int
    for k := range m {
        keys = append(keys, k)
    }
    sort.Ints(keys)

    for _, v := range keys {
        
       cnt := m[v]
       for j := 0; j < cnt; j++ {
            out = append(out, v)
       }
        
    }
    
    return out
}
```

### Explanation

The simple solution would be to use maps. 

Let's try to use the fact, that values in arrays are in range [0, 1000], therefore, instead of slow hash maps we can end up with arrays, by decreasing complexity of the task to O(n+m+log(n-m))


### Solution with arrays

``` go
func relativeSortArray(arr1 []int, arr2 []int) []int {
    
    dist := make([]int, 1001)
    for i, v := range arr2 {
        dist[v] = i + 1
    }
    
    cnt := make([]int, len(arr2))
    var tail []int
    
    for _, v := range arr1 {
        i := dist[v] - 1
        if i >= 0 {
            cnt[i]++
        } else {
            tail = append(tail, v)
        }
    }
    
    sort.Ints(tail)
    
    var out []int
    for i, c := range cnt {
        for j := 0; j < c; j++ {
            out = append(out, arr2[i])
        }
    }
    
    return append(out, tail...)
}
```

### Next step

Let's remove sorting by integers on tail and combine counter in one array.
Here it is the best  solution:

``` go
func relativeSortArray(arr1 []int, arr2 []int) []int {
    
    cache := make([]int, 1001)
    
    for _, n := range arr1 {
        cache[n]++ 
    }
    
    var out []int
    
    for _, n := range arr2 {
        cnt := cache[n]
        for i := 0; i < cnt; i++ {
            out = append(out, n)
        }  
        cache[n] = 0
    }
    
    for n, cnt := range cache {
        for i := 0; i < cnt; i++ {
            out = append(out, n)
        }
    }    

    return out
}
```



