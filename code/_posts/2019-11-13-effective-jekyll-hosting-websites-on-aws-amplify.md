---
layout: post
title: "Effective Jekyll: Hosting Websites on AWS Amplify"
description: This article is a guide help you host your static website on AWS Amplify
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

4. Verify your website online.

    For now, AWS Amplify will compile and deploy your website to the remote. People can trace the workflow by the following guide.

    1. Click your app's name on the left navigation.

        ![Click your app's name](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-4-1.jpg)

    2. Get the progress of the latest job.

        ![Get the progress of the latest job](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-4-2.jpg)

        **Notes here**

        *There are 4 steps in AWS Amplify Continous Integration Workflow as the above screenshot presents.*

        * **Provision**: AWS Amplify are provisioning a build environment with a Docker image for your website.
        * **Build**: AWS Amplify are building your website source code.
        * **Deploy**: AWS Amplify are deploying your website to remote.
        * **Verify**: AWS Amplify are verifying its deployment to ensure your website are accessible.

        *When **Build** fails, you need to review your code.*

    3. Check the final appearance of your website.

        Click the **Verify** icon to for more details.

        ![Verify details](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-4-3-1.jpg)

        * **Domain**: You can access your website by this domain, AWS Amplify assign a secondary domain for you by default, and you can use your custom domain instead. By reading [AWS Amplify: Custom Domain Management](/aws-amplify-custom-domain-management) to learn how to do that.
        * **Start at**: When the workflow worked.
        * **Build duration**: How long the workflow takes.
        * **Source repository**: Where AWS Amplify fetch your source code from, the tail of the URL is which the branch you specified.
        * **Last commit message**: The last commit message on the branch.

        AWS Amplify also presents screenshots on several popular devices, such as Google Pixcel, iPad Air 2, iPhone 7 Plus, iPhone 8, and Samsung S7, on the **Verify** tab at the bottom of the detail page like this.

        ![Screenshots](/assets/2019-11-13-effective-jekyll-hosting-websites-on-aws-amplify/step-4-3-1.jpg)

## Conclusion

AWS Amplify provides a deep customized continous integration workflow and production deployment environment. AWS Amplify can integrate with other AWS services easily, and be friendly with most of popular 3rd party platform and services, such as Github, GitLab, BitBucket, and so on.
