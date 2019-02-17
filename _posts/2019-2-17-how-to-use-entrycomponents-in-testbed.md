---
layout: post
title:  "How to use entryComponents in TestBed"
date:   2019-2-17 22:15:00 +0800
categories: angular test
---
You can simply override the `BrowserDynamicTestingModule` (the default module used in testing) like this:
```typescript
import {BrowserDynamicTestingModule} from '@angular/platform-browser-dynamic/testing';

TestBed.configureTestingModule({
  declarations: [
    TestComponent,
    // other components...
  ],
  providers: [
    ModalService
  ]
});

TestBed.overrideModule(BrowserDynamicTestingModule, {
  set: {
    entryComponents: [ModalComponent]
  }
});
```
### References
- [Look into supporting entryComponents in TestBed.configureModule](https://github.com/angular/angular/issues/12079#)