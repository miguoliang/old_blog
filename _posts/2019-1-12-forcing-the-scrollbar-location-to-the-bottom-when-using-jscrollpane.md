---
layout: post
title:  "Forcing the scrollbar location to the bottom when using JScrollPane and JEditorPane"
date:   2019-1-12 08:51:00 +0800
categories: java
---
1. Put your `JTextArea` into a `JScrollPane`
1. Scroll in the `ChangeListener` of `JScrollPane`

```java
    mTextAreaScroll.getViewport().addChangeListener(e -> {
        JScrollBar scrollBar = mTextAreaScroll.getVerticalScrollBar();
        scrollBar.setValue(scrollBar.getMaximum());
    });
```

Reference: [https://www.experts-exchange.com/questions/20431482/Forcing-the-scrollbar-location-to-the-bottom-when-using-JScrollPane-and-JEditorPane.html](https://www.experts-exchange.com/questions/20431482/Forcing-the-scrollbar-location-to-the-bottom-when-using-JScrollPane-and-JEditorPane.html)