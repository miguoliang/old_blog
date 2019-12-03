---
layout: post
title: 4 Tips to AWS Amplify Settings to Websites
description: 4 Tips to AWS Amplify Settings to Websites
image: /assets/2019-11-20-tips-aws-amplify-settings-static-website/banner.jpg
date: 2019-11-20 00:00:00 +08:00
categories:
  - code
tags:
  - aws amplify
---

## Introduction

AWS Amplify is an easy to use and powerful app hosting solution. AWS Amplify defines a workflow to deployment integration with flexible and automatic resource management.

*For a quick learn from a tiny project by reading [Effective Jekyll: Hosting Websites on AWS Amplify](/effective-jekyll-hosting-websites-on-aws-amplify).*

*For a quick compare Github Pages and AWS Amplify on hosting static webistes by reading [Effective Jekyll: AWS Amplify vs Github Pages](/effective-jekyll-aws-amplify-vs-github-pages).*

Tips in practice but not mentioned in its official documents helps you work more efficiently.

Suppose you have a AWS account, or you can follow the AWS official guide to [Create and activate a new Amazon Web Services account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/?nc1=h_ls).

## Table of Contents

* [Return 404 Status Code for 404 Page](#return-404-status-code-for-404-page)
* [Use Environment Variable JEKYLL_ENV in Production](#use-environment-variables-jekyll_env-in-production)
* [Remove Github Pages Plugin in Gemfile](#remove-github-pages-plugin-in-Gemfile)
* [Correct Redirect Settings](#correct-redirect-settings)

## Return 404 Status Code for 404 Page

1. Edit your *Rewrites and redirects* settings.

    ![Edit Rewrites and redirects](/assets/2019-11-20-tips-aws-amplify-settings-static-website/tips-1-1.jpg)

2. Change the Type of your 404 route to `404(Rewrite)`.

    ![Change to 404(Rewrite)](/assets/2019-11-20-tips-aws-amplify-settings-static-website/tips-1-2.jpg)

    **Notes here**

    *The type of your 404 route is set to `404(Redirect)` by default in AWS Amplify, so you need to change it to `404(Rewrite)` manually.*

## Use Environment Variable JEKYLL_ENV in Production

People want some code running in production only, but not in development, for example, people only want to include `google-analytics.html` and `google-adsense.html` in production environment to avoid dirty data when they are debugging.

```html
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  {% raw %}
  {%- seo -%}
  <link rel="stylesheet" href="{{ "/assets/main.css" | relative_url }}">
  {%- feed_meta -%}
  {%- if jekyll.environment == 'production' -%}
    {%- include google-analytics.html -%}
    {%- include google-adsense.html -%}
  {%- endif -%}
  {% endraw %}
</head>
```

The key line is:

`{% raw %}{%- if jekyll.environment == 'production' -%}{% endraw %}`

This line means the following codes will be compiled the environment variable `JEKYLL_ENV` is set to *production* only. As the Jekyll official document says, the `jekyll.environment` is set to *development* by default. So if you want to build in production mode, you need to set the environment variable `JEKYLL_ENV` to *production* before you run the build command like this.

![Set environment variables for your build](/assets/2019-11-20-tips-aws-amplify-settings-static-website/tips-2.jpg)

Save and deploy your again, then it works.

***Notes here:*** *`JEKYLL_ENV=production` must lead the command, otherwise the build command can not read `JEKYLL_ENV`*.

## Remove Github Pages Plugin in Gemfile

Github Pages Plugin is always started in safe mode and the `plugin_dir` is a random string. So your plugins in `plugin-dir` will be never loaded.

Remove Github Pages Plugin in Gemfile:

```gemfile
# If you want to use GitHub Pages, remove the "gem "jekyll"" above and
# uncomment the line below. To upgrade, run `bundle update github-pages`.
# gem "github-pages", group: :jekyll_plugins
```

***Notes here***: *No warning or information when Jekyll is running in safe mode, so people always waste much time here.*

## Correct Redirect Settings

People need to redirect requests in two scenarios:

* **Redirect to the only main domain**: A website has only one domain, e.g. www.miguoliang.com is the main domain of my blog, and miguoliang.com redirects to www.miguoliang.com permanently. People need to redirect request to the main domain permanently, otherwise:
  
  * Search Engine will be confused when it crawls your website, because it found there was a same page in its database.
  * If you redirects request not permanently, just temporary, your website will get a low speed on opening. Because it will take much more time on multi redirects.

* **Redirect HTTP to HTTPS**: Hypertext Transfer Protocol Secure (HTTPS) is an extension of the Hypertext Transfer Protocol (HTTP). It is used for secure communication over a computer network, and is widely used on the Internet. People need to redirect HTTP request to HTTPS, not only because of security, but also because of SEO.

People need to correct their redirect settings like this:

![Correct Redirect Settings](/assets/2019-11-20-tips-aws-amplify-settings-static-website/tips-4.jpg)
