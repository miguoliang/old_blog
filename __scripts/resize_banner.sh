#!/usr/bin/bash

# 将最短变缩为 1200 像素同时保持整体比例
convert $1 -resize 1200x1200^ $1

# 此处要注意，gravity 参数要写在 crop 的前面，否则无效
convert $1 -gravity center -crop 1200x1200+0+0 $1
