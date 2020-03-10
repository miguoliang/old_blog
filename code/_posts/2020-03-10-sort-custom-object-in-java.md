---
layout: post
title: Sort Custom Object in Java
description: Using Collections.sort with a custom defined Comparator in Java to sort a set of POJOs.
image: /assets/2020-03-10-sort-custom-object-in-java/banner.jpg
categories:
    - code
tags:
    - java
---

1. Define a custom POJO, like this:

    ```java
    package com.example.models;

    public class ManufacturerPrice {

        private String name;

        private String description;

        // ... ommit setters & getters
    }
    ```

2. Define a Comparator variable, like this:

    ```java
    Comparator<ManufacturerPrice> priceComparator =
                (a, b) -> a.getName().compareTo(b.getName());
    ```

3. Use Collections.sort with your custom Comparator, like this:

    ```java
    // entities is a Collection of ManufacturerPrice, such as List, Set, etc.
    Collections.sort(entities, priceComparator);
    ```
