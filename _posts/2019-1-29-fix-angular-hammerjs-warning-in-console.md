---
layout: post
title:  "Could not find HammerJS in Angular2+"
date:   2019-1-29 09:45:00 +0800
categories: angular
---
You should add the following code in your `polyfills.ts` if you got a warning like the title of this page in your console.
```typescript
import 'hammerjs/hammer';
```

References:
- [Angular 2 - 'Could not find HammerJS'](https://stackoverflow.com/questions/41322566/angular-2-could-not-find-hammerjs)