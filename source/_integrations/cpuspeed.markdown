---
title: CPU 속도
description: Instructions on how to integrate CPU speed within Home Assistant.
logo: cpu.png
ha_category:
  - System Monitor
ha_release: pre 0.7
ha_iot_class: Local Push
ha_codeowners:
  - '@fabaff'
---

현재 CPU 속도를 모니터링 할 수있는 `cpuspeed` 센서 플랫폼.

<div class='note warning'>

  실제 CPU에 액세스해야하므로 Hass.io와 같은 컨테이너에서 이 센서를 사용할 수 없습니다. 또한 모든 ARM CPU 가 지원되는 것은 아닙니다 .

</div>

## 설정

이 플랫폼을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: cpuspeed
```

{% configuration %}
name:
  description: 프론트 엔드에서 사용할 이름
  required: false
  type: string
  default: CPU speed
{% endconfiguration %}
