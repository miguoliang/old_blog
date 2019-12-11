#!/usr/bin/sh

rm assets/**/banner_4x3.jpg
rm assets/**/banner_16x9.jpg
rm assets/**/*.webp

ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg -gravity center -crop 1200x675+0+0 {}_16x9.jpg
ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg  -gravity center -crop 1200x900+0+0 {}_4x3.jpg

## 将 JPG 转换为 WebP 格式，同时保留原 JPG，保真度 80%
ls assets/**/*.jpg | xargs -t -I {} cwebp -q 80 {} -o {}.webp