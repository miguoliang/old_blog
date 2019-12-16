---
layout: post
title: How to Build a Mailchimp Embed Form in AMP Pages
description: Mailchimp is not AMP friendly, because CORS error occurs when you submit a form in AMP pages. So how to using both benifits of them is the ciritical content in this ariticle.
date: 2019-12-16 00:00:00 +08:00:00
image: /assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/banner.jpg
categories:
    - code
tags:
    - amp
---

## Introduction

Mailchimp is a good solution to manage the email subscription to your website. Mailchimp provide embed form, apis, and online email design tools. Mailchimp can send welcome email to your visitor when people subscribe your email list on your website. Mailchimp is free for a small website. More about Mailchimp visit its [official website](https://mailchimp.com/).

AMP is a web component framework to easily create user-first websites. AMP is a solution to speed up your website performance, and it is very friendly to Google SEO. [My website](www.miguoliang.com) what you are visiting is an AMP website. AMP is also a speicification to your HTML using, so many limitation can break your programming habits.

Mailchimp is not AMP friendly, because CORS error occurs when you submit a form in AMP pages for securities reason by Mailchimp. So how to using both benifits of them is the ciritical content in this ariticle.

## Solution

Use an AWS Lambda function as an agent to subscribe a visitor's email to Mailchimp. Mailchimp provides APIs and SDKs so that developers can custom their workflows easily and flexible.

### 1. Create a AWS Lambda function in Python 3.7

* Login to your [AWS](https://aws.amazon.com/) console.

  ![Login to your AWS](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-1.jpg)

* Open your Lambda console

  ![Open your Lambda console](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-2.jpg)

* Create a function

  * Select *Author from scratch*

    ![Select Author from scratch](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-3.jpg)

  * Enter *Function name*, we type *function* here

    ![Enter Function Name](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-4.jpg)

  * Select *Python 3.7* in *Runtime*

    ![Select Python in Runtime](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-5.jpg)

  * Press *Create function*

    ![Press Create function](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-6.jpg)

  * Change `Handler` to **function.my_handler**

    ![Change Handler](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-7.jpg)

  * Press *Add trigger*

    ![Press Add Trigger](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-8.jpg)

  * Select *API Gateway* in *Trigger configuration*

    ![Select API Gateway](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-9.jpg)

  * Select *Create a new API* in *API*

    ![Select Create a new API](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-10.jpg)

  * Press *Add*

    ![Press Add](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-1-11.jpg)

### 2. Setup Envrionment Variables to Lambda Function

For security reason, developers should seperate secrets, credentials, and passwords from source code. AWS Lambda provides environment variable settings like other famous platforms such as CircleCI, and so on.

Here, we need set Mailchimp username, api key, and list id here.

![Setup Environment Variables](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-2.jpg)

You can learn **[How to find your List ID in Mailchimp](https://www.youtube.com/watch?v=UVOWy7ipm2o)**.

### 3. Create a Python virtual envrionment

In some cases, you may need to use a virtual environment to install dependencies for your function. This can occur if your function or its dependencies have dependencies on native libraries, or if you used Homebrew to install Python.

* Create a new folder as the root directory of your project

Run command `mkdir -p aws-lambda-function; cd aws-lambda-function` to create and enter the project folder.

* Create a virtual environtment by command `python3 -m venv v-env`

* Active the environment

```shell
~/aws-lambda-function$ source v-env/bin/activate
(v-env) ~/aws-lambda-function$
```

### 4. Install Dependencies

* Install Mailchimp v3 SDK by command `pip3 install mailchimp3`.

* Install Toolbelt by command `pip3 install requests_toolbelt`, we use Toolbelt to parse form data in a request.

### 5. Deactivate the Python virtual environment

* Run command `deactivate`

### 6. Write code

Create the program file and paste code into it.

```python
import json
import base64
import os
import logging
from requests_toolbelt.multipart import decoder
from mailchimp3 import MailChimp
from mailchimp3.mailchimpclient import MailChimpError

logger = logging.getLogger()
logger.setLevel(logging.INFO)

def parse_email(content_type, body):
    multipart_string = base64.b64decode(body)
    parts = decoder.MultipartDecoder(multipart_string, content_type).parts
    for part in parts:
        if 'name="email"' in str(part.headers[b'Content-Disposition']):
            return part.text
    return None

def my_handler(event, context):
    api_key = os.environ['API_KEY']
    username = os.environ['USERNAME']
    list_id = os.environ['LIST_ID']
    client = MailChimp(mc_api=api_key, mc_user=username)
    content_type = event['headers']['Content-Type']
    email = parse_email(content_type, event['body'])
    try:
        lists = client.lists.all()
        logger.info(lists)
        members = client.lists.members.create(list_id, {
            'email_address': email,
            'status': 'subscribed'
        })
    except MailChimpError as e:
        print(e)
        return {
            'statusCode': 400,
            "header": {
                "Content-Type": "application/json"
            },
            'body': str(e)
        }
    return {
        'statusCode': 200,
        "header": {
            "Content-Type": "application/json"
        }
        'body': ''
    }
```

### 7. Package the Python virual environment and your code

Create a shell script file, and paste code into the file.

```shell
#!/usr/bin/bash

rm -rf ${OLDPWD}/function.zip
cd v-env/lib/python3.7/site-packages
zip -r9 ${OLDPWD}/function.zip .
cd ${OLDPWD}
zip -g function.zip function.py
aws lambda update-function-code --function-name mailchimp-proxy --zip-file fileb://function.zip
```

### 8. Deploy your code to the remote

Run command `sh package.sh` to start the script we just created.

### 9. Verify your AWS Lambda function

* Open the Lambda console and enter your function from the function list

* Click the API Gateway

* Find the API endpoint in the detail panel

### 10. Build a Mailchimp Embed Form in your AMP Pages

Import neccessary AMP javascript file in your `<head>`.

```html
<script async src="https://cdn.ampproject.org/v0.js"></script>
<script async custom-template="amp-mustache" src="https://cdn.ampproject.org/v0/amp-mustache-0.2.js"></script>
<script async custom-element="amp-form" src="https://cdn.ampproject.org/v0/amp-form-0.1.js"></script>
```

Paste codes into the HTML file.

```html
<!-- Begin Mailchimp Signup Form -->
<div id="mc_embed_signup">
    <form action-xhr="<YOUR ENDPOINTS>" method="post"
        id="mc-embedded-subscribe-form" name="mc-embedded-subscribe-form" class="validate" target="_blank" novalidate>
        <div id="mc_embed_signup_scroll">
            <input type="email" value="" name="email" class="email" id="mce-EMAIL" placeholder="email address" required>
            <div class="clear"><input type="submit" value="Subscribe" id="mc-embedded-subscribe" class="button"></div>
        </div>
        <div submit-success>
            <template type="amp-mustache">
                <h1>Thanks for your subscription!</h1>
            </template>
        </div>
        <div submit-error>
            <template type="amp-mustache">
                <h1>You have subscribed!</h1>
            </template>
        </div>
    </form>
</div>
<!--End mc_embed_signup-->
```

### 11. Verify the form on your AMP Pages

*People can create a static website easily by Jekyll. You learn Jekyll in 5 minutes by reading [A Beginner's Guide on Jekyll](/jekyll-beginner-guide.html). People also can create a AMP page by their familiar ways.*

Run your website by command `jekyll serve` and open `http://localhost:4000` on your browser.

*In my blog website what you are visiting is a live demo, you can try to subscribe your email at the bottom of pages.*

### 12. Verify subscriptions on your Mailchimp console

* Login your Mailchimp console. <https://login.mailchimp.com>

* Open Audience list.

![Open Audience List](/assets/2019-12-16-how-to-build-a-mailchimp-embed-form-in-amp-pages/step-12.jpg)

## Conclusion

There are many frameworks, tools, and practices to frontend development. But not all of them have good compatibility. So we need to do some work to integrate their features together to gain fancy user experience and speed up our development.

*You can download full source code about the Python program in my Github <https://github.com/miguoliang/mailchimp-proxy-aws-lambda> and use it in your project if you want.*
