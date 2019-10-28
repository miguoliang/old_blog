---
layout: post
title:  "Change and Add Remote URLs for a Local Existing Git Repository"
date:   2019-10-25 19:22:27 +0800
categories: code
---

![Change and Add Remote URLs for a Local Existing Git Repository](/assets/2019-10-25-change-add-remote-urls-git-repository/banner.jpg)

This article talks how to change/add remote URLs for a local exisiting git repository. It is very useful and powerful to managing our code on complex source control requirments.

## Change the Remote URLs

Sometimes we need to change an existing project from one remote repository/provider to a new one in local. The most easy way to do that is change the remote URLs of the exisiting project to the new remote URLs.

For example, sometimes we have migrated our code from Bitbucket to GitHub (or verse), and then we need change our local git repository remote URL to the new one to ensure that we can fetch and push to the new remote repository in the future.

So we can get it step by step as below:

### 1\. Check the Current Remote URLs

```shell
$ git remote -v
origin  git@github.com:USERNAME/REPOSITORY.git (fetch)
origin  git@github.com:USERNAME/REPOSITORY.git (push)
```

### 2\. Change the Remote URLs

```shell
git remote set-url origin https://github.com/USERNAME/REPOSITORY.git
```

### 3\. Verify the Remote URLs

```shell
$ git remote -v
origin https://github.com/USERNAME/REPOSITORY.git (fetch)
origin https://github.com/USERNAME/REPOSITORY.git (push)
```

## Add An Another Remote URL

Additinally, sometimes we have a mirror git repository on the remote, and we want to push to the both repositories at the same time.

So we can get it step by step as below:

```shell
git remote set-url --add origin <another-url>
```

The `--add` parameter means that we will add a new remote URL to the local repository.

Let us check the final Remote URLs

```shell
$ git remote -v
origin https://github.com/USERNAME/REPOSITORY.git (fetch)
origin https://github.com/USERNAME/REPOSITORY.git (push)
origin <another-url> (push)
```

Well done, but notice outputs that the third line is the another push destination, but no another fetch url is added. Because git only allow one fetch resource to keep the consistency.
