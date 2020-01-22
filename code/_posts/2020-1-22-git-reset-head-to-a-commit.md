---
layout: post
title: "Git: Reset Head to a Commit"
description: How to reset head to a commit in Git
image: /assets/2020-1-22-git-reset-head-to-a-commit/banner.jpg
categories:
    - code
tags:
    - git
---

When you want to go back to a specific commit in both local and remote branches, you can use `git log` to list recent commits, and use `git reset --hard <commit sha256>` to reset the head to the commit you want to go back, and use `git push -f` to push your changes to the remote forcely.

For example:

1. List recent commits

    ```shell
    $ git log
    commit 61176897cc44c898aa97c05b08b08f048688a2ce (HEAD -> master)
    Author: 米国梁 <nothingmi@muchencute.com>
    Date:   Wed Jan 22 21:23:21 2020 +0800

        update post

    commit ce0381e46fd85b3180e6cc2cf86989258451adf7
    Author: 米国梁 <nothingmi@muchencute.com>
    Date:   Mon Jan 20 19:15:11 2020 +0800

        post: How to bind the value of an option tag correctly in Angular

    commit 661f28fca479fb7f2f7c75b68301ff595d63235a
    Author: 米国梁 <nothingmi@muchencute.com>
    Date:   Fri Jan 3 13:52:42 2020 +0800

        update dates
    ```

2. Reset the head

   ```shell
   $ git reset --hard ce0381e46fd85b3180e6cc2cf86989258451adf7
   HEAD is now at ce0381e update post
   ```

3. Push to the remote

    ```shell
    git push -f
    ```

## Conclusion

To reset the head hardly is a danger operation, it will make commits after the commit you want to rollback to detached from the branch, so you should be careful to do this.
