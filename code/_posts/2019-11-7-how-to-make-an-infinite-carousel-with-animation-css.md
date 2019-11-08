---
layout: post
title:  "How to Make an Infinite Carousel with Animation.css"
date:   2019-11-07 19:31:00 +0800
categories:
    - code
---

![How to Make an Infinite Carousel in Jekyll](/assets/2019-11-7-how-to-make-an-infinite-carousel-in-jekyll/banner.jpg)

## Introduction

A carousel has almost been a neccessary widget on the website homepage, and it always be placed on the top, and it always be big enought. A carousel is used to present the most important topics at the best position of the page.

Bootstrap has a carousel control, but you must import many files for this widget, so it must not be a good choice for simple site. And Bootstrap may be confict with the existing CSS framework, because Bootstrap will reboot tags default styles to support its own logics.

So writing a simple and useful enough carousel is good for some scensories, that is why I write this article.

In this article, you will be clear that how to make a simplest carousel with pure javascript, and how to control the animation with animation.css.

You will build a demo website by Jekyll, because you can debug your static website easily.

## What is Animation.css

animate.css is a bunch of cool, fun, and cross-browser animations for you to use in your projects. Great for emphasis, home pages, sliders, and general just-add-water-awesomeness. It is very easy to use. We will import it by cdn link <https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.7.2/animate.min.css> in the index.html.

## What is Jekyll

Jekyll is a famous and popular static website generator. Github Pages supports Jekyll very well so that Jekyll has been used widely than before.

A developer can write a website like writing a document with Jekyll. Markdown and HTML are supported in Jekyll.

It's so easy in fact, you will love it, I promise.

## Create a new Jekyll website

First of all, you need to create a new Jekyll website by the command `jekyll new demo-website`, and a new folder is created in your current directory, and this folder is our work directory, so you need enter it by command `cd demo-website`.

## Verify the new website locally

Run the command `jekyll serve` to start the new website locally, generally we call it debug mode, because you can update your code, and Jekyll will compile your code instantly, what you need is refresh your browser to check the latest modification.

```shell
$ jekyll serve
Configuration file: /Users/miguoliang/Documents/Github/demo-website/_config.yml
            Source: /Users/miguoliang/Documents/Github/demo-website
       Destination: /Users/miguoliang/Documents/Github/demo-website/_site
 Incremental build: disabled. Enable with --incremental
      Generating...
       Jekyll Feed: Generating feed for posts
                    done in 0.531 seconds.
 Auto-regeneration: enabled for '/Users/miguoliang/Documents/Github/demo-website'
    Server address: http://127.0.0.1:4000/
  Server running... press ctrl-c to stop.
```

As the output says, you can access your website with the URL `http://127.0.0.1:4000` in your browser.

## Custom the index.html

In the project root directory, rename the index.md to index.html, it means Jekyll compiles the index.html as a HTML file.

Clear the index.html, and add the following codes at the top of the index.html.

```html
---
layout: default
---
```

This means that the `default` layout will be used as the parent of this page. And I will discuss all about Jekyll concepts in other articles, so let us go ahead.

## Design a Carousel

You will design a three pages carousel next, and the three pages will slide in and out one by one and infinitly.

Firstly, arrage a `div` as the container of the carousel, and arrange three new `div`s as its children. These codes should looks like this:

```html
---
layout: default
---
<div class="container">
    <div class="page-0"></div>
    <div class="page-1"></div>
    <div class="page-2"></div>
</div>
```

The next, let us new a css file to control the cascading styles for these HTML elements. Usually, you should put the css files into the `assets` folder, so you can create your css file in the `assets` folder too, and give it a name like `custom.css`.

```css
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
```

The key point of this css file is the `position` property settings. Because the carousel places all pages in a same area, so these pages are cascading in fact. It seems like this:

![the Arrangement of Pages](assets/2019-11-7-how-to-make-an-infinite-carousel-in-jekyll/carousel.png)

You can found that, all pages have the same x and y coordinates, and the same width and height, so these settings can make sure the current page covers the whole area so that other pages disappear.

But another question comes, how to change the z-index of these pages? Factually, you never need to change the z-index at all. I do not mean it is not a solution, just not the best solution, because z-index should be used more strictly, for example, Bootstrap just defined some z-index constants to realize limited layer relationships, such as backdrop, modal, dropdownlist and so on. Factually, too many z-index definitions can make the layer relationships out of control and confused.

Alternativly, here you can use `opacity` instead of `z-index` to realize the same effect. In particular, the `opacity` of the current page is set to `1`, and the others are set to `0`.

For convennience, we define a new css class to set the opacity to `0`, just like this:

```css
.o0 {
  opacity: 0 !important;
}
```

We can use this class with the `add` and `remove` methods of `classList` to control the opacity easily.

## Start a Timer and Paginiation

We will write some javascript in index.html. There are two things we need to do here:

- Start a timer to control how long the interval of the pagination is.
- Control animations of pagination.

### Start a Timer

We can use `setInterval` method to start a infinite timer and set the 5 seconds interval in Javascript, it looks like this:

```javascript
setInterval(function () {
  // do what you want to do here
}, 5000, null);
```

### Control animations

At the first, we need write a method to make the control easier, and we can find these code in the animation.css official Github, it looks like this:

```javascript
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
```

This method is used to start a animation for the element, and invoke the callback method when this animation ends. But notice that, the `element` argument is a selector, not a DOM object.

The next, we will finish the rest of logics, just like this:

```javascript
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
```

In these codes, we:

1. Use `currentSlide` to record the index of the current page.
2. In the timer callback, we calculate the next index of pages, and add a `slideOutLeft` animation to the current page.
3. In the callback of `slideOutLeft` we add `o0` to make the current page invisible.
4. We make the next page visible, and add a `slideInRight` animation to the next page.

The final carousel looks like this:

![Final Carousel](/assets/2019-11-7-how-to-make-an-infinite-carousel-in-jekyll/screenshot.gif)

You can find the full codes in my Github. Click [here](https://github.com/miguoliang/carousel-in-jekyll).

## Conclusion

A Carousel is widely used, because it can save much space of the page. And the animation can make the visitor focus on it easily. This is a simplest carousel, and you can add your own features to it, and you can change the arrangement of page.
