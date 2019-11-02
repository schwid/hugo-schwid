+++
date = "2019-11-01"
title = "Next Greater Element II"
slug = "Next Greater Element II"
tags = []
categories = []
+++

## Introduction

 Given a circular array (the next element of the last element is the first element of the array), print the Next Greater Number for every element. The Next Greater Number of a number x is the first greater number to its traversing-order next in the array, which means you could search circularly to find its next greater number. If it doesn't exist, output -1 for this number.

Example 1:
```
Input: [1,2,1]
Output: [2,-1,2]
```
Explanation: 
```
The first 1's next greater number is 2; 
The number 2 can't find next greater number; 
The second 1's next greater number needs to search circularly, which is also 2.
```

Note: The length of given array won't exceed 10000. 

### Solution

The simplest possible solution would be O(n*n) that will go through all elements and search next greater element in sub-loop.

Here is the golang implementation:

``` go
func nextGreaterElements(nums []int) []int {
    n := len(nums)
    out := make([]int, n)
    for i, num := range nums {
        out[i] = -1
        for j := i+1; j <= i+n; j++ {
            jj := j % n
            if nums[jj] > num {
                out[i] = nums[jj]
                break
            }
        }
    }
    return out
}
```

As we see in this simple solution, we have redundant traversal of elements in inner loops. 
That brings the idea to tune solution to more efficient way and close to O(n).

Let's think about one loop solution for this task. The biggest challenge that we have is requirement to remember previous less values,
so we need data structure for this. We need to know things like index and value, so let's place them in flat array, because they both are `int` types.

On each step we need to check current value with decrementing stack values and update their next grater element foundings and add to stack current value with index.

I found that it works well, but not enought.
We also have requirement in the task that incoming array is cyclic. 
Therefore, we need to go again through the main loop, but with slightly different conditions.

First of all, we do not need to add element in to stack and setup not found '-1' element in out array.
Second thing, we do not need to visit last element in second traversal.

Here is the solution that works fine:
``` go
func nextGreaterElements(nums []int) []int {
    
    n := len(nums)
    if n == 0 {
        return nums
    }
    
    out := make([]int, n)
    out[0] = -1
    
    stack := []int { 0, nums[0] }
    m := len(stack)
    
    for i := 1; i < n; i++ {
        
        curr := nums[i]
        out[i] = -1
        
        for m > 0 {
            
            j, el := stack[m-2], stack[m-1]
            
            if curr > el {
                out[j] = curr
                stack = stack[:m-2]
                m -= 2
            } else {
                break
            }
            
        }
        
        stack = append(stack, i, curr)
        m += 2
        
    }
    
    for i := 0; i < n-1; i++ {
        
        curr := nums[i]
        
        for m > 0 {
            
            j, el := stack[m-2], stack[m-1]
            
            if curr > el {
                out[j] = curr
                stack = stack[:m-2]
                m -= 2
            } else {
                break
            }
            
        }
        
        if m == 0 {
            break
        }
        
    }
    
    return out
    
}
```

I spent some time on debuging, because I copy-pasted second loop. 
Yes, guys, be careful, copy-past is the most buggy technic in the world.









