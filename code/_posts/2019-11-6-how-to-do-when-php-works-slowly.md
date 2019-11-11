---
layout: post
title:  "How to do when PHP works slowly"
date:   2019-11-06 19:31:00 +0800
description: >-
    Many reasons can make PHP working slowly. And how to find the reason you are facing is essential. This article helps you find and fix it out, step by step.
image: /assets/2019-11-6-how-to-do-when-php-works-slowly/banner.jpg
categories:
    - code
---

## Introduction

Many reasons can make PHP working slowly. And how to find the reason you are facing is essential. This article helps you find and fix it out, step by step.

I assume your PHP running on a Linux server, and the version of your PHP is 7.0 or above. Here we GO!

## 1. Check the Load Average of the Server

First of all, What is the Load Average of the Server? The belowing reference is from *[Linux Load Averages: Solving the Mystery](http://www.brendangregg.com/blog/2017-08-08/linux-load-averages.html)* of *[Brendan Gregg's Blog](http://www.brendangregg.com/blog/index.html)*, and I pick a useful paragraph that is related my topic only.

>Linux load averages are "system load averages" that show the running thread (task) demand on the system as an average number of running plus waiting threads. This measures demand, which can be greater than what the system is currently processing. Most tools show three averages, for 1, 5, and 15 minutes.

To analyze the load average of the server, we need to get CPU information of the server firstly, and you can run `lscpu` on the prompt to get it.

```shell
$ lscpu
Architecture:          x86_64
CPU op-mode(s):        32-bit, 64-bit
Byte Order:            Little Endian
CPU(s):                8
On-line CPU(s) list:   0-7
Thread(s) per core:    2
Core(s) per socket:    4
Socket(s):             1
NUMA node(s):          1
Vendor ID:             AuthenticAMD
CPU family:            23
Model:                 1
Model name:            AMD EPYC 7571
Stepping:              2
CPU MHz:               2200.000
BogoMIPS:              4400.00
Hypervisor vendor:     KVM
Virtualization type:   full
L1d cache:             32K
L1i cache:             64K
L2 cache:              512K
L3 cache:              8192K
NUMA node0 CPU(s):     0-7
Flags:                 fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt pdpe1gb rdtscp lm constant_tsc art rep_good nopl nonstop_tsc extd_apicid aperfmperf eagerfpu pni pclmulqdq ssse3 fma cx16 sse4_1 sse4_2 movbe popcnt aes xsave avx f16c rdrand hypervisor lahf_lm cmp_legacy cr8_legacy abm sse4a misalignsse 3dnowprefetch topoext perfctr_core retpoline_amd fsgsbase bmi1 avx2 smep bmi2 rdseed adx smap clflushopt sha_ni xsaveopt xsavec xgetbv1 arat npt nrip_save
```

The ciritical item is `CPU(s)` that means the count of CPU, and we got 8 in the server, so it means the server have 8 CPUs.

The next, you can run `uptime` on the prompt to check the Load Average on the server.

```shell
$ uptime
02:21:02 up 12 days, 23:52,  1 user,  load average: 1.80, 1.39, 1.26
```

All load averages are below than 8, the count of CPUs, means that no ciritical performance issues. So we have confirmed the server works healthy, and the hardware resources are enougth, the problem must be in software configurations.

## 2. Check limits settings

Administering Linux servers can be a challenge, especially when the systems you manage are heavily used and performance problems reduce availability.

Fortunately, Fortunately, you can put limits on certain resources to help ensure that the most important processes on your servers can keep running and competing processes don't consume far more resources than is good for the overall system by the `ulimit` command. Howerver, the default values of limits settings maybe not proper for your case so that cause performance problem.

To see the limits associate with your login, use the command ulimit -a. If you're using a regular user account, you will likely see something like this:

```shell
$ ulimit -a
core file size          (blocks, -c) 0
data seg size           (kbytes, -d) unlimited
scheduling priority             (-e) 0
file size               (blocks, -f) unlimited
pending signals                 (-i) 126343
max locked memory       (kbytes, -l) 64
max memory size         (kbytes, -m) unlimited
open files                      (-n) 1024
pipe size            (512 bytes, -p) 8
POSIX message queues     (bytes, -q) 819200
real-time priority              (-r) 0
stack size              (kbytes, -s) 8192
cpu time               (seconds, -t) unlimited
max user processes              (-u) 4096
virtual memory          (kbytes, -v) unlimited
file locks                      (-x) unlimited
```

So far as I know, if your PHP program open many files at the same time, you should set the number of `open files` is large enough.

More details about the `ulimit` command, you can read *[Setting limits with ulimit](https://www.networkworld.com/article/2693414/setting-limits-with-ulimit.html)*.

## 3. Check PHP configurations

If all the above is ok, but your PHP program runs slowly as before, you need to check your PHP configurations.

You can find your PHP configuration file in `/etc/php-fpm.conf` and make sure you have the permission to modify it.

Generally, the `/etc/php-fpm.conf` is the default configuration file, and custom configuration files are placed in `/etc/php-fpm.d/` directory and included by the `/etc/php-fpm.conf`, so you should modify the `/etc/php-fpm.conf` little times.

A default custom configuration file which is called `www.conf` is placed in the custom configuration directory, and you should modify it in this guide.

### Check the Process Manager (PM) Settings

Generally, you will see the default settings in `www.conf` like this:

```text
pm = dynamic
pm.max_children = 5
pm.start_servers = 3
pm.min_spare_servers = 2
pm.max_spare_servers = 4
pm.max_requests = 200
```

The first line is the most important for your performance. It determines the running mode of process manager. There are three possible values for `pm`:

- *dynamic*: You get to specify the minimum and a maximum number of processes that php-fpm will keep alive at any given point in time. This is set by default.
- *static*: A fixed number of PHP processes will be maintained no matter what.
- *ondemand*: Processes are created and destroyed, well, on demand. This mode will cost much more time on process creation and releasing than the other two modes. This is not a good choice for high performance goal.

`pm.max_children` means the max size of the process pool. Do not set it too small to hold requests.
`pm.start_servers` means the size of the process pool when the php-fpm start.
`pm.min_spare_servers` means the min number of processes can be idle.
`pm.max_spare_servers` means the max number of processes can be idle.
`pm.max_requests` means how many requests a process will restart when it resolved.

### Enable the Slowlog

To find the ciritical problem of your PHP program, you should enable the `slowlog` of PHP, and it will show where the program run slowly.

Here, assume that your custom php-fpm configuration file is `/etc/php-fpm.d/www.conf`, open and find keyword `slowlog`.

```text
; The log file for slow requests
; Default Value: not set
; Note: slowlog is mandatory if request_slowlog_timeout is set
slowlog = /var/log/php-fpm/www-slow.log

; The timeout for serving a single request after which a PHP backtrace will be
; dumped to the 'slowlog' file. A value of '0s' means 'off'.
; Available units: s(econds)(default), m(inutes), h(ours), or d(ays)
; Default Value: 0
request_slowlog_timeout = 1s
```

The `slowlog = /var/log/php-fpm/www-slow.log` tells php-fpm where to store the `slowlog` file.
The `request_slowlog_timeout = 1s` tells php-fpm the timeout for serving a single request after which a PHP backtrace will be dumped to the `slowlog` file.

Remove the leading semicolon of the 4th and 9th line to uncomment slowlog, and restart the php-fpm service mannually on the prompt.

Send a request to your URL that runs slowly before and check your `slowlog`.

### Check Deadlock

A deadlock is a situation in which two computer programs sharing the same resource are effectively preventing each other from accessing the resource, resulting in both programs ceasing to function. The earliest computer operating systems ran only one program at a time.

Why you need to check deadlock here? Because of the session management mechanism in PHP.

When you call `session_start` to get ready to write something to a session object, a session file will be placed in the sessions directory, which is set by `session.save_path`, with a FILE LOCK. What does it mean? It means that lock is kept on the file until the script ends or the lock is purposely removed (more on that below). This acts as both a read and write lock: every attempt to read the session will have to wait until the lock is released.

When 2 PHP files try to start a session at the same time, only one “wins” and gets the lock. The other needs to wait. While it waits, it’s not doing anything: `session_start()` is blocking all further execution. As soon as the lock from the first script is removed, the second script can continue as it gets the lock.

In most scenarios, this makes PHP behave as a set of synchronous scripts for the same user: one executes after the other, there are no parallel requests. Even if you tried to call these PHP files via AJAX.

According to the slowlog, you can find the right place to fix, and a `flock` call will appear in the slowlog to help you to confirm whether a deadlock occured.

One of the useful solutions for avoid deadlock here is Redis, because Redis does not support locking yet. So you can use it to store session.

Some other solutions include Relationship Database (such as MySQL, PostgreSQL, and so on), memcache, or other data persistance plans to avoid the file lock.

## Conclusion

There are many reason can make the PHP program running slowly, the above is a roadmap to find what is the most ciritical problem and how to fix it. In most scenaries, we recommend you deploy the PHP code in an isolated environment, because it is easy to monitor the performance and measure the load average.
