---
layout: post
title:  "Nginx supports PHP7"
date:   2019-2-2 09:45:00 +0800
categories: nginx php
---
## Install PHP7
```shell
yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum install http://rpms.remirepo.net/enterprise/remi-release-7.rpm
yum install yum-utils
yum-config-manager --enable remi-php70
# yum-config-manager --enable remi-php71
# yum-config-manager --enable remi-php72
yum install php php-mcrypt php-cli php-gd php-curl php-mysql php-ldap php-zip php-fileinfo
yum install php-fpm
```
## Check the installed version of PHP
```shell
php -v
```
## Config Nginx
```nginx
server {
  
  ...

  location / {
    root /your/root/directory;
    index index.php;
    try_files $uri $uri/ /index.php?$query_string;
    location ~ \.php$ {
      fastcgi_pass   127.0.0.1:9000;
      fastcgi_index  index.php;
      fastcgi_param  SCRIPT_FILENAME $document_root$fastcgi_script_name;
      include        fastcgi_params;
    }
    location ~* \.(ts|eot|otf|svg|ttf|woff|woff2) {
      add_header Access-Control-Allow-Origin *;
    }
  }
  
  ...

}
```
## Config php-fpm
Location:  `/etc/php-fpm.d/www.conf`
```conf
user = sameAsNginx
group = sameAsNginx
listen = 127.0.0.1:9000
listen.owner = sameAsNginx
listen.group = sameAsNginx
listen.mode = 0660
```
Start/restart `php-fpm` service after editing by `sudo service php-fpm start/refstart`
## Troubleshooting
1. `File not found`, some message like `FastCGI sent in stderr: "Primary script unknown"` in the nginx error.log.
  1. File existence
  1. Nginx can not communicate with php-fpm
  1. Root is wrong
  1. Set `setenforce 0`

## References
- [How to Install PHP 7 in CentOS 7](https://www.tecmint.com/install-php-7-in-centos-7/)
- [Nginx 1 FastCGI sent in stderr: “Primary script unknown”](https://serverfault.com/questions/517190/nginx-1-fastcgi-sent-in-stderr-primary-script-unknown)
- [Install Nginx, PHP on Amazon Linux](https://www.matbra.com/2016/12/07/install-nginx-php-on-amazon-linux.html)