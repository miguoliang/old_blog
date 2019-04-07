---
layout: post
title:  "Tips to Angular SEO"
date:   2019-4-7 19:31:00 +0800
categories: seo tips angular
---
## Angular

- Server Side Rendering (SSR) is necessary.
- A isolated build config for SEO.
- Set build parameter `extractCss` to `false`.
- Use `ng-lazyload-image`.

## Work with App or other websites

- [Google Digital Asset Links](https://developers.google.com/digital-asset-links/v1/getting-started), `Googlebot` try to get `/.well-known/assetlinks.json`.

## Nginx

- `http2` & `ssl` module are neccessary.
- `proxy_cache` is neccessary.