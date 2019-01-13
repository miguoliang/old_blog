---
layout: post
title:  "How to enable pretty print JSON output (Gson)"
date:   2019-1-12 08:51:00 +0800
categories: java
---
To enable the pretty-print, create the `Gson` object with `GsonBuilder`
```java
    Gson gson = new GsonBuilder().setPrettyPrinting().create();
	String json = gson.toJson(obj);
	System.out.println(json);
```