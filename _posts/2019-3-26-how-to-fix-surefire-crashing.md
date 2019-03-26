---
layout: post
title:  "How to fix surefire crashing"
date:   2019-3-26 14:22:00 +0800
categories: maven surefire
---
You need to clear maven caching by commands as below:
```shell
mvn dependency:purge-local-repository
```
### References
- [The forked VM terminated without saying properly goodbye. VM crash or System.exit called](https://stackoverflow.com/questions/23260057/the-forked-vm-terminated-without-saying-properly-goodbye-vm-crash-or-system-exi/53070605)