---
layout: post
title:  "How to Manage Posts and Assets Productively in Jekyll"
date:   2019-11-08 19:31:00 +0800
categories:
    - code
---

![How to Manage Posts and Assets Productively in Jekyll](/assets/2019-11-8-how-to-manage-posts-and-assets-productively-in-jekyll/banner.jpg)

## Introduction

This article talks about how to build a productive directory structure to manage posts and pages smoothly and productively.

### Brief introduction to Jekyll

Jekyll is a widely used static website generator, and it supports Markdown and HTML by default. So developers use Jekyll to build their blogs and project official website.

On the other hand, Github Pages is a free service that supports Jekyll deployment automatically.

Jekyll community is active, and there are more and more plugins and themes can be used. So Jekyll is really a good choice for developers to maintain and develop a propersal website.

### Why we need to talk about this topic in Jekyll

Because Jekyll is simple and flexible, and without backend, database and workbench user interface. So how to manage your hundreds of articles and pages is an important topic for users who want to work with Jekyll smoothly and productively.

## Comprehend the Default Directory Structure

When we create a new website by the command `jekyll new demo-website`, several directories and files are created on your disk, and directory structure looks like this:

![Default Directory Structure](/assets/2019-11-8-how-to-build-a-productive-directory-structure-in-jekyll/default-directory-structure.jpg)

- *_posts* storages your articles.
-*_config.yml* is the global configuration file of Jekyll.
-*.gitignore* controls which directories or files should be out of version control in your git repository.
-*404.html* is the 404 page, which is default page when the URL is not found.
-*about.md* is the About page of your website.
-*Gemfile* is used for describing gem dependencies for Ruby programs.
-*Gemfile.lock* specifies exact versions of the third-party code you depend on in your Gemfile would not provide the same guarantee, because gems usually declare a range of versions for their dependencies.
-*index.md* is the Homepage of your website, and it is the list of your posts by default.

## Create the Assets Folder

Create a folder to storage all pictures, videos, javascripts and so on. The folder is always called `assets`, and we run the command `mkdir assets` in the website root directory to create it.

## The Flow to Create A New Post

Create a new markdown file in the `_posts` folder, and then create a new folder with the same name as the filename of the post. All your pictures should be placed in the corresponding assets folder. For example, you have a post file like `2019-11-8-how-to-manage-posts-and-assets-productively-in-jekyll.md`, and you should also have a folder in the `assets` folder like `2019-11-8-how-to-manage-posts-and-assets-productively-in-jekyll`.

The final directory structure looks like this:

![Final Directory Structure](/assets/2019-11-8-how-to-manage-posts-and-assets-productively-in-jekyll/final-directory-structure.jpg)

## Conclusion

Put pictures and videos in a isolated folder can help you find and update them easily in the future. To keep the name of folder same as the corresponding post file can shrink your searching regions.