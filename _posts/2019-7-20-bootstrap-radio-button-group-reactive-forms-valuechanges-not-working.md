---
layout: post
title:  "Bootstrap 4 Radio Button Group 组件无法触发 Angular Reactive Forms valueChanges 事件的解决方法"
date:   2019-7-20 10:31:00 +0800
categories: angular
---
在 Angular 中处理表单的理想方式是通过 Reactive Forms 的 valueChanges 订阅，这样做的优点如下：

* 使 HTML 更专注于页面展现，而不需要事件绑定，这样做更安全
* Reactive Forms valueChanges 是基于 Observable 的，因此可以使用 rxjs 的方式来处理事件
* Reactive Forms valueChanges 既可以针对整个表单订阅，也可以针对其中的某个组件进行订阅

初次在 Angular 中使用 Radio Button Group 使用方法

```html
<div [formGroup]="form" class="btn-group btn-group-toggle" data-toggle="buttons">
        <label class="btn btn-outline-green-500" [class.active]="form.value.orderStatus === 'paid'" for="paid">
                <input type="radio" formControlName="orderStatus" id="paid" value="paid">Paid
        </label>
        <label class="btn btn-outline-green-500" [class.active]="form.value.orderStatus === 'unpaid'" for="unpaid">
                <input type="radio" formControlName="orderStatus" id="unpaid" value="unpaid">Unpaid
        </label>
        <label class="btn btn-outline-green-500" [class.active]="form.value.orderStatus === 'wire'" for="wire">
                <input type="radio" formControlName="orderStatus" id="wire" value="wire">Wire transfer
        </label>
</div>
```

以上这段代码是参考 Bootstrap 4 的一般使用方法，我们在 Typescript 中进行了表单事件的订阅，运行后发现事件并没有被触发，经研究发现原因如下：

```html
<div [formGroup]="form" class="btn-group btn-group-toggle" data-toggle="buttons">
```

此处若保留`data-toggle="buttons"`，那么 Reactive Forms 是接收不到 `valueChanges` 事件的，即使直接在 HTML 中通过事件绑定也无法触发事件。因此要将`data-toggle="buttons"`去掉，改为人工处理样式变化，也就是借助 Angular 的双向绑定机制，实现后代码如下：

```html
<div [formGroup]="form" class="btn-group btn-group-toggle">
        <label class="btn btn-outline-green-500" [class.active]="form.value.orderStatus === 'paid'" for="paid">
                <input type="radio" formControlName="orderStatus" id="paid" value="paid">Paid
        </label>
        <label class="btn btn-outline-green-500" [class.active]="form.value.orderStatus === 'unpaid'" for="unpaid">
                <input type="radio" formControlName="orderStatus" id="unpaid" value="unpaid">Unpaid
        </label>
        <label class="btn btn-outline-green-500" [class.active]="form.value.orderStatus === 'wire'" for="wire">
                <input type="radio" formControlName="orderStatus" id="wire" value="wire">Wire transfer
        </label>
</div>
```

值得留意的是，此处的 checked 不再需要了。

下面是 [Bootstrap 官方文档](https://getbootstrap.com/docs/4.3/components/buttons/#checkbox-and-radio-buttons) 的叙述，指明了使用限制，这也就佐证了，如果我们使用 Reactive Forms 来控制表单，同时具备 Radio Button Group 的样式，那么就要人工或者使用 Angular 的方法来接管值变更和样式变更的逻辑。

> Checkbox and radio buttons
>
> Bootstrap’s .button styles can be applied to other elements, such as `<label>`s, to provide checkbox or radio style button toggling. Add data-toggle="buttons" to a .btn-group containing  those modified buttons to enable their toggling behavior via JavaScript and add .btn-group-toggle to style the `<input>`s within your buttons. Note that you can create single input-powered buttons or groups of them.
>
> The checked state for these buttons is only updated via click event on the button. If you use another method to update the input—e.g., with `<input type="reset">` or by manually applying the input’s checked property—you’ll need to toggle .active on the `<label>` manually.
>
> Note that pre-checked buttons require you to manually add the .active class to the input’s `<label>`.