---
layout: post
title:  "Install EPEL release and Pip in REHL/CentOS7"
date:   2019-1-21 10:16:00 +0800
categories: linux
---
## What is EPEL
__EPEL__ (Extra Packages for Enterprise Linux) is open source and free community based repository project from Fedora team which provides 100% high quality add-on software packages for Linux distribution including RHEL (Red Hat Enterprise Linux), CentOS, and Scientific Linux. Epel project is not a part of RHEL/Cent OS but it is designed for major Linux distributions by providing lots of open source packages like networking, sys admin, programming, monitoring and so on. Most of the epel packages are maintained by Fedora repo.

```shell
## RHEL/CentOS 7 64-Bit ##
wget http://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
rpm -ivh epel-release-latest-7.noarch.rpm
```

## What is Pip
__Pip__ (recursive acronym for “Pip Installs Packages” or “Pip Installs Python“) is a cross-platform package manager for installing and managing Python packages (which can be found in the Python Package Index (PyPI)) that comes with Python 2 >=2.7.9 or Python 3 >=3.4 binaries that are downloaded from python.org.

```shell
yum install epel-release 
yum install python-pip
```

## References:
- [How To Install PIP to Manage Python Packages in Linux](https://www.tecmint.com/install-pip-in-linux/)
- [How to Enable EPEL Repository for RHEL/CentOS 7.x/6.x/5.x](https://www.tecmint.com/how-to-enable-epel-repository-for-rhel-centos-6-5/)