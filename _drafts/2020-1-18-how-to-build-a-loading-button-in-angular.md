---
layout: post
title: How to Build a Loading Button in Angular 8
description: How to Build a Loading Button in Angular 8
image:
categories:
    - code
tags:
    - angular
---

## Introduction

Developers need to prevent people submit a new request when the previous request is waiting for its server's response. A classic case is a form. Therefore, a good practice to resolve this problem is disable the submit button when people click it and the result has not been returned from the server. Generally, a spinner indicator also display next to or replace the text of the submit button. It maybe looks like this:

[!screenshot](/assets/2020-1-18-how-to-build-a-loading-button-in-angular/screenshot.gif)

Key steps in this article are:

1. Import **Ladda** library to your Angular project.
2. Create a Directive to convert a normal button to a loading button.

## 1. Import **Ladda** library to your Angular project

Ladda is a jQuery plugin to convert a normal button to a loading button. But jQuery is not friendly to Angular, we need to do some work to make jQuery and its plugins works well in Angular.

1. Create a new Angular project and install required dependencies

    1. Run command `ng new angular-ladda` to create a new Angular project.
    2. Run command `cd angular-ladda` to enter the root directory of the project.
    3. Run command `npm install jquery --save` to install jQuery
  
1. Install Ladda

  Run command `npm install ladda --save` in your prompt in the root directory of your Angular project.
2. Import Ladda's javascript and css files

  Open *angular.json* file, and add relative paths in proper positions like this:

  ```json
    "styles": [
        "node_modules/ladda/dist/ladda.min.css",
        "src/styles.scss"
    ],
    "scripts": [
        "node_modules/ladda/js/ladda.js"
    ]
  ```

## 2. Create a Directive

Run command `ng g d loading-button --skipTests=true` to generate a new directive without test file in the Angular project.