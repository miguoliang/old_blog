---
layout: post
title: How to bind the value of an option tag correctly in Angular
description: How to bind the value of an option tag correctly in Angular
image: /assets/2020-1-20-how-to-bind-the-value-of-an-option-tag-correctly-in-angular/banner.jpg
categories:
    - code
tags:
    - angular
---

There are two directives you can bind a value to an option tag when you are using reactive forms in Angular, one is `value`, and another is `ngValue`. The only difference between them is the type of the binding value. You can use `value` to bind a string type variable and use `ngValue` to bind any other type variable.

Let's define a simple *Book* class that we use in this tutorial.

```typescript
interface Book {
    id?: number;
    name?: string;
}
```

## The usage of `value`

```html
<select formControlName="book">
    <option *ngFor="let book of books" [value]="book?.name">{{ book?.name }}</option>
</select>
```

**Notes**: If you want to bind a non-string native variable to an option, such as `number` or `boolean`, you need to covert it to `string` at first. You can do it like this:

```html
<select formControlName="book">
    <option *ngFor="let book of books" [value]="book?.id + ''">{{ book?.name }}</option>
</select>
```

If you want to set a value to this `select` manually by `setValue` method, you must convert any non-string native type variable to a string type variable. I tested in a multiple selection `select`, but not tested in a single selection `select`, but no mattter whether it is neccessary to a single selection `select`, it is always a good practice in programming.

## The usage of `ngValue`

```html
<select [compareWith]="compareFn" formControlName="book">
    <option *ngFor="let book of books" [ngValue]="book">{{ book?.name }}</option>
</select>
```

```typescript
function compareFn(a: Book, b: Book) {
    return a && b && a.id === b.id;
}
```

`ngValue` is a better way to bind a complex data to an option.

**Note**: People should provide a `compareWith` function to the `select` control to help Angular selects option because Angular uses object identity to select an option. The identities of items can change while the data does not. This case can happen, for example, if the items are produced from an RPC to the server, and that RPC is re-run. Even if the data hasn’t changed, the second response will produce objects with different identities.

`select` supports `compareWith` input to customize the default option comparison algorithm. `compareWith` takes a function that has two arguments: `option1` and `option2`. If `compareWith` is given, Angular selects an option by the return value of the function.
