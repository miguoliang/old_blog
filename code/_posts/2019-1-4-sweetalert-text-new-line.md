---
layout: post
title:  "Sweetalert 2: new line in text"
date:   2019-1-4 18:00:00 +0800
description: This article helps you make multiple lines in sweetalert2. Patched Sweetalert2 version 9.x demo.
image: /assets/2019-1-4-sweetalert-text-new-line/banner.jpg
categories:
    - code
tags:
    - javascript
    - web
    - sweetalert
    - sweetalert2
---

It's different between the two API `swal(title, text)` and `swal(option)` on showing multi line text.

```javascript
    const lines = ['line_1', 'line_2', 'line_3'];
    swal(lines.join('<br>')); // it works
    swal({ text: lines.join('<br>') }); // it does not work
```

**Note:** for [Sweetalert2](https://sweetalert2.github.io/) Version 8.x and higher, the API has changed to `Swal.fire(...)`.

* version 7.x demo in [version 7.x](https://jsfiddle.net/jyrtqxc8/2/)
* version 9.x demo in [version 9.x](https://jsfiddle.net/j63qzut2/)
