---
layout: post
title:  "Tips to work Angular 2+ with Bootstrap 4"
date:   2019-4-18 10:31:00 +0800
categories: angular bootstrap
---
## Why Reactive Forms valueChanges not working?

for example, if you use [Radio Button Group](https://getbootstrap.com/docs/4.3/components/buttons/) in the Bootstrap way, the `data-toggle="buttons"` will stop the valueChanges event, so Angular will never know if the value has been changed.

In Bootstrap 4 way, that's will not work properly in Angular:
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

After modification:
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

## References
- [Bootstrap v4 Buttons Examples](https://getbootstrap.com/docs/4.3/components/buttons/)