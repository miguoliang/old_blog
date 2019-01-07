---
layout: post
title:  "Change logging level in logstash without restart"
date:   2019-1-7 16:30:00 +0800
categories: logstash
---
`INFO` is the logging level by default in Logstash, and if you want to debug your settings or monitor the health of logstash, you should change the logging level to `DEBUG` or `TRACE`, and the former is better than the latter.

__Retrieve list of logging configurations__
```shell
curl -XGET 'localhost:9600/_node/logging?pretty'
```
example response
```json
{
  "loggers" : {
    "logstash.agent" : "INFO",
    "logstash.api.service" : "INFO",
    "logstash.basepipeline" : "INFO",
    "logstash.codecs.plain" : "INFO",
    "logstash.codecs.rubydebug" : "INFO",
    "logstash.filters.grok" : "INFO",
    "logstash.inputs.beats" : "INFO",
    "logstash.instrument.periodicpoller.jvm" : "INFO",
    "logstash.instrument.periodicpoller.os" : "INFO",
    "logstash.instrument.periodicpoller.persistentqueue" : "INFO",
    "logstash.outputs.stdout" : "INFO",
    "logstash.pipeline" : "INFO",
    "logstash.plugins.registry" : "INFO",
    "logstash.runner" : "INFO",
    "logstash.shutdownwatcher" : "INFO",
    "org.logstash.Event" : "INFO",
    "slowlog.logstash.codecs.plain" : "TRACE",
    "slowlog.logstash.codecs.rubydebug" : "TRACE",
    "slowlog.logstash.filters.grok" : "TRACE",
    "slowlog.logstash.inputs.beats" : "TRACE",
    "slowlog.logstash.outputs.stdout" : "TRACE"
  }
}
```

__Update Logging Levels__
```shell
curl -XPUT 'localhost:9600/_node/logging?pretty' -H 'Content-Type: application/json' -d'
{
    "logger.logstash.outputs.elasticsearch" : "DEBUG"
}
'
```

>__NOTE__
If you want logging changes to persist after a restart, add them to log4j2.properties instead.

Official Reference: [https://www.elastic.co/guide/en/logstash/current/logging.html#_update_logging_levels](https://www.elastic.co/guide/en/logstash/current/logging.html#_update_logging_levels)