---
title: 그라피트(Graphite)
description: Instructions on how to record Home Assistant history in Graphite.
logo: graphite.png
ha_category:
  - History
ha_release: 0.13
---

`graphite` 통합구성요소는 모든 이벤트와 상태 변경을 기록하고 데이터를 [graphite](http://graphite.wikidot.com/) 인스턴스에 제공합니다.

이 컴포넌트를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
graphite:
```

{% configuration %}
host:
  description: IP address of your graphite host, e.g., 192.168.1.10.
  required: false
  type: string
  default: localhost
port:
  description: This is a description of what this key is for.
  required: false
  type: integer
  default: 2003
prefix:
  description: Prefix is the metric prefix in graphite.
  required: false
  type: string
  default: ha
{% endconfiguration %}
