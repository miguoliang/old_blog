---
layout: post
title: How to Add All Missing Imports Automatically in Java and Visual Studio Code
description:
image: /assets/2020-05-21-how-to-add-all-missing-imports-automatically-in-java-and-visual-studio-code/banner.jpg
categories:
    - code
tags:
    - vscode
    - java
    - visual studio code
---

Sometimes I have to insert `import` statements one by one in Visual Studio Code when I develop a Java program. It’s annoying and a waste of time for me, and if you are facing the same problem, this guide will keep you away from annoying codes and manual operations from `import` statements.

First, open your settings dialog, like this:

![Settings](/assets/2020-05-21-how-to-add-all-missing-imports-automatically-in-java-and-visual-studio-code/settings-dialog.png)

Next, type `java import save` in search box to filter options we need.

![Filtered Settings](/assets/2020-05-21-how-to-add-all-missing-imports-automatically-in-java-and-visual-studio-code/settings-filtered.png)

Finally, check the option *Enable/disable auto organize imports on save action*, like this:

![Final Settings](/assets/2020-05-21-how-to-add-all-missing-imports-automatically-in-java-and-visual-studio-code/settings-final.png)

That's it!

You can write your code freely without thinking about `import` statements, and all missing `import` statements can be added when you save the file. Like this:

![Screenshot](/assets/2020-05-21-how-to-add-all-missing-imports-automatically-in-java-and-visual-studio-code/screenshot.gif)
