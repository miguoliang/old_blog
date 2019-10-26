---
layout: post
title:  "Server Side Rendering - Search Engine Optimization (SEO) Guide 2019 for Angular"
date:   2019-10-25 19:31:00 +0800
categories: seo
---

## Server Side Rendering (SSR)

Server Side Rendering means that the whole page will be rendered on the server side. By default, all Angular app will be rendered on the client side (the browser), and it is called Client Side Rendering (CSR). Such as PHP, JSP, ASP.NET and so on are SSR technology, but React, Vue and Angular are CSR technology.

### What's the problem without SSR

Generally CSR is good, but it is not SEO friendly. Because the crawler can not download the whole page in time. It can make the crawling sequence longer and longer, so Google can not index this page in a short time. That's bad really? So SSR is supported by Angular to make the app SEO friendly.

### How to work with SSR

By now, it's very easy to make your Angular app supporting SSR. You can follow the official guide. <https://angular.io/guide/universal>

There are six key times in SEO, so that all optimization should work around these:

#### Time to First Byte (TTFB)

TTFB is the total amount of time spent to receive the first byte of the response once it has been requested. It is the sum of "Redirect duration" + "Connection duration" + "Backend duration". This metric is one of the key indicators of web performance. Some ways to improve the TTFB include: optimizing application code, implementing caching, fine-tuning your web server configuration, or upgrading server hardware.

#### DOM Interactive Time

DOM Interactive Time is the point at which the browser has finished loading and parsing HTML, and the DOM (Document Object Model) has been built. 
The DOM is how the browser internally structures the HTML so that it can render it.

#### DOM Loaded

DOM Loaded is the point at which the DOM is ready (ie. DOM interactive) and there are no stylesheets blocking JavaScript execution.
If there are no stylesheets blocking JavaScript execution and there is no parser blocking JavaScript, then this will be the same as DOM interactive time. The time in brackets is the time spent executing JavaScript triggered by the DOM content loaded event.
Many JavaScript frameworks use this event as a starting point to begin execution of their code. Since this event is often used by JavaScript as the starting point and delays in this event mean delays in rendering, it's important to make sure that style and script order is optimized and that parsing of JavaScript is deferred.

#### First Paints

First Paints is the first point at which the browser does any sort of rendering on the page. Depending on the structure of the page, this first paint could just be displaying the background colour (including white), or it could be a majority of the page being rendered.
This timing is of significance because until this point, the browser will have only shown a blank page and this change gives the user an indication that the page is loading. However, we don't know how much of the page was rendered with this paint, so having a early first paint doesn't necessarily indicate a fast loading page.
If the browser does not perform a paint (ie. the html results in an blank page), then the paint timings may be missing.

#### Contentful Paint

Contentful Paint is triggered when any content is painted - i.e. something defined in the DOM (Document Object Model). This could be text, an image or canvas render.
This timing aims to be more representative of your user's experience, as it flags when actual content has been loaded in the page, and not just any change - but it may often be the same time as First Paint. Because the focus is on content, the idea is that this metric gives you an idea of when your user receives consumable information (text, visuals, etc) - much more useful for performance assessment than when a background has changed or a style has been applied.
If the browser does not perform a paint (ie. the html results in an blank page), then the paint timings may be missing.

#### On Load (Fully Load)

On Load is complete and all the resources on the page (images, CSS, etc.) have finished downloading. This is also the same time that DOM complete occurs and the JavaScript window.onload event fires. Note that there may be JavaScript that initiates subsequent requests for more resources, hence the reason why Fully loaded timing is preferred.
The time in brackets is the time spent executing JavaScript triggered by the Onload event.

> the SSR could increase the TTFB in theory, because the server holding DOM generation instead of the browser. So you should optimize your code to run fast and make your server hardware good enought. And brandwidth and internet speed are both important here. However, because the browser need not generate mount of DOM nodes, the DOM Interactive Time and the DOM Load Time will be earlier than CSR.

### Never stop optimize your code

For an Angular app, the key point is your Typescript CODE QUALITY! Good code runs fast, Bad code runs slow. That is very very important for First Paint, SO NEVER STOP YOUR OPTIMIZATION ON YOUR CODE.

A good online testing & analysis tool is [GTMetrix.com](https://gtmetrix.com). BUT DO NOT OVER OPTIMIZE.
