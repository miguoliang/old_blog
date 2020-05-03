---
layout: post
title: How to Document REST APIs in Spring Boot 2 and Generate an Swagger API Website Automatically
description:
image: /assets/2020-04-28-how-to-document-rest-apis-in-spring-boot-2-and-generate-an-swagger-api-website-automatically/banner.jpg
categories:
    - code
tags:
    - java
    - spring
    - spring boot
    - swagger
---

## Introduction

It's a hard work to document your REST API in a traditional way that to keep the consistant of codes and documents outside codes. Here, I will show you how to document your REST API closing to your source code in annotation way. That's awesome to back-end developers to make their work efficient and bug less to their documents.

Open API Specification v3.0 is a broadly adopted industry standard for describing modern APIs. You will learn how to work with it in the Java way easily instead of learning its details.

## 1. Create a new Maven Project by Spring Initializr

Access the URL of Spring Initializr <https://start.spring.io> in your browser. And we need add Spring Web library here.

![Spring Initializr](/assets/2020-04-28-how-to-document-rest-apis-in-spring-boot-2-and-generate-an-swagger-api-website-automatically/spring-initializr.jpg)

Press **Generate** to download the project. In this guide, the project's name is *demo*, therefore you can get a zip file named *demo.zip*. Unzip *demo.zip* and open the *demo* folder in your favorite editor or IDE to continue. In Visual Studio Code, it looks like:

![Initialized Porject](/assets/2020-04-28-how-to-document-rest-apis-in-spring-boot-2-and-generate-an-swagger-api-website-automatically/initialized-project.jpg)

## 2. Import springdoc-openapi Library

Springdoc-openapi is a great library to document our apis by annotations in Spring project. You can simply understand it as an extension of Swagger to Spring.

Next, find the latest version of [Springdoc-openapi](https://springdoc.org/) library in [Maven Repository Website](https://search.maven.org/) and add to *pom.xml*.

```xml
<dependency>
  <groupId>org.springdoc</groupId>
  <artifactId>springdoc-openapi-ui</artifactId>
  <version>1.3.7</version>
</dependency>
```

## 4. Create a Controller

Create a java file named *DemoController.java* and add codes in it like this:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.RestController;

@RestController
public class DemoController {
}
```

## 5. Create a REST API

Add a member method into *DemoController* like this:

```java
package com.example.demo;

import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@RestController
public class DemoController {
    @GetMapping(value = "/hello")
    public String helloBoy(@RequestParam String name) {
        return "Hello, " + name;
    }
}
```

## 6. Document the REST API

What to document for a API? I list some essential items:

- Description
- Parameters
- Response Codes
- Consumes (Content Types)
- Produces (Accept Types)

And I document this API like this:

```java
@Operation(description = "Say hello to some body!", responses = {
        @ApiResponse(responseCode = "200", content = @Content(
            schema = @Schema(implementation = String.class, example = "Hello, Jack"),
            mediaType = MediaType.TEXT_PLAIN_VALUE)) })
@GetMapping(value = "/hello")
public String helloBoy(@Parameter(description = "Boy's name") @RequestParam String name) {
    return "Hello, " + name;
}
```

`@Operation` is a method annotation. It contains many parameters, but not all parameters are required or essential. In this demo, I write a description for the API, and document the 200 response code including an example response and the media type of the response.

Besides, I document the only parameter *name*. In the argument list of `helloBoy`, you can use `@Parameter` annotation to document parameters of a API. The same as `@Operation`, `@Parameter` also have many parameters, and I will show you why I use springdoc-openapi instead of swagger. Springdoc-openapi can understand Spring annotations, it means that springdoc-openapi can find the name of method/parameters and whether a parameter is required in this case. So we only need to add a description to the parameter in `@Parameter` annotation. I think it's cool.

## 8. Run the Project

Run `mvn spring-boot:run` at the root directory of your project in your prompt.

## 9. Access the Document Website

Open the browser and access `http://localhost:8080/swagger-ui.html`.

![OpenAPI 3 Document](/assets/2020-04-28-how-to-document-rest-apis-in-spring-boot-2-and-generate-an-swagger-api-website-automatically/document.jpg)

## Conclusion

Less configurations makes developers focus on primary logics. Springdoc-api is growing and Open API v3 is growing too. Writing document make developers think carefully on their codes and business. Therefore, it's neccessary to pay more attention to find a better way to envolve our workflow. You can find more details about Swagger and related annotations usage in <https://github.com/swagger-api/swagger-core/wiki/Swagger-2.X---Annotations>.
