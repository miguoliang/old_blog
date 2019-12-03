---
layout: post
title:  "Java Regular Expression: How To Match Chinese Characters"
date:   2019-1-18 07:32:00 +0800
description: How to match Chinese characters using regular expression in Java.
image: /assets/2019-1-18-java-regular-expression-match-chinese-characters/banner.jpg
categories:
    - code
tags:
    - java
---

A word that is combined Chinese characters with alpha digits characters seems like a whole word. So `\b` is no use on matching the alpha digits characters in the word.

```java
    // your code goes here
    Pattern with_word_boundary = Pattern.compile("(?i)^\\w+\\b.*$");
    Pattern without_word_boundary = Pattern.compile("(?i)^\\w+.*$");

    String case_1 = "China中国";
    String case_2 = "China 中国";

    System.out.println(with_word_boundary.matcher(case_1).matches()); // false
    System.out.println(with_word_boundary.matcher(case_2).matches()); // true
    System.out.println(without_word_boundary.matcher(case_1).matches()); // true
    System.out.println(without_word_boundary.matcher(case_2).matches()); // true
```
