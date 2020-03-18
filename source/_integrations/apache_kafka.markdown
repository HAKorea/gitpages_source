---
title: 분산데이터스트리밍(Apache Kafka)
description: Send data and events to Apache Kafka.
logo: apache_kafka.png
ha_category:
  - History
ha_release: 0.97
ha_codeowners:
  - '@bachya'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/waw0XXNX-uQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`apache_kafka` 통합구성요소는 모든 상태 변경을 [Apache Kafka](https://kafka.apache.org/) topic으로 보냅니다.

Apache Kafka는 데이터 스트림을 읽고 쓸 수있는 실시간 데이터 파이프 라인(real-time data pipeline)입니다. 분산된 복제된 fault-tolerant 클러스터에 데이터를 안전하게 저장합니다.

설치시 `apache_kafka` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
apache_kafka:
  host: localhost
  port: 9092
  topic: home_assistant_1
```

{% configuration %}
host:
  description: The IP address or hostname of an Apache Kafka cluster.
  required: true
  type: string
port:
  description: The port to use.
  required: true
  type: integer
topic:
  description: The Kafka topic to send data to.
  required: true
  type: string
filter:
  description: Filters for entities to be included/excluded.
  required: false
  type: map
  keys:
    include_domains:
      description: Domains to be included.
      required: false
      type: list
    include_entities:
      description: Entities to be included.
      required: false
      type: list
    exclude_domains:
      description: Domains to be excluded.
      required: false
      type: list
    exclude_entities:
      description: Entities to be excluded.
      required: false
      type: list
{% endconfiguration %}
