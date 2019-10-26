---
layout: post
title:  "Elasticsearch regular expression tips"
date:   2019-1-1 18:00:00 +0800
categories: elasticsearch
---

1. `\d` and `\w` are not supported in [regexp query](https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-regexp-query.html#regexp-syntax), so you have to use `[0-9]`, `[a-z]`, `[A-Z]`, or `[a-zA-Z]` instead.

2. In [Painless Script Language](https://www.elastic.co/guide/en/elasticsearch/painless/current/index.html) which is the primary script language in Elasticsearch, `String` does not have function `replaceAll`, you should use `Matcher.replaceAll` instead, and almost all features are supported.
[Reference](https://www.elastic.co/guide/en/elasticsearch/painless/current/painless-examples.html).

3. Regular expression support is disabled by default in Elasticsearch, you should enable it by editing `elasticsearch.yml`. Add a line as below and restart your elasticsearch service:

```yaml
script.painless.regex.enabled: true
```

*If your Elasticsearch runs in cluster mode, you need update elasticsearch.yml in each node.*
