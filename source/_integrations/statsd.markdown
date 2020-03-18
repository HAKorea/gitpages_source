---
title: 통계데몬(StatsD)
description: Record events in StatsD.
logo: statsd.png
ha_category:
  - History
ha_release: 0.12
---

`statsd` 통합구성요소로 모든 상태 변경을 외부 [StatsD](https://github.com/etsy/statsd) 인스턴스로 전송할 수 있습니다.

`statsd` 통합구성요소를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
statsd:
```

{% configuration %}
host:
  description: "IP address of your StatsD host, e.g., 192.168.1.10."
  required: true
  default: localhost
  type: string
port:
  description: Port to use.
  required: false
  default: 8125
  type: integer
prefix:
  description: Prefix to use.
  required: false
  default: hass
  type: string
rate:
  description: The sample rate.
  required: false
  default: 1
  type: integer
log_attributes:
  description: Log state and attribute changes. This changes the default stats path.
  required: false
  default: false
  type: boolean
value_mapping:
  description: Map non-numerical values to numerical ones.
  required: false
  type: list
{% endconfiguration %}

Full example:

```yaml
# Example configuration.yaml entry
statsd:
  prefix: home
  rate: 5
  value_mapping:
    cooling: 1
    heating: 10
```

StatsD는 다양한 [backends](https://github.com/etsy/statsd/blob/master/docs/backend.md)를 지원합니다