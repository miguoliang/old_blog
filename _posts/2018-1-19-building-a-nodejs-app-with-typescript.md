---
layout: post
title:  "Building a Node.js App with Typescript"
date:   2019-1-19 10:16:00 +0800
categories: nodejs
---
Follow this guide step by step:
1. Generate a new Node.js project by `npm init`
1. Install Typescript globally by `npm install typescript -g`
1. Install `tsc` globally by `npm install tsc -g`
1. Install dependencies
```shell
npm install @types/mocha --save-dev
npm install @types/node --save-dev
npm install mocha --save
```
1. Add `tsconfig.json` to the root directory of project
```json
{
	"compilerOptions": {
		"target": "es6",
		"module": "commonjs",
		"outDir": "dist",
		"sourceMap": true
	},
	"files": [
		"./node_modules/@types/mocha/index.d.ts",
		"./node_modules/@types/node/index.d.ts"
	],
	"include": [
		"src/**/*.ts"
	],
	"exclude": [
		"node_modules"
	]
}
```

> __NOTATION__
> If you are working in VSCode, you should be sure that `typescript.tsdk` is set to the right path that the right version typescript you want to use is there.

References:
- [Building a Node.js App with TypeScript Tutorial](https://blog.risingstack.com/building-a-node-js-app-with-typescript-tutorial/)
- [How do I use TypeScript 1.6 with Visual Studio Code to get generators support?](https://stackoverflow.com/questions/32380131/how-do-i-use-typescript-1-6-with-visual-studio-code-to-get-generators-support)