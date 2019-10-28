---
layout: post
title:  "Java: Extract string by Matcher.find()"
date:   2018-12-31 19:22:27 +0800
categories: code
---
First of all, you must be clear on the differences between `Matcher.matches()` and `Matcher.find()`.

- The former means whether a string matches your regular expression strictly.
- The latter means trying to find a substring that matches the given regular expression in the given text.

It looks not accessible to comprehension, so let me show two cases below.

```java
Pattern regex_1 = Pattern.compile("20\\d{2}");
Pattern regex_2 = Pattern.compile(".*20\\d{2}.*");
String a_case = "global portable shore hardness testers 2018 2025";

Matcher matcher_1 = regex_1.matcher(a_case);
Matcher matcher_2 = regex_2.matcher(a_case);

matcher_1.matches(); // return false
matcher_2.matches(); // return true

matcher_1.find(); // return true
matcher_1.group(); // return 2018
matcher_1.find(); // return true
matcher_1.group(); // return 2025

matcher_2.find(); // return false
```

You could test the above code [here](https://ideone.com/odnrFj)

A Good online __Java Regex Tester__ is [here](https://www.freeformatter.com/java-regex-tester.html)
