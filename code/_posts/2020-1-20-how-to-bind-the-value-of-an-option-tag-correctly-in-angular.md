---
layout: post
title: How to bind the value of an option tag correctly in Angular
description: How to bind the value of an option tag correctly in Angular
image: /assets/2020-1-20-how-to-bind-the-value-of-an-option-tag-correctly-in-angular/banner.jpg
categories:
    - code
tags:
    - angular
---

Developers should bind the value of an option tag with `[attr.value]` in HTML file, like this:

```html
<select>
    <option [attr.value]="book?.id">{{ book?.name }}</option>
</select>
```
