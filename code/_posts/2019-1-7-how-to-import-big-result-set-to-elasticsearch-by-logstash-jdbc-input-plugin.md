---
layout: post
title:  "How to import big result set to Elasticsearch by Logstash JDBC input plugin"
date:   2019-1-7 16:00:00 +0800
categories:
    - code
---
Editing your logstash configuration file, and generally you can find it/them in `/etc/logstash/conf.d`; it depends on your settings in `logstash.yml` that is in `/etc/logstash/logstash.yml`.

For example, if you want to import data from your table in the database, you should have a configuration file, and we name it `logstash-example.conf`, open and append lines like below:

```conf
input {
    stdin {
    }
    jdbc {
      jdbc_connection_string => "jdbc:mysql://host:port/database"
      jdbc_user => "username"
      jdbc_password => "password"
      jdbc_driver_library => "/opt/drivers/mysql-connector-java-5.1.46/mysql-connector-java-5.1.46-bin.jar"
      jdbc_driver_class => "com.mysql.jdbc.Driver"
      statement => "select *, (select destoctof_des from mall_product_destoctof where destoctof_product_id = product_id) as destoctof_des from mall_product where product_updated_time > :sql_last_value"
      use_column_value => true
      tracking_column => "product_updated_time"
      schedule => "* * * * *"
      jdbc_paging_enabled => true
      jdbc_page_size => 500
      jdbc_fetch_size => 500
      clean_run => false
      jdbc_default_timezone => "Asia/Shanghai"
    }
}

output {
  stdout {
    codec => json_lines
  }
  elasticsearch {
    hosts => ["localhost:9200"]
    index => "index_name"
    document_type => "type_name"
    document_id => "%{product_id}"
  }
}
```

> __NOTATION__

1. `clean_run` must be `false` for pagination support
1. `jdbc_paging_enabled` must be `true`
1. `jdbc_page_size` and `jdbc_fetch_size` are better to be set both, and not be very large if there is some big field in the result set.
