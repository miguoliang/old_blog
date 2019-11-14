---
layout: post
title: A Beginner's Guide on Jekyll
description: Quickly learn the basics of Jekyll.
date: 2019-11-14 00:00:00 +08:00
image: /assets/2019-11-14-jekyll-beginner-guide/banner.png
---

The purpose of writing this guide is to enable the reader to quickly learn the basics of Jekyll in order to understand the relevant content in other posts. So this guide is not a complete guide for Jekyll, but a quick start manual. This guide only covers the knowledge that may be used in my blog.

*You can kown Jekyll completely by [Jekyll official website](https://jekyllrb.com/)*.

## Table of Contents

* Introduction
* Installation
  * Install Jekyll on macOS
  * Installation via Bash on Windows 10
* Start a new website
* Write your first post
  * Display an image
  * Highlight your code
  * Include a HTML file
* Create a new page
* Run and debug your website locally
* Version control of your website
* Conclusion

## Introduction

Jekyll is an excellent and accessible static website generator. People use Jekyll to create their websites and blogs. More and more static web hosting services have appeared on the Internet, such as Github Pages, AWS Amplify, and so on.

Jekyll saves blog posts as text files. Therefore Jekyll is a file system based content management system. Jekyll does not have a database, a backend application, and a dashboard user interface. What you need to manage your content is only the text editor you like the most.

Jekyll is light and easy to use. Jekyll has an active and massive community on the Internet. You can find many beautiful themes and powerful plugins for Jekyll easily.

*For more detailed introduction, please refer to [Jekyll official website](https://jekyllrb.com/).

## Installation

Jekyll can run on Windows and macOS. The installation of Jekyll is easy. The installation guide is a streamlined version of the official installation guide. It only contains installation workflows in the mainstream environment.

### Install Jekyll on macOS

1. Install Command Line Tools.

    ```shell
    xcode-select --install
    ```

2. Install Ruby with Homebrew.

    ```shell
    # Install Homebrew
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    # Install Ruby
    brew install ruby
    ```

3. Install Bundler and Jekyll.

    ```shell
    gem install --user-install bundler jekyll
    ```

4. Check your Ruby version.

    ```shell
    $ ruby -v
    ruby 2.6.0p0 (2018-12-25 revision 66547) [x86_64-darwin18]
    ```

**That's it!**

### Installation via Bash on Windows 10

If you are using Windows 10 version 1607 or later, another option to run Jekyll is by [installing](https://docs.microsoft.com/zh-cn/windows/wsl/install-win10?redirectedfrom=MSDN) the Windows Subsystem for Linux.

Note: You must have [Windows Subsystem for Linux](https://docs.microsoft.com/zh-cn/windows/wsl/about?redirectedfrom=MSDN) enabled.

1. Make sure all packages/repositories are up to date.

    ```shell
    bash
    ```

2. Update repo lists.

    ```shell
    sudo apt-get update -y && sudo apt-get upgrade -y
    ```

3. Install Ruby from [BrightBox repository](https://www.brightbox.com/docs/ruby/ubuntu/).

    ```shell
    sudo apt-add-repository ppa:brightbox/ruby-ng
    sudo apt-get update
    sudo apt-get install ruby2.5 ruby2.5-dev build-essential dh-autoreconf
    ```

4. Update Ruby gems.

    ```shell
    gem update
    ```

5. Install Bundler and Jekyll

    ```shell
    gem install jekyll bundler
    ```

6. Check if Jekyll installed properly by running:

    ```shell
    $ jekyll -v
    jekyll 3.7.4
    ```

**That's it!**

## Start a new website

Run the command `jekyll new effective-jekyll`, and a folder named `effective-jekyll` has been create in your current directory. The `effective-jekyll` folder is called the root directory of the website. You will see it many times in my blog.

Enter the root directory of the website you just created by the command `cd effective-jekyll`, and list all files and folders of the website project.

```shell
$ ls -l
_posts
_config.yml
.gitignore
404.html
about.md
Gemfile
Gemfile.lock
index.md
```

The meaning of each file or directory is:

* **_posts**:
* *_config.yml*:
* *.gitignore*:
* *404.html*:
* *about.md*:
* *Gemfile*:
* *Gemfile.lock*:
* *index.md*:
