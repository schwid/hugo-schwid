+++
date = "2019-04-30"
title = "Convert to Base -2"
slug = "Convert to Base -2"
tags = []
categories = []
+++

## Introduction

Given a number N, return a string consisting of "0"s and "1"s that represents its value in base -2 (negative two).

The returned string must have no leading zeroes, unless the string is "0".

 

Example 1:
```
Input: 2
Output: "110"
Explantion: (-2) ^ 2 + (-2) ^ 1 = 2
```

Example 2:
```
Input: 3
Output: "111"
Explantion: (-2) ^ 2 + (-2) ^ 1 + (-2) ^ 0 = 3
```

Example 3:
```
Input: 4
Output: "100"
Explantion: (-2) ^ 2 = 4
```

Note:
```
0 <= N <= 10^9
```

### Solution

Bit manipulation solution:
``` go
func baseNeg2(N int) string {
    
    // 64(-32)16(-8)4(-2)1
    
    // 0 - 0000
    // 1 - 0001
    // 2 - 0110
    // 3 - 0111
    // 4 - 0100
    // 5 - 0101
    // 6 -11010 
    // 7 -11011  
    // 8 -11000
    // ...
    // 14-10010
    // 15-10011
    
    b := make([]int, 40)
    
    v := N
    idx := 0
    for ; v > 0; idx++ {
        if v & 1 > 0 {
            
            if idx % 2 == 0 {
                
                if b[idx] == 1 {
                   b[idx] = 0
                   b[idx+1] = 1
                   b[idx+2] = 1                    
                } else {
                   b[idx] = 1
                }
                
            } else {
                
                if b[idx] == 1 {
                    b[idx] = 0
                } else {
                    b[idx] = 1
                    b[idx+1] = 1
                }
            }
      
        } 
        v >>= 1
    }    

    idx += 2
    for ;b[idx] == 0 && idx > 0; idx-- {
    }
    
    var sb strings.Builder
    
    for i := idx; i >= 0; i-- {
        if b[i] == 1 {
            sb.WriteString("1")
        } else {
            sb.WriteString("0") 
        }
    }
    
    return sb.String()
    
}
```

### Explanation

Bit manipulation is a very straight forward solution. The biggest challenge is to implement incremental logic for x^2 bits that we get from N
