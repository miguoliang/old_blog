---
layout: post
title: How to Fix 415 Unsupported Media Type in Swagger UI and Spring Boot
description:
image: /assets/2020-04-28-how-to-fix-415-unsupported-media-type-in-swagger-ui-and-spring-boot/banner.jpg
categories:
    - code
tags:
    - spring
    - spring boot
    - swagger
    - swagger ui
---

## Introduction

In HTTP specification, the content type field in headers of a HTTP request is not required. Therefore, many clients do not set *Content-Type* field at all. In Spring Boot you found that if you set default consumes, for example *application/json* and *application/xml* in a controller class, all methods in this controller asking for allowed *Content-Type* values by default, and you get a 415 error when you access a GET or DELETE method without *Content-Type* fields. It's non-standard, and many developers talked lots of about whether a web application framework should ignore global content type settings for GET and DELETE methods.

However, by now, Spring does not ignore the controller level consume settings, that's why I guide you how to make GET and DELETE methods accept a request without Content-Type fields.

## 1. Start a new project with a GET method REST API

This step contains 5 sub-steps that I explained in [How to Document REST APIs in Spring Boot and Generate a Swagger API Website Automatically](/how-to-document-rest-apis-in-spring-boot-and-generate-a-swagger-api-website-automatically). The **TOP 5 STEPS** in that article can be reused in this guide so that let us focus on the core job next.

## 2. Annotate the Controller Class to Make its REST APIs Accept JSON and XML Content Types

Add `@RequestMapping` annotation on `DemoController` class like follows:

```java
package com.example.demo;

// import statements ...

@RestController
@RequestMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
public class DemoController {

    @GetMapping(value = "/hello")
    public String helloBoy(@Parameter(description = "Boy's name") @RequestParam String name) {
        return "Hello, " + name;
    }

}
```

`consumes` specifies acceptable content types in its child REST APIs. Spring Boot can parse the request body to an instance of your model. Spring Boot supports JSON to Model by default. We also need Spring Boot supports XML to Model, so we need to add *jackson-dataformat-xml* dependency in your *pom.xml* like follows:

```xml
<dependency>
  <groupId>com.fasterxml.jackson.dataformat</groupId>
  <artifactId>jackson-dataformat-xml</artifactId>
  <version>2.11.0</version>
  <type>bundle</type>
</dependency>
```

Next, let's add a GET method REST API in this controller, like this:

```java
package com.example.demo;

// import statements ...

@RestController
@RequestMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
public class DemoController {

    @GetMapping(value = "/hello")
    public String helloBoy(@Parameter(description = "Boy's name") @RequestParam String name) {
        return "Hello, " + name;
    }

}
```

Here, we run the application by `./mvnw spring-boot:run`, and access the swagger document by <http://localhost:8080/swagger-ui.html> in your browser.

![Swagger](/assets/2020-04-28-how-to-fix-415-unsupported-media-type-in-swagger-ui-and-spring-boot/swagger-1.png)

Next, click the */hello* to expand details, and click *Try it out* to enter the test mode.

![Test Mode](/assets/2020-04-28-how-to-fix-415-unsupported-media-type-in-swagger-ui-and-spring-boot/swagger-2.png)

Next, set a value to the param *name* and click *Next* to send a request.

![Send Request](/assets/2020-04-28-how-to-fix-415-unsupported-media-type-in-swagger-ui-and-spring-boot/swagger-3.png)

We get a 415 response which means an unsupported content type. Let's check the error message in the console of our server application.

![Server Logs](/assets/2020-04-28-how-to-fix-415-unsupported-media-type-in-swagger-ui-and-spring-boot/swagger-4.png)

A warn message is printed in the console of our server application. It means that the server application got a empty content type. Why? Because in the HTTP specification, a GET request should not have a request body so that the content-type field is not required and should not be sent in HTTP headers. However, we set a controller-wide acceptable content types in our Spring Boot application, and that's the reason why we got a 415 response. The direct reason is Spring Boot not follow this specification when you declare a controller-wide acceptable content types. The DELETE request has the same issue.

## 2. Allow the GET method REST API accept empty content type

We will override the controller-wide consume settings to accept all content types for a GET method REST API like this:

```java
@RestController
@RequestMapping(consumes = { MediaType.APPLICATION_JSON_VALUE, MediaType.APPLICATION_XML_VALUE })
public class DemoController {

    @GetMapping(value = "/hello", consumes = { MediaType.ALL_VALUE })
    public String helloBoy(@Parameter(description = "Boy's name") @RequestParam String name) {
        return "Hello, " + name;
    }

}
```

## 3. Test the GET method API in Swagger

Re-run our demo application, and send a same request in swagger document again.

![Test again](/assets/2020-04-28-how-to-fix-415-unsupported-media-type-in-swagger-ui-and-spring-boot/swagger-5.png)

## Conclusion

Like other engineering areas, software engineering has many specifications too. It's boring but powerful. Specifications stands for worthy experiences and effective practises, we should follow them and improve them continuously.
