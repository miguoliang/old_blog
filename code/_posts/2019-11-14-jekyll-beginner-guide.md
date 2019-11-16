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

* [Introduction](#introduction)
* [Installation](#installation)
  * [Install Jekyll on macOS](#install-jekyll-on-macos)
  * [Installation via Bash on Windows 10](#installation-via-bash-on-windows-10)
* [Start a new website](#start-a-new-website)
* [Write your first post](#write-your-first-post)
  * [Create a text only post](#create-a-text-only-post)
  * [Display an image](#display-an-image)
  * [Highlight your code](#highlight-your-code)
  * [Include a HTML file](#include-a-html-file)
* [Create a new page](#create-a-new-page)
* [Run and debug your website locally](#run-and-debug-your-website-locally)
* [Version control of your website](#version-control-of-your-website)
* [Conclusion](#conclusion)

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

Run the command `jekyll new jekyll-beginner-guide`, and a folder named `jekyll-beginner-guide` has been create in your current directory. The `jekyll-beginner-guide` folder is called the root directory of the website. You will see it many times in my blog.

Enter the root directory of the website you just created by the command `cd jekyll-beginner-guide`, and list all files and folders of the website project.

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

* **_posts**: You write blog posts as text files and save them in the **_posts** folder.
* *_config.yml*: Global options to customize hwo Jekyll builds your site.
* *.gitignore*: Specifies intentionally untracked files to ignore in Git.
* *404.html*: 404 page indicates that the user reached the domain they requested, but the URL path provided no information.
* *about.md*: About Us page provides a friendly opportunity to introduce yourself to your site’s visitors.
* *Gemfile*: A Gemfile is a file we create which is used for describing gem dependencies for Ruby programs. Jekyll is a Ruby program, so it use gem as its package manager. More details by [What is a Gemfile](https://tosbourn.com/what-is-the-gemfile/).
* *Gemfile.lock*: A Gemfile is a file we create which is used for describing gem dependencies for Ruby programs. More details by [Gemfile and Gemfile.lock in Ruby](https://medium.com/@davalpargal/gemfile-and-gemfile-lock-in-ruby-65adc918b856).
* *index.md*: The home page of your website.

## Write Your First Post

Jekyll is not only a static website generator but also a content management system. Therefore, we need to be familiar with the workflow of writing posts.

### Create a Text Only Post

1. Create a new file by the command `touch 2019-11-15-first-post.md` in the *_posts* folder.
2. Set the layout, title, and creation time of the post you just created by placing the following codes at the top.

    ```text
    ---
    layout: post
    title: "My First Post"
    date: 2019-11-15 08:00:00 +08:00
    ---
    ```

    **Notes here**:

    *This section is called **front matter** which is typically used to set a layout or other meta data.*

3. Write words in this post after the front matter, it looks like this:

    ```markdown

    ## Hello Jekyll

    This is my first Jekyll post! Cool~~~~

    ```

    **Notes here**:

    *Do not use `Head 1` style in your markdown format post, because of the title in the front matter will be wrapped with `<h1>` in the final HTML. Up to only one `<h1>` element can appear in your final HTML page, otherwise the page is harmful to SEO.*

### Display an image

I recommend you reading [Effective Jekyll Content Management: Image Assets in Posts](/assets/2019-11-8-effective-jekyll-content-management-image-assets-in-posts) to learn the solution to manage a large number of posts and their images clearly and effectively in Jekyll. The following steps are a practice to the solution.

1. Create an image assets folder by the command `mkdir -p assets/2019-11-15-first-post` in the root of your website.
2. Download an image from the Internet and save it to the image assets folder you just created. Suppose the image file name is `my-house.jpg`.
3. Append codes to the post you just created.

    ```markdown
    ![This is my house](/assets/2019-11-15-first-post/my-house.jpg)
    ```

### Highlight your code

If you are a developer, and you want to share codes on your website, the code highlight feature is necessary. You can use the code highlight feature easily in markdown.

Suppose you want to share Java codes in the post you just created.

{% highlight markdown %}

```java
public class Product {
    public Product() {
        System.out.println("I am a product");
    }
}
```

{% endhighlight %}

And then, these codes looks like this in the final result:

```java
public class Product {
    public Product() {
        System.out.println("I am a product");
    }
}
```

### Include a HTML file

We also can include a HTML file into the post we just created by the Liquid syntax {% raw %}`{%- include file-name.html -%}`{% endraw %}. This feature is useful for reusing codes. For example, you can create a component in a HTML file, and reuse it any where by just including the same file.

1. Create the `_include` folder in the root directory of your website.
2. Create a HTML file in the `_include` folder. Suppose its name is `a-component.html`.
3. Append following codes into `a-component.html`.

    ```html
    <p>I am a component!</p>
    ```

    **Notes here**

    * No front matter required.
    * Code in this file will replace the include command in your posts or pages, so it is not a complete HTML program. Usually, it does not contain `<html>`, `<head>`, and `<body>` tags.

4. Include `a-component.html` in your post.

    ```html
    {% raw %}
    {%- include a-component.html -%}
    {% endraw %}
    ```

## Create a new page

Pages are different with posts in a website. Posts are for timely content. They have a publish date and are displayed in reverse chronological order on your blog page. They're what you should think of when you hear the term "blog post". Pages are for static, timeless content.

1. Create a markdown file in the root directory of your website. Suppose its file name is `contact.md`.
2. Set the layout, permalink, and title of the page you just created by placing the following codes at the top.

    ```text
    ---
    layout: default
    title: "Contact Me"
    permalink: /contact.html
    ---
    ```

3. Typing serveral words in this page.

    ```markdown
    E-mail: miguoliang@hotmail.com

    Twitter: miguoliang
    ```

    **Notes that**

    *Generally, each page should have its unique static link.*

    *A "Contact Me" link will appears on the top right of the page when you run the website locally.*

    ![Contact Me Entrance](/assets/2019-11-14-jekyll-beginner-guide/contact-us-entrance.jpg)

## Run and debug your website locally

Run the command `jekyll serve` in the root directory of your website.

Open the url `http://localhost:4000/2019/11/14/jekyll-beginner-guide` in your browser.

When you save your changes on posts or pages, Jekyll recompiles your website instantly. Refresh the page in browser to check latest changes.

![Final Result](/assets/2019-11-14-jekyll-beginner-guide/post-entrance.jpg)

## Version control of your website

Suppose you created an empty remote repository on Github.

1. Initialize an empty repository in the root of your website.

    ```shell
    git init
    ```

2. Commit all changes to the local repository.

    ```shell
    git add .gitignore # .gitignore is ommited by default because it is a hidden file, so you need add it to changes mannually.
    git commit -m'init' -a
    ```

3. Add Remote URL to the local repository.

    ```shell
    git remote add origin remote <Repository URL> # Sets the new remote
    ```

4. Push to the remote.

    ```shell
    git push -u origin master
    ```

*Before push the local repository to the remote, you need to be sure that changes have been committed to your local repository.*

*You can download the source code of the demo from my GitHub. <https://github.com/miguoliang/jekyll-beginner-guide.git>*

## Conclusion

Jekyll is powerful and flexible to build a static website. This article describes a simple workflow to Jekyll, and some basic features only.
