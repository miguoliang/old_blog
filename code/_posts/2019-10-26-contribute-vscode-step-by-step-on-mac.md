---
layout: post
title:  "Contribute Visual Studio Code (VSCode) Step by Step on macOS"
date:   2019-10-26 19:31:00 +0800
description: >-
    This article is a quick guide for a developer who wants to build the source code of Visual Studio Code for the first time.
categories:
    - code
---

![Contribute Visual Studio Code (VSCode) Step by Step on macOS](/assets/2019-10-26-contribute-vscode-step-by-step-on-mac/banner.jpg)

This article is a quick guide for a developer who wants to build the source code of Visual Studio Code for the first time. So far as I know, to contribute a great open source project is not so easy as the official Contribute Guide said because the official guide assumes that readers should be familiar with relevant tools and work in a perfect environment. Still, it's not right for the new. And that's why I write this article, and I hope everyone could continue their research smoothly. Here we go!

## Step 0. Install Homebrew

Homebrew is a famous pacakge manager for macOS. Mostly, and it is the easiest way to install packages we need. Paste the script in a macOS Terminal prompt to install Homebrew.

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

The most recommended way to install nodejs is Node Version Manager (NVM). NVM is used to manage current system nodejs version.

### Install NVM

*DON'T INSTALL NVM with Homebrew as the official guideline said. It is not supported any more, if you did it, you need to uninstall the NVM by Homebrew.*

Paste that in a macOS Terminal prompt to install NVM

```shell
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.0/install.sh | bash
```

Run the following script to make nvm useful right now, otherwise you will get `Command not found` error in terminal.

```shell
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
```

### Install the right version of NodeJS

As the VSCode said, we need install NodeJS v10.16.0.

```shell
$ nvm install v10.16.0
Now using node v10.16.0 (npm v6.9.0)
```

After the above, you can check the installed NodeJS.

```shell
$ node -v
v10.16.0
```

## Install Yarn

Yarn is a alternative for npm, and more features than npm. More and more NodeJS based application use Yarn to manage packages.

You can install Yarn by Homebrew in one line.

```shell
brew install yarn
```

## Install Python

*Python3 is not supported here.* And Python 2.7 has been installed on macOS by default. So you need not do any more for Python.

Check your Python installation

```shell
$ python -V
Python 2.7.16
```

## Install Command Line Tools

Command Line Tools (CLT) contains `make`, `gcc` and the related toolchain. We need them for our contribution later.

Paste that in a macOS Terminal prompt to install Command Line Tools

```shell
xcode-select --install
```

### Troubleshooting on Command Line Tools installation

If you installed xCode, you may see `xcode-select: error: command line tools are already installed, use "Software Update" to install updates`, but a CLT not installed warning would appear in the later contribution. The only way to resolve it is run `xcode-select --reset` and `sudo xcodebuild -license` to accept the license.

## Download VSCode source code from Github

First, fork the official VS Code repository so that you can make a pull request on Github.

```shell
git clone https://github.com/<<<your-github-account>>>/vscode.git
```

## Build VS Code locally

Go into vscode and start the TypeScript incremental builder:

```shell
cd vscode
yarn watch
```

## Run

To test the changes you launch a development version of VS Code on the workspace vscode, which you are currently editing.

```shell
./scripts/code.sh
```

### Troubleshooting on Run

If the script is running, but the vscode not start, you need to try to stop you running vscode and re-run this script again.

You can identify the development version of Code ("Code - OSS") by the following icon in the Dock:

![vscode oss](/assets/2019-10-26-contribute-vscode-step-by-step-on-mac/vscode.png)
