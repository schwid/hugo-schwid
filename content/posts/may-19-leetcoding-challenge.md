+++
date = "2020-05-19"
title = "Online Stock Span"
slug = "may 19 leetcoding challenge"
tags = []
categories = []
+++

## Introduction

Write a class StockSpanner which collects daily price quotes for some stock, and returns the span of that stock's price for the current day.

The span of the stock's price today is defined as the maximum number of consecutive days (starting from today and going backwards) for which the price of the stock was less than or equal to today's price.

For example, if the price of a stock over the next 7 days were [100, 80, 60, 70, 60, 75, 85], then the stock spans would be [1, 1, 1, 2, 1, 4, 6].



Example 1:
```
Input: ["StockSpanner","next","next","next","next","next","next","next"], [[],[100],[80],[60],[70],[60],[75],[85]]
Output: [null,1,1,1,2,1,4,6]
Explanation:
First, S = StockSpanner() is initialized.  Then:
S.next(100) is called and returns 1,
S.next(80) is called and returns 1,
S.next(60) is called and returns 1,
S.next(70) is called and returns 2,
S.next(60) is called and returns 1,
S.next(75) is called and returns 4,
S.next(85) is called and returns 6.
```

Note that (for example) S.next(75) returned 4, because the last 4 prices
(including today's price of 75) were less than or equal to today's price.


Note:
```
Calls to StockSpanner.next(int price) will have 1 <= price <= 10^5.
There will be at most 10000 calls to StockSpanner.next per test case.
There will be at most 150000 calls to StockSpanner.next across all test cases.
The total time limit for this problem has been reduced by 75% for C++, and 50% for all other languages.
```

## Solution

Let's first solve it by the most simple method but correct.

``` go
type StockSpanner struct {
    hist []int
}


func Constructor() StockSpanner {
    return StockSpanner {}
}


func (t *StockSpanner) Next(price int) int {
    n := len(t.hist)
    cnt := 1
    for i := n-1; i >= 0; i-- {
        if t.hist[i] <= price {
            cnt++
        } else {
            break
        }
    }
    t.hist = append(t.hist, price)
    return cnt
}


/**
 * Your StockSpanner object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Next(price);
 */
```

This slow method give this performance:
```
Runtime: 476 ms
Memory Usage: 9.9 MB
```

Let's optimize this solution by storing result of previous call.
In this case we can faster go through spans.

``` go
type StockSpanner struct {
    hist []int
    span []int
}

func Constructor() StockSpanner {
    return StockSpanner {}
}

func (t *StockSpanner) Next(price int) int {
    n := len(t.hist)
    cnt := 1
    for i := n-1; i >= 0; i-- {
        if t.hist[i] <= price {
            cnt += t.span[i]
            i -= t.span[i] - 1
        } else {
            break
        }
    }
    t.hist = append(t.hist, price)
    t.span = append(t.span, cnt)
    return cnt
}

/**
 * Your StockSpanner object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Next(price);
 */
```

The performance of this solution is

```
Runtime: 208 ms
Memory Usage: 8.7 MB
```


Let's join both arrays in to one array and join the increasing prices span in to one last price entry.

``` go
type StockSpanner struct {
    hist []int // price, cnt
}

func Constructor() StockSpanner {
    return StockSpanner {}
}

func (t *StockSpanner) Next(price int) int {
    n := len(t.hist)
    cnt := 1
    for i := n-2; i >= 0 && t.hist[i] <= price; i -= 2 {
        c := t.hist[i+1]
        cnt += c
    }
    if n > 0 && t.hist[n-2] <= price {
        t.hist[n-2] = price
        t.hist[n-1]++
    } else {    
        t.hist = append(t.hist, price, cnt)
    }
    return cnt
}

/**
 * Your StockSpanner object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Next(price);
 */
```

This solution is faster than previous one.

```
Runtime: 184 ms
Memory Usage: 14.5 MB
```

Let's go another refactoring and replace the array by reverse linked list.
Append operation could be very expensive on large arrays, and in this task we can face this issue.

After cleaning the code here is the best solution

``` go
type entry struct {
    price  int
    cnt    int
    prev   *entry
}

type StockSpanner struct {
    last  *entry
}

func Constructor() StockSpanner {
    return StockSpanner {}
}

func (t *StockSpanner) Next(price int) int {
    cnt := 1
    for e := t.last; e != nil && e.price <= price; e = e.prev {
        cnt += e.cnt
    }
    if t.last != nil && t.last.price <= price {
        t.last.price = price
        t.last.cnt++
    } else {
        t.last = &entry { price, cnt, t.last }
    }
    return cnt
}

/**
 * Your StockSpanner object will be instantiated and called as such:
 * obj := Constructor();
 * param_1 := obj.Next(price);
 */
```

Performance of this short and easy solution is also the best

```
Runtime: 176 ms
Memory Usage: 8.4 MB
```
