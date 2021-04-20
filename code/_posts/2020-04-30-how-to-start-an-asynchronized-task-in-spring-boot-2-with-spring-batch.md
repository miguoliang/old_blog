---
layout: post
title: How to Start An Asynchronized Task in Spring Boot 2 with Spring Batch
description:
image: /assets/2020-04-30-how-to-start-an-asynchronized-task-in-spring-boot-2-with-spring-batch/banner.jpg
categories:
    - code
tags:
    - java
    - spring
    - spring boot
    - spring batch
---

## Introduction

Spring Batch is a light batch framework. I will show you how to start an asynchronized task with it in a Spring Boot 2 Project step by step.

> You can download full souce code in my github [here](https://github.com/miguoliang/tutorial-spring-batch).

## Start a new project (in vscode)

1. Press `Command+Shift+P` and Select *>Spring Initializr: Create a Gradle Project..*
1. Specify a version, and 2.4.5 here
1. Specify a language, and Java here
1. Specify a group id, and *com.miguoliang* here
1. Specify a artifact id, and *springbatch* here
1. Specify a packaging type, and *Jar* here
1. Specify a Java version, and *11* here, because 11 is the latest LTS version by now.
1. Select *Spring Web*, *Spring Batch*, and *H2 Database Driver* dependencies
1. Finally, specify a folder where you want to place the project

## Create a Configuration class for Spring Batch

1. Create a new class named **BatchConfig** and inherited from **DefaultBatchConfigurer**
1. Add **@Configuration** and **@EnableBatchProcessing** annotations on the class.

Your code should look like this:

```java
package com.miguoliang.springbatch;

import org.springframework.batch.core.configuration.annotation.DefaultBatchConfigurer;
import org.springframework.batch.core.configuration.annotation.EnableBatchProcessing;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableBatchProcessing
public class BatchConfig extends DefaultBatchConfigurer {
  
}
```

## Use H2 embed database

Spring Batch depends a relationship database, we use H2 database here. What we need to do is only override the **dataSource** bean in the class.

```java
@Configuration
@EnableBatchProcessing
public class BatchConfig extends DefaultBatchConfigurer {

    @Bean
    public DataSource dataSource() {
        EmbeddedDatabaseBuilder embeddedDatabaseBuilder = new EmbeddedDatabaseBuilder();
        return embeddedDatabaseBuilder.addScript("classpath:org/springframework/batch/core/schema-drop-h2.sql")
                .addScript("classpath:org/springframework/batch/core/schema-h2.sql")
                .setType(EmbeddedDatabaseType.H2)
                .build();
    }
}
```

## Create a Job bean and Step beans

A job is a collection of steps in Spring Batch. We add a job bean and two step beans in **BatchConfig** we just created.

```java

@Configuration
@EnableBatchProcessing
public class BatchConfig extends DefaultBatchConfigurer {
  
  @Autowired
  private JobBuilderFactory jobBuilderFactory;

  @Autowired
  private StepBuilderFactory stepBuilderFactory;

  @Bean
  public DataSource dataSource() {
      EmbeddedDatabaseBuilder embeddedDatabaseBuilder = new EmbeddedDatabaseBuilder();
      return embeddedDatabaseBuilder.addScript("classpath:org/springframework/batch/core/schema-drop-h2.sql")
              .addScript("classpath:org/springframework/batch/core/schema-h2.sql")
              .setType(EmbeddedDatabaseType.H2)
              .build();
  }
  
  @Bean
  public Job myJob() {
    return jobBuilderFactory.get("myJob")
      .start(step1())
      .next(step2())
      .build();
  }

  @Bean
  public Step step1() {
    return stepBuilderFactory.get("step1").tasklet((contribution, b) -> {
      System.out.println("Morning World!");
      return RepeatStatus.FINISHED;
    }).build();
  }

  @Bean
  public Step step2() {
    return stepBuilderFactory.get("step2").tasklet((contribution, b) -> {
      System.out.println("Goodnight World!");
      return RepeatStatus.FINISHED;
    }).build();
  }

}

```

In **myJob** bean, you can known that **myJob** contains two steps: **step1** and **step2**. And a **myJob** job will start with **step1** and end with **step2**.

## Run and check the output

Click *Run* in the *Spring Boot Dashboard*, and check the *Debug Console*

![Final Output](assets/2020-04-30-how-to-start-an-asynchronized-task-in-spring-boot-2-with-spring-batch/image-1.jpg)

## Conclusion

As the above saying, the asynchronized job runs when your app starts. You can also run an asynchronized job in your request handler. Whatever, Spring Batch is an useful tools to handle background tasks in your Spring Boot application. Enjoy it!
