---
layout: post
title:  "How to run single test by ng test"
date:   2019-2-17 22:05:00 +0800
categories: angular test
---
Use `fdescribe` instead of `describe` in your `.spec.ts` file, and run `ng test` again, you will found only the only unit test which is declared with `fdescribe` run.
### References
- [Users Jobs Teams Q&A for work Learn More How to execute only one test spec with angular-cli](https://stackoverflow.com/questions/40683673/how-to-execute-only-one-test-spec-with-angular-cli)