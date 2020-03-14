---
layout: post
title:  "Use Javascript and Animate.css to Create a Slideshow in Jekyll"
date:   2019-11-07 19:31:00 +0800
description: Use Javascript and Animate.css to Create a Slideshow in Jekyll
image: /assets/2019-11-7-javascript-animate-css-slideshow-in-jekyll/banner.jpg
categories:
    - code
tags:
    - jekyll
---

## Introduction

Placing a slideshow on the home page has become standard. People use slides to show important content, such as promotions, events and hot products. Slides are animated, so it's easy to attract readers attention.

I will show you how to create a simple slideshow using Javascript and Animate.css in Jekyll.

These guides can help you quickly learn the basics we need in the following steps:

* Quickly learn the basics of Jekyll by [The Beginner's Guide on Jekyll](/jekyll-beginner-guide.html).

Now, I assume that you have mastered the basics above. I will program with VSCode, and you can use any other text editor you like instead.

## Step by Step

1. Create a new Jekyll website by the command `jekyll new effective-jekyll`.
2. Create a blank HTML file named `2019-11-7-javascript-animate-css-slideshow-in-jekyll.html` in the *_posts* directory.
3. Append the following code to make the HTML file you just created use the default layout.

    ```text
    ---
    layout: default
    ---
    ```

4. Appending the following code into the HTML to creeate the container and pages of the slideshow.

    ```html
    <div class="container">
      <div class="page-0"></div>
      <div class="page-1 o0"></div>
      <div class="page-2 o0"></div>
    </div>
    ```

5. Append the following code into the HTML file you just created to import animation.css from the [cdnjs](https://cdnjs.com/libraries/animate.css)

    ```html
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css">
    ```

6. Create the assets folder by the command `mkdir -p assets/2019-11-7-javascript-animate-css-slideshow-in-jekyll` in the root directory of your website to save asset files in the corresponding HTML file. *More about Effective Content Management in Jekyll by [Effective Jekyll Content Management: Image Assets in Posts](/effective-jekyll-content-management-image-assets-in-posts.html)*.
7. Create a blank css file named `custom.css` in the assets folder.
8. Append the following code into `custom.css` to control the cascading styles to elements in your HTML file.

    ```css
    .o0 {
        opacity: 0 !important;
    }

    .container {
      position: relative;
      height: 300px;
      overflow: hidden;
    }

    .container div {
        position: absolute;
        height: 100%;
        width: 100%;
        box-sizing: border-box;
        top: 0;
        padding: 1rem;
    }

    .page-0 {
        background-color: blue;
    }

    .page-1 {
        background-color: red;
    }

    .page-2 {
        background-color: yellow;
    }
    ```

    Notes here:

    * The portion of the page that exceeds the display range is hidden, so we have to set the `overflow` of the container to be `hidden`.
    * The three pages should be the same size and overlap, so we have set the `position` of the container to be `relative`, and set the `position` to `absolute` and the `top` to zero of the three pages. The relative position of the three pages looks like this:

      ![Pages Arrangement](/assets/2019-11-7-javascript-animate-css-slideshow-in-jekyll/carousel.jpg)

    * We fill different colors for each page to distinguish.
    * For simplicity, We change the `opacity` to control which page is the visible page instead of changing the coordinates of pages. We add the `o0` class to the page slided out when its animation ends, and remove the `o2` class to the page slided in when its animation ends.

9. Import `custom.css` by appending the following code into your HTML file.

    ```html
    <link rel="stylesheet" href="{{ "/assets/custom.css" | relative_url }}">
    ```

10. Append the following javascript code into the HTML to control animations of the slideshow.

    ```html
    <script>
      function animateCSS(element, animationName, callback) {
          const node = document.querySelector(element)
          node.classList.add('animated', animationName)
          function handleAnimationEnd() {
              node.classList.remove('animated', animationName)
              node.removeEventListener('animationend', handleAnimationEnd)
              if (typeof callback === 'function') callback(node)
          }
          node.addEventListener('animationend', handleAnimationEnd)
      }
      var currentSlide = 0;
      setInterval(function () {
          const outSlide = '.page-' + currentSlide;
          currentSlide = ++currentSlide % 3;
          const inSlide = '.page-' + currentSlide;
          animateCSS(outSlide, 'slideOutLeft', function () {
              const node = document.querySelector(outSlide);
              node.classList.add('o0');
          });
          const node = document.querySelector(inSlide);
          node.classList.remove('o0');
          animateCSS(inSlide, 'slideInRight', null);
      }, 5000, null);  
    </script>
    ```

    Notes here:

    * The `animateCSS` function is provided by the animate.css to add and remove the animations.
    * The `currentSlide` variable is used to save the index of the current page.
    * The `setInterval` function is a native Javascript function, and it calls a function or evaluates an expression at specified intervals (in milliseconds). We set the interval of pagination to 5 seconds (5,000 millionseconds) here.
    * `slideOutLeft` and `slideInRight` are pre-defined animation names by animate.css, and you can find full name list in the [animate.css homepage](https://daneden.github.io/animate.css/) or my [The Beginner's Guide on Animate.css](/animate-css-beginner-guide.html).

11. Compile and run your website by the command `jekyll serve` in the root directory of your website.
12. Open the url `http://localhost:4000/2019/11/07/javascript-animate-css-slideshow-in-jekyll.html` in your browser.

The final result should look like this:

![Final Carousel](/assets/2019-11-7-javascript-animate-css-slideshow-in-jekyll/screenshot.gif)

*You can download the source code of the demo from my GitHub. <https://github.com/miguoliang/effective-jekyll.git>*

## Conclusion

We use animate.css for animations, and javascript for logics, and CSS for elements arrangement. We also can add many features to the slideshow, such as indicators, to make our website unique and cool.
