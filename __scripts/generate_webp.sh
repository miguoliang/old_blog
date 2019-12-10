#!/usr/bin/sh

ls assets/**/banner.jpg | xargs -t -I {} convert {} -resize 1200x1200! {}_1x1.jpg

## 将 JPG 转换为 WebP 格式，同时保留原 JPG，保真度 80%
ls assets/**/*.jpg | xargs -t -I {} cwebp -q 80 {} -o {}.webp