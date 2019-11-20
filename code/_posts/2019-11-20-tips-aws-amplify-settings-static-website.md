---
layout: post
title: 1 Tips to AWS Amplify Settings to Websites
description: 1 Tips to AWS Amplify Settings to Websites
image: /assets/2019-11-20-tips-aws-amplify-settings-static-website/banner.jpg
date: 2019-11-20 00:00:00 +08:00
categories:
    - code
---

## Introduction

AWS Amplify is an easy to use and powerful app hosting solution. AWS Amplify defines a workflow to deployment integration with flexible and automatic resource management.

*For a quick learn from a tiny project by reading [Effective Jekyll: Hosting Websites on AWS Amplify](/effective-jekyll-hosting-websites-on-github-pages).*

*For a quick compare Github Pages and AWS Amplify on hosting static webistes by reading [Effective Jekyll: AWS Amplify vs Github Pages](/effective-jekyll-aws-amplify-vs-github-pages).*

Tips in practice but not mentioned in its official documents helps you work more efficiently.

Suppose you have a AWS account, or you can follow the AWS official guide to [Create and activate a new Amazon Web Services account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/?nc1=h_ls).

## Table of Contents

* [Return 404 Status Code for 404 Page](#return-404-status-code-for-404-page)

## Return 404 Status Code for 404 Page

1. Edit your *Rewrites and redirects* settings.

    ![Edit Rewrites and redirects](/assets/2019-11-20-tips-aws-amplify-settings-static-website/tips-1-1.jpg)

2. Change the Type of your 404 route to `404(Rewrite)`.

    ![Change to 404(Rewrite)](/assets/2019-11-20-tips-aws-amplify-settings-static-website/tips-1-2.jpg)

    **Notes here**

    *The type of your 404 route is set to `404(Redirect)` by default in AWS Amplify, so you need to change it to `404(Rewrite)` manually.*
