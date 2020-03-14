---
title: 리플(Ripple)
description: Instructions on how to integrate ripple.com data within Home Assistant.
logo: ripple.png
ha_category:
  - Finance
ha_release: 0.47
ha_iot_class: Cloud Polling
---

`ripple` 센서 플랫폼은 [Ripple.com](https://ripple.com)의 Ripple 지갑 잔액을 표시합니다.

Ripple 센서를 설치에 추가하려면 `configuration.yaml` 파일에서 볼 Ripple 주소를 지정하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: ripple
    address: 'r3kmLJN5D28dHuH8vZNUZpMC43pEHpaocV'
```

{% configuration %}
address:
  description: Ripple wallet address to watch.
  required: true
  type: string
name:
  description: Name for the sensor to use in the frontend.
  required: false
  type: string
  default: Ripple Balance
{% endconfiguration %}
