---
layout: post
title: Create Restful APIs with Python in One Minute
description:
image: /assets/2021-04-20-create-restful-apis-with-python-in-one-minute/banner.jpg
categories:
    - code
tags:
    - python
---

## Introduction

Create Restful APIs in minutes is important when an idea flash in your brain. These APIs maybe not strong or stable, but meaningful to test your greate ideas.

Now, let's do that in Flask!

> You can download full source code in my github [here](https://github.com/miguoliang/tutorial-python-flask)

## Create a Python project (Python3 here)

1. Make a folder named *flask* and enter it
1. Create a virtual environment for your python project, by running command `python3 -m venv .` in your prompt
1. Active the virtual envrionment by `source ./bin/activate`

By now, the command should look like below:
![venv activated](/assets/2021-04-20-create-restful-apis-with-python-in-one-minute/venv.jpg)

## Install Flask as dependency

Run `pip3 install flask` in your prompt

## Create app.py and write your code

By now, the file name must be **app.py**, because we will start the program by Flask cli. Flask cli will load app.py by default.

Copy and paste codes as below:

```python
from flask import Flask, request

app = Flask(__name__)


@app.route("/", methods=["GET"])
def get_index():
    return "Hello World"


@app.route("/", methods=["POST"])
def post_index():
    d = request.json
    s = d['keyword']
    if s != None:
        return "Your keyword is {0}".format(s)
    else:
        return "I need your keyword"

```

## Start up the tiny server

Run `python3 main.py` in your prompt, and it should look like:

![Run](assets/2021-04-20-create-restful-apis-with-python-in-one-minute/run.jpg)

## Test your GET API

Open the URL <http://localhost:5000> in your browser, e.g. Chrome, and you will get a line on your screen.

![Browser](assets/2021-04-20-create-restful-apis-with-python-in-one-minute/browser.jpg)

## Test your POST API (with JSON)

Open Postman, and send a new POST request with a JSON body:

![Postman](assets/2021-04-20-create-restful-apis-with-python-in-one-minute/postman.jpg)

## Conclusion

So easy! Python ecosystem is productive, by now, you can write much more logic on the tiny server to test your idea!
