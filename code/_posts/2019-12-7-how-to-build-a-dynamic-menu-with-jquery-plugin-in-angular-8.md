---
layout: post
title: How to build a dynamic menu with jQuery plugin in Angular 8
description: This article shares my experiences about jQuery plugin integration in Angular 8. And you will learn how to create a dynamic menu with the jQuery plugin named metisMenu in Angular properly.
image: /assets/2019-12-7-how-to-build-a-dynamic-menu-with-jquery-plugin-in-angular-8/banner.jpg
date: 2019-12-7 00:00:00 +08:00:00
categories:
    - code
tags:
    - angular
---

## Introduction

Sometimes we need to display different menus to different users, for example, a staff can not see the menu item named *Staff management* in his dashboard, but his boss can see it.

We can find many jQuery plugins to create beautiful and powerful menu, but how to make them working in Angular as well? Angular does not recommend people control DOM directly, because mannual DOM control will make Angular confused so that the website works in exception.

Howerver, we know that jQuery plugins control DOM directly, and many good jQuery plugins can speed up our development, so how to integrate jQuery plugins with Angular correctly and smoothly? This article tells you how to do that!

In this article, you will learn how to build a dynamic menu with jQuery plugin in Angular 8. I use *metisMenu* as the jQuery plugin to build menu.

## 1. Create a new Angular project

Run command `ng new dynamic-menu` in your prompt.

## 2. Install metisMenu

Enter your project folder by command `cd dynamic-menu` and  run command `npm install --save metismenu`.

## 3. Import *metisMenu* to our Angular project

Open *angular.json* file.

Add *jQuery* and *metisMenu* scripts in the path `projects.dynamic-menu.architect.build.scripts`:

* *node_modules/metismenu/dist/metisMenu.min.js*
* *node_modules/jquery/dist/jquery.slim.min.js*

Add *metisMenu* styles in the path `projects.dynamic-menu.architect.build.styles`:

* *node_modules/metismenu/dist/metisMenu.min.css*

## 5. Create a menu component

1. Run command `ng generate component menu-side --skipTests=true --inlineStyle=true --inlineTemplate=true --flat=true` in your prompt.

2. Paste the following code into the *menu-side.component.ts*.

```typescript
import {
    Component,
    AfterContentInit,
    ViewChild,
    ElementRef,
    TemplateRef,
    HostBinding
} from '@angular/core';

declare const $: any;

@Component({
    selector: 'app-menu-side',
    template: `
        <ul class="metismenu" #el>
            <ng-content></ng-content>
        </ul>
    `,
    styles: ['']
})
export class MenuSideComponent implements AfterContentInit {

    @HostBinding('class') classes = 'sidebar-nav';

    @ViewChild('el', { static: true, read: ElementRef }) el: ElementRef;

    constructor() { }

    ngAfterContentInit() {
        $(this.el.nativeElement).metisMenu();
    }

}

```

## 6. Use MenuSideComponent in AppComponent

1. Paste the following code into *app.component.ts*.

    ```typescript
    import { Component, OnInit } from '@angular/core';

    @Component({
        selector: 'app-root',
        templateUrl: './app.component.html',
        styleUrls: ['./app.component.css']
    })
    export class AppComponent implements OnInit {

        menuData;

        ngOnInit() {

            setTimeout(() => this.menuData = [
            {
                text: 'Dashboard', children: [
                { text: 'Dashboard v1' },
                { text: 'Dashboard v2' }
                ]
            },
            {
                text: 'Products', children: [
                { text: 'Product v1' },
                { text: 'Product v2' },
                ]
            },
            {
                text: 'Orders'
            }
            ], 5000);

        }

    }

    ```

2. Paste the following code into *app.component.html*.

    ```html
    <app-menu-side *ngIf="menuData">
    <li *ngFor="let item of menuData; let idx = index" [class.mm-active]="idx === 0">
        <a href="#" [class.has-arrow]="item?.children" [attr.aria-expanded]="!!item?.children">
        {{ item?.text }}
        </a>
        <ul class="nav nav-second-level collapse" *ngIf="item?.children">
        <li *ngFor="let subItem of item?.children">
            <a href="#">
            <span class="nav-label">{{ subItem?.text }}</span>
            </a>
        </li>
        </ul>
    </li>
    </app-menu-side>
    <router-outlet></router-outlet>
    ```

## 7. Beautify the menu

Paste the following code into *style.css*.

```css
/* You can add global styles to this file, and also import other style files */
.sidebar-nav {
  background: #212529;
}
.sidebar-nav ul {
  padding: 0;
  margin: 0;
  list-style: none;
  background: #343a40;
}

.sidebar-nav .metismenu {
  background: #212529;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -ms-flex-direction: column;
  flex-direction: column;
}

.sidebar-nav .metismenu li + li {
margin-top: 5px;
}

.sidebar-nav .metismenu li:first-child {
margin-top: 5px;
}
.sidebar-nav .metismenu li:last-child {
margin-bottom: 5px;
}


.sidebar-nav .metismenu > li {
  /*-webkit-box-flex: 1;
  -ms-flex: 1 1 0%;
  flex: 1 1 0%;*/
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
  -ms-flex-direction: column;
  flex-direction: column;
  position: relative;
}
.sidebar-nav .metismenu a {
  position: relative;
  display: block;
  padding: 13px 15px;
  color: #adb5bd;
  outline-width: 0;
  transition: all .3s ease-out;
}

.sidebar-nav .metismenu ul a {
  padding: 10px 15px 10px 30px;
}

.sidebar-nav .metismenu ul ul a {
  padding: 10px 15px 10px 45px;
}

.sidebar-nav .metismenu a:hover,
.sidebar-nav .metismenu a:focus,
.sidebar-nav .metismenu a:active,
.sidebar-nav .metismenu .mm-active > a {
  color: #f8f9fa;
  text-decoration: none;
  background: #0b7285;
}

```

## 8. Verify the menu appearance

1. Run command `ng serve` in your prompt.

2. Open `http://localhost:4200` in your browser, and you will see the menu after 5 seconds.

![Screenshot](/assets/2019-12-7-how-to-build-a-dynamic-menu-with-jquery-plugin-in-angular-8/screenshot.gif)

{%- include google-adsense-amp.html max-height="100" -%}

*You can find [the demo's source code](https://github.com/miguoliang/metismenu-in-angular) in my github.*

## Conclusion

Millions of *jQuery* plugins can help us speed up our development with fancy user experience, but pure *jQuery* programming can not hold complex projects in the future, that's why Angular was born. So we have to pay attention to make them work together as well.

We can import jQuery plugins to an Angular project in many ways, and your choice should depend on the situation. The way mentioned in this article is only one of them.

*Angular Lifecycle Hooks* is an important concept, everyone should compare all hooks with DOM event listeners, and find differences between them, in fact they are not one-to-one correspondence. *Angular Lifcycle Hooks* is designed specifically for modular programming, so it is more flexible, powerful, and complex than DOM event listeners.
