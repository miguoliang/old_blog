---
layout: post
title: How to crop an image into multiple sizes in the command line
description: This article talks about how to an image into multiple sizes in the command line.
image: /assets/2020-1-3-how-to-crop-an-image-into-multiple-sizes-in-the-command-line/banner.jpg
date: 2020-01-30 00:00:00 +08:00:00
categories:
    - code
tags:
    - image processing
---

## Introduction

When I do SEO for my blog you are visiting, I need to crop images into multiple SEO friendly sizes manually. It costs much time, so I developed a script instead of manual actions, and this script can process all images in the same directory.

## 1. Install Converter

What is **Converter**? **Converter** is one of the tools in the **ImageMagick**. I use **Converter** to process images in the command line.

I suppose you are using macOS and Homebrew, and you can run `brew install imagemagick` in your prompt.

## 2. Create a Shell script file

Run command `touch crop.sh` in your prompt, and add following codes into *crop.sh*.

```shell
#!/usr/bin/bash

convert $1 -resize 1200x1200^ $1

## NOTICE: -gravity is MUST before -crop, otherwise -gravity is ignored
convert $1 -gravity center -crop 1200x1200+0+0 $1
```

This script do two things to a specified image:

1. Resize the image based on the smallest fitting dimension. That is, the image is resized to completely fill (and even overflow) the pixel area given. In this case, the height of the resized image is 1,200 pixel height.
2. Corp a 1200x1200 area from the center of the resized image.

## 3. Grant execution permission to the script

Run command `sudo u+x crop.sh` in your prompt.

## 4. Verify the script

Run command `./crop.sh filename.jpg`, and the filename will be overwrited.

## Conclusion

I developed scripts to resize and crop images into specified sizes to satisify the Google Image specifications. So you can find scripts in [the Github repository of my blog](https://github.com/miguoliang/miguoliang.github.io.git).
