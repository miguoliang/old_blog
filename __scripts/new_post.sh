#!/usr/bin/bash

## 当前日期
TODAY=`date +%Y-%m-%d`

## 将空格转化成减号
TITLE=`echo $2 | tr '[A-Z]' '[a-z]' | sed 's/ /-/g'`

## 按照空格分割并转化成数组
WORDS=($2)

## 创建模版文件
echo "---
layout: post
title: "$2"
description:
image: /assets/$TODAY-$TITLE/banner.jpg
categories:
    - $1
tags:
    -
---
" > "$1/_posts/$TODAY-$TITLE.md"

## 创建图片目录
mkdir -p "assets/$TODAY-$TITLE"

## 生成图片
# magick -size 1200x1200 -background green -fill white -gravity center -font __scripts/arial.ttf label:"$2" "assets/$TODAY-$TITLE/banner.jpg"
cd __scripts
python3 generate_banner.py -t "$2" -f "$3" -b "$4"
cd -