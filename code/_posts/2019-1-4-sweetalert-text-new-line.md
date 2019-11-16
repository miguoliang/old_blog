---
layout: post
title:  "Sweetalert 2: new line in text"
date:   2019-1-4 18:00:00 +0800
description: This article helps you make multiple lines in sweetalert2.
image: /assets/2019-1-4-sweetalert-text-new-line/banner.jpg
categories:
    - code
---

It's different between the two API `swal(title, text)` and `swal(option)` on showing multi line text.

```javascript
    const lines = ['line_1', 'line_2', 'line_3'];
    swal(lines.join('<br>')); // it works
    swal({ text: lines.join('<br>') }); // it does not work
```

demo in [jsfiddle](https://jsfiddle.net/jyrtqxc8/2/)
