---
layout: post
title:  "Contribute Visual Studio Code (VSCode) Step by Step on macOS"
date:   2019-10-26 19:31:00 +0800
categories: vscode
---

This article is a quick guide for a developer who contribute the Visual Studio Code (VSCode) at the first time. So far as I know, contribute a famous open source project is not so easy as the official Contribute Guide said, because the official contribute guide assumes that readers should be familiar with relevant tools and work on a perfect environment, but it's not true for the new. And that's why I write this article, I hope everyone could continue their research smoothly. Here we go!

## Step 0. Install Homebrew

Homebrew is a famous pacakge manager for macOS. Mostly, it is the easiest way to install packages we need. Paste the script in a macOS Terminal prompt to install Homebrew.

```shell
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### Troubleshooting

If you just finished a big upgrade for macOS, for example upgrade from 10.14 to 10.15, you would better uninstall your existing brew and reinstall it again. Otherwise, Homebrew works unstable.

Paste the script in a macOS Terminal prompt to install Homebrew to uninstall your existing Homebrew.

```shell
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
```

## Step 1. Install Git

Paste that in a macOS Terminal prompt to install Git

```shell
brew install git
```

## Step 2. Install NodeJS

The most recommended way to install nodejs is Node Version Manager (NVM). NVM is used to 

### Install 
