---
title: 임계값(Threshold)
description: Instructions on how to integrate threshold binary sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.34
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`threshold` 이진 센서 플랫폼은 다른 센서의 상태를 관찰합니다. 값이 주어진 임계값보다 낮거나(`lower`) 높거나( `upper`)하면 임계값 센서의 상태가 변경됩니다. `lower`와 `upper`가 주어지면 범위를 지원합니다.

센서가 히스테리시스(탄력성)없이 설정되고 센서값이 임계값과 같으면 임계값에 대해 센서가 `lower` 또는 `upper`가 아니기 때문에 센서가 꺼집니다. 

비정상적으로 너무 높거나 너무 낮은 상태를 얻기 위해 템플릿 바이너리 센서의 `value_template:` 에 대한 대안입니다.

{% raw %}
```yaml
{{ states('sensor.furnace') > 2.5 }}
```
{% endraw %}

## 설정

임계값 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: threshold
    entity_id: sensor.random
    lower: 20
```

{% configuration %}
entity_id:
  description: "The entity to monitor. Only [sensors](/integrations/sensor/) are supported."
  required: true
  type: string
lower:
  description: The lower threshold which the observed value is compared against.
  required: false
  type: float
upper:
  description: The upper threshold which the observed value is compared against.
  required: false
  type: float
hysteresis:
  description: The distance the observed value must be from the threshold before the state is changed.
  required: false
  type: float
  default: 0.0
name:
  description:  Name of the sensor to use in the frontend.
  required: false
  type: string
  default: Threshold
{% endconfiguration %}
