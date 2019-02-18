---
layout: post
title:  "How to set FileList to Input typed File"
date:   2019-2-18 10:22:00 +0800
categories: angular test
---
If you want to test your upload component in Jasmine + Angular, you could do it like this to set files to an existing input:
```typescript
const dataTransfer = new DataTransfer();
const file = new File([''], 'test-file.jpg', { lastModified: new Date().getTime(), type: 'image/jpeg' });
dataTransfer.items.add(file);
```
### References
- Demo(https://embed.plnkr.co/HpBkr4/)