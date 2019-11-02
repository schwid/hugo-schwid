+++
date = "2019-11-01"
title = "Next Greater Element I"
slug = "Next Greater Element I"
tags = []
categories = []
+++

## Introduction

You are given two arrays (without duplicates) nums1 and nums2 where nums1’s elements are subset of nums2. Find all the next greater numbers for nums1's elements in the corresponding places of nums2.

The Next Greater Number of a number x in nums1 is the first greater number to its right in nums2. If it does not exist, output -1 for this number.

Example 1:
```
Input: nums1 = [4,1,2], nums2 = [1,3,4,2].
Output: [-1,3,-1]
```
Explanation:
* For number 4 in the first array, you cannot find the next greater number for it in the second array, so output -1.
* For number 1 in the first array, the next greater number for it in the second array is 3.
* For number 2 in the first array, there is no next greater number for it in the second array, so output -1.

Example 2:
```
Input: nums1 = [2,4], nums2 = [1,2,3,4].
Output: [3,-1]
```
Explanation:
* For number 2 in the first array, the next greater number for it in the second array is 3.
* For number 4 in the first array, there is no next greater number for it in the second array, so output -1.

Note:
* All elements in nums1 and nums2 are unique.
* The length of both nums1 and nums2 would not exceed 1000.

### Solution

We have unique numbers, that is great, because we can use this fact as a key in the map.
So, we have some map, let's name it `cache` where the key is the number.

If key is the number, logically that value should be `next greater element`.

Let's fill this map by values through going forward by `nums2` array, therefore we can see what are the next elements we have.

By going forward we have two cases:
* current value is greater than previous value (or decrementing values)
* current value is equal or less than previous value

We definitly need to store somehow information about visited decrementing values and keep it in structure similar to stack.

On each iteration we need to go through decrementing stack until we extract all smaller values than current, because for them we know who is 
their next greater element (that is current). 
After that we need to add current value to stack in order to find in future iterations next greater value for it.

After filling `cache`, we need to go through `nums1` array and lookup for each element it's next greater element from `cache`.
For elements that are not found, we have a exception case - maximum value in array and need to setup -1.

Here is the code:
``` go
func nextGreaterElement(nums1 []int, nums2 []int) []int {
    
    // key is a number, value the next great number
    cache := make(map[int]int)

    if len(nums2) > 0 {
    
        // decreasing elements
        stack := []int { nums2[0] }

        for _, curr := range nums2[1:] {

            for len(stack) > 0 {
                top := stack[len(stack)-1]
                if top < curr {
                    cache[top] = curr
                    stack = stack[:len(stack)-1]
                } else {
                    break
                }
            }

            stack = append(stack, curr)        
        }

    }
    
    out := make([]int, len(nums1))
    
    for i, el := range nums1 {
        
        if v, ok := cache[el]; ok {
            out[i] = v
        } else {
            out[i] = -1
        }
        
    }
    
    return out
    
}
```

Golang code works 4 milliseconds and Among the Best solutions.

Here is the code in python:
``` python
class Solution(object):
    def nextGreaterElement(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        # key is a number, value the next great number
        cache = {}

        if len(nums2) > 0:
            # decreasing elements
            stack = [ nums2[0] ]
            
            for curr in nums2[1:]:
                while len(stack) > 0:
                    top = stack[-1]
                    if top < curr:
                        cache[top] = curr
                        stack = stack[:-1]
                    else:
                        break
                stack.append(curr)        
            
        out = []
        for el in nums1:
            out.append(cache.get(el, -1))
        return out        
        
```

Python code works 44 milliseconds, and it is getting results.

In this example we see that one thread performance of golang is 10x of python performance.







