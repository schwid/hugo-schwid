+++
date = "2019-08-13"
title = "Smallest Sufficient Team"
slug = "Smallest Sufficient Team"
tags = []
categories = []
+++

## Introduction

In a project, you have a list of required skills req_skills, and a list of people.  The i-th person people[i] contains a list of skills that person has.

Consider a sufficient team: a set of people such that for every required skill in req_skills, there is at least one person in the team who has that skill.  We can represent these teams by the index of each person: for example, team = [0, 1, 3] represents the people with skills people[0], people[1], and people[3].

Return any sufficient team of the smallest possible size, represented by the index of each person.

You may return the answer in any order.  It is guaranteed an answer exists.

 

Example 1:
```
Input: req_skills = ["java","nodejs","reactjs"], people = [["java"],["nodejs"],["nodejs","reactjs"]]
Output: [0,2]
```

Example 2:
```
Input: req_skills = ["algorithms","math","java","reactjs","csharp","aws"], people = [["algorithms","math","java"],["algorithms","math","reactjs"],["java","csharp","aws"],["reactjs","csharp"],["csharp","math"],["aws","java"]]
Output: [1,2]
```

Constraints:
```
1 <= req_skills.length <= 16
1 <= people.length <= 60
1 <= people[i].length, req_skills[i].length, people[i][j].length <= 16
Elements of req_skills and people[i] are (respectively) distinct.
req_skills[i][j], people[i][j][k] are lowercase English letters.
Every skill in people[i] is a skill in req_skills.
It is guaranteed a sufficient team exists.
```

### Solution

``` go
func smallestSufficientTeam(req_skills []string, people [][]string) []int {

	cache := make(map[string]int)
	skills := 0
	for _, skill := range req_skills {
		cache[skill] = skills
		skills++
	}

	n := len(req_skills)

	dp := make(map[int][]int, 1 << uint(n))
	dp[0] = []int{}

	for i, person := range people {
        personSkills := transform(person, cache)
		for teamSkills, team := range dp {
			withPerson := teamSkills | personSkills
			if withPerson == teamSkills {
				continue
			}
			oldTeam, ok := dp[withPerson]
			if !ok || len(oldTeam) > len(team) + 1 {
                dp[withPerson] = append(copyOf(team), i)
			}
		}
	}

	return dp[len(dp)-1]

}

func copyOf(src []int) []int {
    dest := make([]int, len(src))
    copy(dest, src)
    return dest
}

func transform(skills []string, cache map[string]int) int {
	vec := 0
	for _, skill := range skills {
		if idx, ok := cache[skill]; ok {
			vec |= 1 << uint(idx)
		}
	}
	return vec
}
```

### Explanation

All required skills are <= 16, so it can fit in `int`. We can transform all skills in to numbers and use `or` operation to estimate impact of adding a person into team.
Let's put teams in to `dp` array, therefore we can end up with solution in last cell. It is guaranteed an answer exists.

