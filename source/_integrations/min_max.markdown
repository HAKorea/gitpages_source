---
title: 최대값/최소값(min/max)
description: Instructions on how to integrate min/max sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.31
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`min_max` 센서 플랫폼은 다른 센서의 상태를 사용하여 최소, 최대, 최신 (마지막)과 수집된 상태의 평균을 결정합니다. 센서는 항상 모든 모니터링된 센서에서 받은 최저/최고/최신값을 표시합니다. 값이 급등한 경우 먼저 [statistics sensor](/integrations/statistics)를 사용하여 값을 필터링(filter)/균등화(equalize)하는 것이 좋습니다.

이 센서는 [template sensor](/integrations/template)의 `value_template: `에 대한 대안입니다. :  여러 센서의 평균을 얻기 위해 

{% raw %}
```yaml
{{ ((float(states('sensor.kitchen_temperature')) +
     float(states('sensor.living_room_temperature')) +
     float(states('sensor.office_temperature'))) / 3) | round(2)
}}
```
{% endraw %}

알 수 없는 상태의 센서는 계산에서 무시됩니다. 센서의 측정 단위가 다른 경우 `min_max` 센서는 값이 `UNKNOWN` 이고 측정 단위가 `ERR` 인 오류 상태가 됩니다.

## 설정

`min_max` 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: min_max
    entity_ids:
      - sensor.kitchen_temperature
      - sensor.living_room_temperature
      - sensor.office_temperature
```

{% configuration %}
entity_ids:
  description: 모니터링할 엔티티가 둘 이상 있습니다. 첫 번째 항목의 측정 단위가 사용됩니다. 모든 엔티티는 동일한 측정 단위를 사용해야합니다.
  required: true
  type: [list, string]
type:
  description: "센서의 유형: `min`, `max`, `last` 혹은 `mean`."
  required: false
  default: max
  type: string
name:
  description: 프론트엔드에서 사용할 센서의 이름.
  required: false
  type: string
round_digits:
  description: 평균값을 지정된 자릿수로 반올림합니다.
  required: false
  type: integer
  default: 2
{% endconfiguration %}
