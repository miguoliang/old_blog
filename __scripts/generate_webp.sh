#!/usr/bin/sh

rm assets/**/*-4x3.jpg
rm assets/**/*-16x9.jpg
rm assets/**/*-19x10.jpg
rm assets/**/*-2x1.jpg
rm assets/**/*.webp

## 生成 Google AMP 所需的 16:9 和 4:3 尺寸
ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg -gravity center -crop 1200x675+0+0 {}-16x9.jpg
ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg  -gravity center -crop 1200x900+0+0 {}-4x3.jpg

## 生成 Facebook Open Graph 所需图片
ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg  -gravity center -crop 1200x630+0+0 {}-19x10.jpg

## 生成 Twitter 所需 2:1 版本图片
ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg  -gravity center -crop 1200x630+0+0 {}-2x1.jpg

## 非多尺寸兼容图 JPG 转换为 WebP 格式，同时保留原 JPG，保真度 80%
ls assets/**/*.jpg | xargs -t -I {} cwebp -q 80 {} -o {}.webp