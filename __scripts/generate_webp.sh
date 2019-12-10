#!/usr/bin/sh

rm assets/**/banner_1x1.jpg
rm assets/**/banner_4x3.jpg
rm assets/**/banner_16x9.jpg
rm assets/**/banner.jpg.webp

# ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}.jpg -resize 1200x1200! {}_1x1.jpg
# ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}_1x1.jpg -crop 1200x675+0+262.5 -gravity center {}_16x9.jpg
# ls assets/**/banner.jpg | awk -F. '{print $1}' | xargs -t -I {} convert {}_1x1.jpg -crop 1200x900+0+150 -gravity center {}_4x3.jpg

## 将 JPG 转换为 WebP 格式，同时保留原 JPG，保真度 80%
# ls assets/**/*.jpg | xargs -t -I {} cwebp -q 80 {} -o {}.webp