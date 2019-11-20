---
layout: post
title: "Effective Jekyll: Hosting Websites on AWS Amplify"
description: "Effective Jekyll: Hosting Websites on AWS Amplify"
date: 2019-11-13 00:00:00 +08:00
image: /assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/banner.jpg
categories:
    - code
---

## Introduction

AWS Amplify is an easy to use and powerful solution to deploy static websites. People can deploy their websites and deliver features faster on AWS Amplify.

AWS Amplify is a security, stable, serverless, and scalable deployment solution, so people need not to manage servers themself at all. For a small size and traffic website, AWS Amplify is free.

AWS Amplify is a continuous integration too. AWS Amplify connects to your source code, and compile your source code, and deploy the artifact to the destination automatically, so what the only thing people need to focus is their website source code only.

People can custom their AWS Amplify in the AWS Amplify Console. Settings of AWS Amplify contains domain management, email notification, build settings, access control, access log, and rewrites and redirects.

## Step by Step

1. Create and Login your AWS account. *If you don't have an AWS account, follow the AWS official guide to [Create and activate a new Amazon Web Services account](https://aws.amazon.com/premiumsupport/knowledge-center/create-and-activate-aws-account/?nc1=h_ls)*

2. Find and enter the AWS Amplify Console.

    When you login your AWS account, you can find the entrance of the AWS Amplify Console by typing its name in the input box of the AWS Management Console like this.

    ![Find and enter the AWS Amplify Console](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-2.jpg)

    **Notes here**

    *AWS Amplify is available on the most of, but not all of the regions in AWS.*

3. Connect your app with AWS Amplify.

    1. Find and press **Connect app** on the top right of the Apmlify Console Homepage like this.

        ![Connect app with AWS Amplify](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-3-1.jpg)

    2. Select a Git provider which you host your website source code on, then press **Continue** on the bottom right of the page.

        ![Select a Git provider](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-3-2.jpg)

    3. Select your website repository and branch, then press **Next** on the bottom right of the page.

        ![Select your website repository](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-3-3.jpg)

    4. Confirm the build settings, and use default here, then press **Next** on the bottom right of the page.

        AWS Amplify can auto-detect your website's build settings, what you need to do is just ensure your build command and output folder are correctly detected.

        ![Confirm the build settings](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-3-4.jpg)

        **Notes here**

        *By default, the build command to a Jekyll website is `bundle exec jekyll b`, it is good in development environment, but not good in the production environment, because developers always use environment variables to distinguish the build environment in the source code. More about this topic by reading [How to build in production](/tips-aws-amplify-settings-static-website#build-in-production)*

    5. Review and deploy your website by pressing **Save and deploy**.

        ![Review and deploy your website](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-3-5.jpg)

## Conclution
