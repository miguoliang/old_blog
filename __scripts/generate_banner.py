from PIL import Image, ImageDraw, ImageFont
import math
import argparse
from datetime import date
import re


def get_lines(expected_line_number, text):
    text = str(text)
    words = text.split(' ')
    max_char_number = math.ceil(len(text) / expected_line_number)
    lines = []
    line = ''
    for word in words:
        if len((line + ' ' + word).strip()) <= max_char_number:
            line = (line + ' ' + word).strip()
        else:
            lines.append(line.strip())
            line = word
    if len(line) > 0:
        lines.append(line)
    if len(lines) > expected_line_number:
        for i in range(expected_line_number, len(lines)):
            lines[expected_line_number -
                  1] = (lines[expected_line_number - 1] + ' ' + lines.pop()).strip()
    return lines


def get_font_size(lines, font_size):
    fnt = ImageFont.truetype('arial.ttf', font_size)
    fnt_sizes = []
    for ln in lines:
        fnt_sizes.append(fnt.getsize(ln))
    size = [0, 0]
    for sz in fnt_sizes:
        size[0] = max(size[0], sz[0])
        size[1] += sz[1]
    return size, fnt_sizes


def draw_image(new_img, text, fgColor):
    text = str(text)
    draw = ImageDraw.Draw(new_img)
    img_size = new_img.size

    expected_line_number = 1
    font_size = 64
    lines = get_lines(expected_line_number, text)
    fnt_sizes = []
    fnt_size, fnt_sizes = get_font_size(lines, font_size)
    while fnt_size[0] > img_size[0] or fnt_size[1] > img_size[1]:
        if expected_line_number < 2:
            expected_line_number += 1
            lines = get_lines(expected_line_number, text)
        else:
            font_size -= 5
        fnt_size, fnt_sizes = get_font_size(lines, font_size)

    padding = 10
    x = (img_size[0] - fnt_sizes[0][0]) / 2
    y = (img_size[1] - fnt_size[1] - (len(fnt_sizes) - 1) * padding) / 2
    fnt = ImageFont.truetype('arial.ttf', font_size)
    offset_y = y
    draw.text((x, y), lines[0], font=fnt, fill=fgColor)
    offset_y += fnt_sizes[0][1] + padding
    print(offset_y)
    print(fnt_sizes)
    for i in range(1, len(fnt_sizes)):
        x = (img_size[0] - fnt_sizes[i][0]) / 2
        draw.text((x, offset_y), lines[i], font=fnt, fill=fgColor)
        offset_y += fnt_sizes[i][1] + padding
    del draw


def new_image(width, height, text, bgColor, fgColor):
    new_img = Image.new('RGB', (int(width), int(height)), bgColor)
    draw_image(new_img, text, fgColor)
    new_text = re.sub('\W+', '-', text).lower()
    new_img.save(r'../assets/%s-%s/banner.jpg' % (date.today().isoformat(), new_text.strip('-')))
    del new_img


def new_image_with_file(fn):
    with open(fn, encoding='utf-8') as f:
        for l in f:
            l = l.strip()
            if l:
                ls = l.split(',')
                if '#' == l[0] or len(ls) < 2:
                    continue
                new_image(*ls)


if '__main__' == __name__:
    parser = argparse.ArgumentParser()
    parser.add_argument('-t', '--text', help='Text', required=True, type=str)
    parser.add_argument('-f', '--foreground', help='Foreground Color',
                        default='white')
    parser.add_argument('-b', '--background', help='Background Color',
                        default='green')
    args = parser.parse_args()
    new_image(1200, 1200, args.text, fgColor=args.foreground, bgColor=args.background)
