---
layout: post
title:  "Changing a remote's URL"
date:   2018-12-30 19:22:27 +0800
categories: git
---
1\. List your existing remotes in order to get the name of the remote you want to change.
{% highlight shell %}
$ git remote -v
origin  git@github.com:USERNAME/REPOSITORY.git (fetch)
origin  git@github.com:USERNAME/REPOSITORY.git (push)
{% endhighlight %}

2\. Change your remote's URL
{% highlight shell %}
$ git remote set-url origin https://github.com/USERNAME/REPOSITORY.git
{% endhighlight %}

3\. Verify that the remote URL has changed.
{% highlight shell %}
$ git remote -v
# Verify new remote URL
origin  https://github.com/USERNAME/REPOSITORY.git (fetch)
origin  https://github.com/USERNAME/REPOSITORY.git (push)
{% endhighlight %}

References is [here](https://help.github.com/articles/changing-a-remote-s-url/)