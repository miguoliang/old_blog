---
layout: post
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
        {% raw %}
        {% for post in site.posts %}
        {% endraw %}
            {
                "title"    : "{{ post.title | escape }}",
                "category" : "{{ post.category }}",
                "tags"     : "{{ post.tags | join: ', ' }}",
                "url"      : "{{ site.baseurl }}{{ post.url }}",
                "date"     : "{{ post.date }}"
            {% raw %}
            } {% unless forloop.last %},{% endunless %}
        {% endfor %}
        {% endraw %}
    ]
    ```

3. Overwrite the default layout.

    1. Create *_layouts* directory by the command `mkdir -p _layouts` in the root of your website directory.
    2. Create *default.html* file by the command `touch default.html` in the *_layouts* folder you just created.
    3. Paste the following codes and save changes to overwrite the default layout.

        ```html
        <!DOCTYPE html>
        <html lang="{{ page.lang | default: site.lang | default: "en" }}">

        {% raw %}
        {%- include head.html -%}
        {% endraw %}

        <body>

        {% raw %}
        {%- include header.html -%}
        {% endraw %}

        <main class="page-content" aria-label="Content">

            <div class="wrapper">
                <!-- Search Box DOM Elements -->
                <div class="search">
                    <i class="fa fa-search" aria-hidden="true"></i>
                    <input type="text" id="search-input" placeholder="Search posts by keyword ...">
                    <ul id="results-container"></ul>
                </div>
            </div>

            <div class="wrapper">
            {% raw %}
            {{ content }}
            {% endraw %}
            </div>
        </main>

        {% raw %}
        {%- include footer.html -%}
        {% endraw %}

        <!-- Import SimpleJekyllSearch scripts by CDN -->
        <script
            src="https://cdn.rawgit.com/christian-fei/Simple-Jekyll-Search/master/dest/simple-jekyll-search.min.js"></script>

        <!-- Initialize SimpleJekyllSearch Plugin -->
        <script>
            window.simpleJekyllSearch = new SimpleJekyllSearch({
                searchInput: document.getElementById('search-input'),
                resultsContainer: document.getElementById('results-container'),
                json: '{{ site.baseurl }}/search.json',
                searchResultTemplate: '<li><a href="{url}?query={query}" title="{desc}">{title}</a></li>',
                noResultsText: 'No results found',
                limit: 10,
                fuzzy: false,
                exclude: ['Welcome']
            })
        </script>

        </body>

        </html>
        ```

        **Notes Here**

        * The Search Box DOM elements is wrapped by `<div class="search">`, you can custom its appearance by css.
        * Import *SimpleJekyllSearch* plugin scripts by the CDN URL <https://cdn.rawgit.com/christian-fei/Simple-Jekyll-Search/master/dest/simple-jekyll-search.min.js>.
        * Initialize *SimpleJekyllSearch* plugin after the DOM loaded.

4. Generate and run your website locally by the command `jekyll serve`, and access it by opening `http://localhost:4000` on your browser.

    ![Final Result](/assets/2019-11-9-effective-jekyll-simple-search-plugin-to-your-jekyll-website/final-result.jpg)

*You can find the [demo repository](https://github.com/miguoliang/effective-jekyll.git) in my Github.*

## Conclusion

*SimpleJekyllSearch* is a popular plugin to make your Jekyll website searchable. It's fast and easy-to-use. People can configure the search rules by editing *search.json*, and custom the appearance by css.
