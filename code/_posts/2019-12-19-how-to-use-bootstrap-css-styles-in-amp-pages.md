---
layout: post
title: How to use Bootstrap CSS Styles in AMP Pages
description: This article explains how to remove unused Bootstrap CSS Styles and use the rest of the styles in AMP pages.
date: 2019-12-19 00:00:00 +08:00:00
image: /assets/2019-12-19-how-to-use-bootstrap-css-styles-in-amp-pages/banner.jpg
categories:
    - code
tags:
    - amp
---

## Introduction

AMP does not allow developers to import Bootstrap CSS Styles from any CDN, because Bootstrap has lots of styles so that it can make page rendering slow. Is it means we can not use Bootstrap to build responsive pages? No. You can learn the best practice to use Bootstrap in your AMP Pages correctly.

## 1. Start a new website project

You can use Jekyll to generate and manage a static website project. Read [Jekyll Beginner Guide](/jekyll-beginner-guide.html) to learn it in 5 minutes.

Run command `jekyll new demo-website` to create a static website project.

## 2. Create *_includes/head_amp.html*

1. Create a folder named *_includes* in the root directory of your website project.
2. Create a file named *head_amp.html* in *_includes* folder.
3. Paste the below codes into *head_amp.html*.

```html
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    {% raw %}
    {% capture styles %}
    {% include styles.scss %}
    {% endcapture %}
    {% endraw %}
    <style amp-custom>
        {% raw %}
        {{ styles | scssify }}
        {% endraw %}
    </style>
    <style amp-boilerplate>body{-webkit-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-moz-animation:-amp-start 8s steps(1,end) 0s 1 normal both;-ms-animation:-amp-start 8s steps(1,end) 0s 1 normal both;animation:-amp-start 8s steps(1,end) 0s 1 normal both}@-webkit-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-moz-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-ms-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@-o-keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}@keyframes -amp-start{from{visibility:hidden}to{visibility:visible}}</style><noscript><style amp-boilerplate>body{-webkit-animation:none;-moz-animation:none;-ms-animation:none;animation:none}</style></noscript>
</head>
```

## 3. Create *_layout/default_amp.html*

1. Create a folder named *_layouts* in the root directory of your website project.
2. Create a file named *default_amp.html* in *_includes* folder.
3. Paste the below codes into *default_amp.html*.

```html
<!DOCTYPE html>
<html amp lang="{{ page.lang | default: site.lang | default: "en" }}">
{% raw %}
{%- include head_amp.html -%}
{% endraw %}
<body>
    <main class="page-content" aria-label="Content">
        <div class="wrapper">
            {% raw %}
            {{ content }}
            {% endraw %}
        </div>
    </main>
</body>
</html>
```

## 4. Create *_includes/styles.scss* to save custom styles

Run command `touch _includes/styles.scss` in the root directory of your website project.

## 5. Create a demo page

1. Create a file named `amp.html` in the root directory of your website project.
2. Paste the below codes into `amp.html`.

```html
---
layout: default_amp
---

<h1>Example heading <span class="badge badge-secondary">New</span></h1>
<h2>Example heading <span class="badge badge-secondary">New</span></h2>
<h3>Example heading <span class="badge badge-secondary">New</span></h3>
<h4>Example heading <span class="badge badge-secondary">New</span></h4>
<h5>Example heading <span class="badge badge-secondary">New</span></h5>
<h6>Example heading <span class="badge badge-secondary">New</span></h6>
```

## 6. Remove unused Bootstrap CSS styles

1. Open [UnCSS Online](https://uncss-online.com)

    ![UnCSS Online](/assets/2019-12-19-how-to-use-bootstrap-css-styles-in-amp-pages/uncss.jpg)

2. Copy HTML from *amp.html* to the left text box.
3. Paste the source code of Bootstrap CSS to the right text box.
4. Press **UNCSS MY STYLES**
5. Copy the source code from the bottom text box.

## 7. Use the elegant Bootstrap CSS

Paste the source code that you just copied into *_includes/styles.scss*.

## 8. Run your website

1. Run command `jekyll serve` in your prompt in the root directory of your website.
2. Open `http://localhost:4000#development=1` in your **Chrome**.

    *Note*: `#development=1` can start AMP validator, any exceptions will be printed on the console.

![Result](/assets/2019-12-19-how-to-use-bootstrap-css-styles-in-amp-pages/result.jpg)

*You can download full source code of the above demo from [my Github repository](https://github.com/miguoliang/effective-jekyll.git)*

## Conclusion

AMP is strict, Bootstrap is convenient and powerful, but they are not compatible with each other by default. What we need in the article is to remove unused Bootstrap CSS Styles and make useful styles imported inline. I hope it helps.
