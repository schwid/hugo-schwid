+++
date = "2020-02-15"
title = "Wiggle Sort II"
slug = "Wiggle Sort II"
tags = []
categories = []
+++

## Introduction

Given an unsorted array nums, reorder it such that nums[0] < nums[1] > nums[2] < nums[3]....

Example 1:
```
Input: nums = [1, 5, 1, 1, 6, 4]
Output: One possible answer is [1, 4, 1, 5, 1, 6].
```

Example 2:
```
Input: nums = [1, 3, 2, 2, 3, 1]
Output: One possible answer is [2, 3, 1, 3, 1, 2].
Note:
You may assume all input has valid answer.
```

Follow Up:
Can you do it in O(n) time and/or in-place with O(1) extra space?


## Soluition

I am sure, there is a better solution than this, but that came to implementation first.
Idea is pretty simple, let's sort array and fill the destination array.

This is not in-place sorting, but somehow it works.
When we fill, we need to do it in reverse with step 2 and differently for odd and even values.


``` go
func wiggleSort(nums []int)  {

	n := len(nums)

	if n <= 1 {
		return
	}

	if n == 2 {
		if nums[0] > nums[1] {
			nums[0], nums[1] = nums[1], nums[0]
		}
		return
	}

	sorted := make([]int, len(nums))
	copy(sorted, nums)

	sort.Ints(sorted)

	i := 0
	if n % 2 == 0 {
		i = fill(n - 2, nums, sorted, i)
		i = fill(n - 1, nums, sorted, i)
	} else {
		i = fill(n - 1, nums, sorted, i);
		i = fill(n - 2, nums, sorted, i);
	}
}

func fill(m int, nums, sorted []int, i int) int {
	for j := m; j >= 0; j -= 2 {
		nums[j] = sorted[i]
		i++
	}
	return i
}
```
