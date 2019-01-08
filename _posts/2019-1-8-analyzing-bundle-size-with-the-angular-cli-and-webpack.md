---
layout: post
title:  "Analyzing bundle size with the Angular CLI and Webpack"
date:   2019-1-8 22:00:00 +0800
categories: webpack
---
> __NOTATION:__
  This article is a tiny version of Cory Rylan's [Analyzing bundle size with the Angular CLI and Webpack](https://coryrylan.com/blog/analyzing-bundle-size-with-the-angular-cli-and-webpack).

1. Run `ng build --prod --stats-json`
1. Run `npm install --save-dev webpack-bundle-analyzer`
1. Once installed add the following entry to the npm scripts in the `package.json`: 
```json
    "bundle-report": "webpack-bundle-analyzer dist/stats.json
```
1. Once added run the following command: `npm run bundle-report`

After the above, you may get a graphy like the below:

![Demo](/assets/angular-cli-webpack-bundle-analyzer.png)