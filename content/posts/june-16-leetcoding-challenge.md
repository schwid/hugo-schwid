+++
date = "2020-06-16"
title = "Validate IP Address"
slug = "june 16 leetcoding challenge"
tags = []
categories = []
+++

## Introduction
Write a function to check whether an input string is a valid IPv4 address or IPv6 address or neither.

IPv4 addresses are canonically represented in dot-decimal notation, which consists of four decimal numbers, each ranging from 0 to 255, separated by dots ("."), e.g.,172.16.254.1;

Besides, leading zeros in the IPv4 is invalid. For example, the address 172.16.254.01 is invalid.

IPv6 addresses are represented as eight groups of four hexadecimal digits, each group representing 16 bits. The groups are separated by colons (":"). For example, the address 2001:0db8:85a3:0000:0000:8a2e:0370:7334 is a valid one. Also, we could omit some leading zeros among four hexadecimal digits and some low-case characters in the address to upper-case ones, so 2001:db8:85a3:0:0:8A2E:0370:7334 is also a valid IPv6 address(Omit leading zeros and using upper cases).

However, we don't replace a consecutive group of zero value with a single empty group using two consecutive colons (::) to pursue simplicity. For example, 2001:0db8:85a3::8A2E:0370:7334 is an invalid IPv6 address.

Besides, extra leading zeros in the IPv6 is also invalid. For example, the address 02001:0db8:85a3:0000:0000:8a2e:0370:7334 is invalid.

Note: You may assume there is no extra space or special characters in the input string.

Example 1:
Input: "172.16.254.1"

Output: "IPv4"

Explanation: This is a valid IPv4 address, return "IPv4".
Example 2:
Input: "2001:0db8:85a3:0:0:8A2E:0370:7334"

Output: "IPv6"

Explanation: This is a valid IPv6 address, return "IPv6".
Example 3:
Input: "256.256.256.256"

Output: "Neither"

Explanation: This is neither a IPv4 address nor a IPv6 address.

## Solution

``` go
func validIPAddress(IP string) string {
    n := len(IP)
    dots := 0
    colons := 0
    lead := true
    leadingZeros := 0
    j := -1
    dec := 0
    validDec := true
    validHex := true
    for i := 0; i < n; i++ {
        ch := IP[i]
        switch ch {
            case '.':
                if i == j+2 && leadingZeros == 1 {
                    leadingZeros = 0
                }
                if i == j+1 || !validDec || dec > 255 || colons > 0 || leadingZeros > 0 {
                    return "Neither"
                }
                dots++
                j = i
                lead = true
                leadingZeros = 0
                dec = 0
                validDec = true
            case ':':
                if i == j+1 || i > j+5 || !validHex || dots > 0 {
                    return "Neither"
                }
                colons++
                j = i
                validHex = true
            default:
                if ch == '0' {
                    if lead {
                        leadingZeros++
                    }
                } else {
                    lead = false
                }
                if ch >= '0' && ch <= '9' {
                    dec = dec * 10 + int(ch - '0')
                } else {
                    validDec = false
                    if !isValidHexLetter(ch) {
                        validHex = false
                    }
                }
        }
    }   

    if dots == 3 {
        if n == j+2 && leadingZeros == 1 {
            leadingZeros = 0
        }         
        if n == j+1 || !validDec || dec > 255 || colons > 0 || leadingZeros > 0 {
            return "Neither"
        }
        return "IPv4"
    }
    if colons == 7 {
        if n == j+1 || n > j+5 || !validHex || dots > 0 {
            return "Neither"
        }
        return "IPv6"
    }
    return "Neither"
}

func isValidHexLetter(ch byte) bool {
    if ch >= 'a' && ch <= 'f' {
        return true
    }
    if ch >= 'A' && ch <= 'F' {
        return true
    }
    return false
}
```

Performance of this solution is:
```
Runtime: 0 ms
Memory Usage: 2 MB
```
