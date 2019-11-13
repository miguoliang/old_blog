---
layout: post
title:  "Effective Jekyll Content Management: Image Assets in Posts"
date:   2019-11-08 19:31:00 +0800
description: How to effective manage image assets in posts in Jekyll.
image: /assets/2019-11-8-effective-jekyll-content-management-image-assets-in-posts/banner.jpg
categories:
    - code
---

## Introduction

Jekyll is a leading solution to build static websites. You write blog posts as text files, and store image assets in the `assets` folder. How to effective manage a large number of posts and their images is a critical problem. I will show you the right solution in this article.

## From A to Z

1. Create a new website by the command `jekyll new effective-jekyll`, and a basic content management system is just built. This content management system is based on file system, not database, so you need to manage your content like files.
2. Create the assets folder to store images by the command `mkdir assets` in the root directory of the website.
3. Create a text file by the command `touch 2019-11-8-image-assets-in-posts.md` in the *_posts* directory.
4. Create a new folder named `2019-11-8-image-assets-in-posts` in the assets directory to store images in the post you just created.
5. Download an image from the internet and save it in the assets folder you just created. Suppose the image file is named `image-assets-in-posts.jpg`.
6. Append the below lines into `2019-11-8-image-assets-in-posts.md` and save changes.

    ```text
    ---
    layout: post
    title:  "Hello World"
    date:   2019-11-8 18:00:00 +0800
    ---
    ![Hello World](/assets/2019-11-8-hello-world/hello-world.jpg)
    ```

7. Run the command `jekyll serve` in the root directory of your website to generate and run the website.
8. Open `http://localhost:4000/2019/11/08/image-assets-in-posts.html` in your browser to check your website locally.

The final screenshot on your website should like this:

![Final Screenshot](/assets/2019-11-8-effective-jekyll-content-management-image-assets-in-posts/final-screenshot.jpg)

But the most important result of the solution is the directory structure of your website, and it looks like this:

![Final Directory Structure](/assets/2019-11-8-effective-jekyll-content-management-image-assets-in-posts/final-directory-structure.jpg)

*You can download the source code of the demo from my GitHub. <https://github.com/miguoliang/effective-jekyll.git>*

## Conclusion

Each article has a corresponding image folder under the assets folder. This solution make the image assets management effective and clear. When you want to change images in some article, you can find them quickly. No matter what how many files in your content management system， you won't confuse posts and their images.
