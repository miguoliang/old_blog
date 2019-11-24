#!/usr/bin/python3

## Run command like this:
## ls -d assets/*/* | xargs -t -I {} python3 __scripts/tinypng.py --key=*key* --file={}

import tinify
import argparse

parser = argparse.ArgumentParser(prog='tinypng', description='Compress JPG, PNG by TinyPNG.com')
parser.add_argument('--key', type=str, required=True, help='Developer API Key')
parser.add_argument('--file', type=str, required=True, help='File')
args = parser.parse_args()

tinify.key = args.key

source = tinify.from_file(args.file)
source.to_file(args.file)
