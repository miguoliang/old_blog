---
layout: post
title:  "How to config proxy cache for PWA in Nginx"
date:   2019-4-7 09:11:00 +0800
categories: nginx proxy cache
---
```nginx
proxy_cache_path  /var/lib/nginx/cache  levels=1:2    keys_zone=STATIC:10m inactive=24h  max_size=2g;

server {

  location / {
    try_files $uri @prerender;
  }

  location @prerender {
    set $prerender 0;

    proxy_cache            STATIC;
    proxy_cache_valid    any 1d;
    proxy_ignore_headers Cache-Control;
    proxy_ignore_headers X-Accel-Expires;
    proxy_ignore_headers Set-Cookie;
    proxy_ignore_headers Expires;
    proxy_cache_key $host$uri$is_args$args;
    proxy_cache_use_stale  error timeout invalid_header updating http_500 http_502 http_503 http_504;

    if ($prerender = 1) {
        rewrite .* /$scheme://$host:$server_port$request_uri? break;
        proxy_pass http://10.0.2.2:3000;
    }
  }
}
```

### References

- [how caching via nginx result of prerender.io](https://stackoverflow.com/questions/37828419/how-caching-via-nginx-result-of-prerender-io)
