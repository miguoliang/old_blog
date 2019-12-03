#!/usr/bin/sh

ls assets/**/*.jpg | xargs -t -I {} cwebp -q 80 {} -o {}.webp