+++
date = "2020-05-01"
title = "First Bad Version"
slug = "may 1 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

You are a product manager and currently leading a team to develop a new product. Unfortunately, the latest version of your product fails the quality check. Since each version is developed based on the previous version, all the versions after a bad version are also bad.

Suppose you have n versions [1, 2, ..., n] and you want to find out the first bad one, which causes all the following ones to be bad.

You are given an API bool isBadVersion(version) which will return whether version is bad. Implement a function to find the first bad version. You should minimize the number of calls to the API.

Example:

Given n = 5, and version = 4 is the first bad version.
```
call isBadVersion(3) -> false
call isBadVersion(5) -> true
call isBadVersion(4) -> true
```

Then 4 is the first bad version.

## Solution

This task is a standard binary search non-inclusion algorithm that always return first occurrence of the searching element.
Non inclusion condition `for lo < hi` guarantees that at the time of exit from the loop `lo` will be equal to `hi`, whereas `hi` is always suppose to be a badVersion or `n+1` for non-found:
```
if isBadVersion(mi) {
    hi = mi
}
```

The last condition guarantees that lo will always increase `lo = mi+1`

``` go
/**
 * Forward declaration of isBadVersion API.
 * @param   version   your guess about first bad version
 * @return 	 	      true if current version is bad
 *			          false if current version is good
 * func isBadVersion(version int) bool;
 */

func firstBadVersion(n int) int {
    lo, hi := 1, n+1
    for lo < hi {
        mi := (hi - lo) / 2 + lo
        if isBadVersion(mi) {
            hi = mi
        } else {
            lo = mi+1
        }
    }
    return lo
}
```
