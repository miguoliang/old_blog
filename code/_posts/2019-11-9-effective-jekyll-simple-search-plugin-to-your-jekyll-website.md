---
title: "Effective Jekyll: Add Simple Search Plugin to Your Jekyll Website"
description: How to add simple search plugin to your Jekyll website
date: 2019-11-9 00:00:00 +08:00
image: /assets/2019-11-9-effective-jekyll-simple-search-plugin-to-your-jekyll-website/banner.jpg
categories:
    - code
tags:
    - jekyll
---

## Introduction

Most of websites need a search box to help people find articles by keywords easily. This articles shows how to integrate the **SimpleJekyllSearch** plugin with your Jekyll  website to add a website-wide instant search box on pages.

**Notes here**: ***SimpleJekyllSearch*** *is not AMP friendly, because its CDN address is not acceptable and its custom script practise is not allowed by AMP custom script specification.*

## Setup SimpleJekyllSearch

1. Create *search.json* in the root of your website directory.
2. Paste the following default configuration codes into *search.json*.

    ```json
    ---
    layout: null
    ---
    [
        {% for post in site.posts %}
            {
            "title"    : "{{ post.title | escape }}",
            "category" : "{{ post.category }}",
            "tags"     : "{{ post.tags | join: ', ' }}",
            "url"      : "{{ site.baseurl }}{{ post.url }}",
            "date"     : "{{ post.date }}"
            } {% unless forloop.last %},{% endunless %}
        {% endfor %}
    ]
    ```

3. Overwrite the default layout.

    1. Create *_layouts* directory by the command `mkdir -p _layouts` in the root of your website directory.
    2. Create *default.html* file by the command `touch default.html` in the *_layouts* folder you just created.
    3. Paste the following codes and save changes to overwrite the default layout.

        ```html
        
        ```