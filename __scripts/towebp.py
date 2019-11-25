#!/usr/bin/python3

## Run command like this:
## ls -d assets/*/* | xargs -t -I {} python3 __scripts/towebp.py --key=*key* --file={}

import Image
import argparse

parser = argparse.ArgumentParser(prog='towebp', description='Convert JPG and PNG to WebP')
parser.add_argument('--file', type=str, required=True, help='Source File')
args = parser.parse_args()

im = Image.open(args.file)
Image.save(args.source + '.webp')
