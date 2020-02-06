---
layout: post
title: How to build a custom matcher for Spring Boot integration testing
description: How to build a custom matcher for Spring Boot integration testing
image: /assets/2020-2-5-how-to-build-a-custom-matcher-for-spring-boot-integration-testing/banner.jpg
categories:
    - code
tags:
    - spring boot
---

## Introduction

I need to check whether the response text is a empty string in a Spring Boot Integration Test method, but there is not a matcher can do it in the Spring Testing package. Therefore, I need to build a custom mather to do it, and I will show you how to build and use a custom matcher in Spring Boot Integration Testing.

## How to build a custom matcher

The best way to build a custom matcher in Spring Boot Integration Testing is in Spring Boot Way so that I create a custom matcher class inherited from `TypeSafeMatcher<T>`, like this:

```java
package com.muchencute.mrrs.matchers;

import org.apache.commons.lang3.StringUtils;
import org.hamcrest.Description;
import org.hamcrest.TypeSafeMatcher;

public class NotEmptyString extends TypeSafeMatcher<String> {

    @Override
    public void describeTo(Description description) {
        description.appendText("it is not an empty string.");
    }

    @Override
    protected boolean matchesSafely(String item) {
        return StringUtils.isNotEmpty(item);
    }

}
```

The`describeTo` and `matchesSafely` methods are the only two abstract methods you need to override in your class. The `describeTo` method sets the text when match failed, and The `matchesSafely` method includes logics of matching and returns the result of matching.

## How to use it in integration tests

Integration testing is different from Unit testing. The former foucs on the input and output of RESTful APIs, and the latter is focus on code coverage of your codes.

I create a new test method in my test class, like this:

```java
public class DemoTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    public void testLogin() throws Exception {

            final LoginRequest req = new LoginRequest();
            req.setUsername("admin@example.com");
            req.setPassword("(21hY+Lz");
            mockMvc.perform(post("/auth/login?t=admin").contentType(MediaType.APPLICATION_JSON)
                            .content(new Gson().toJson(req))).andDo(print())
                            .andExpect(status().isOk())
                            .andExpect(jsonPath("token", new NotEmptyString()));
    }
}
```

This test will send a post request to */auth/login?t=admin* and expect the value of the *token* field is not a empty string in the json response.

## Conclusion

Integration Testing is important to improve the quanlity of a software. Developers should writing integration Testing to verify whether the RESTful APIs works well after their changes.
