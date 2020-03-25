---
title: 가동시간(Uptime)
description: Instructions on how to integrate an uptime sensor into Home Assistant.
ha_category:
  - Utility
ha_iot_class: Local Push
logo: home-assistant.png
ha_release: 0.56
ha_quality_scale: internal
---

`uptime` 센서 플랫폼은 마지막 홈어시스턴트 재시작 이후의 시간을 표시합니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: uptime
```

{% configuration %}
name:
  description: Name to use in the frontend.
  required: false
  type: string
  default: Uptime
unit_of_measurement:
  description: "Units for uptime measurement in either `days`, `hours` or `minutes`."
  required: false
  type: string
  default: days
{% endconfiguration %}

## 사례

```yaml
# Example with configuration variables
sensor:
  - platform: uptime
    name: Time Online
    unit_of_measurement: hours
````
