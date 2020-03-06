---
title: 통계(Statistics)
description: Instructions on how to integrate statistical sensors into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: '0.30'
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`statistics` 센서 플랫폼은 다른 센서의 상태를 사용합니다. `mean` 값을 상태로 내보내고 다음 값을 속성으로 내 보냅니다. : `count`, `mean`, `median`, `stdev`, `variance`, `total`, `min_value`, `max_value`, `min_age`, `max_age`, `change`, `average_change`, `change_rate`. 이진 센서인 경우 상태 변경만 적용됩니다.

[recorder](/integrations/recorder/) 구성 요소를 실행중인 경우 시작시 데이터베이스에서 데이터를 읽습니다. 따라서 플랫폼을 다시 시작하면 즉시 데이터를 사용할 수 있습니다. [history](/integrations/history/) 구성 요소를 사용하는 경우 시작시 `recorder` 통합구성요소도 자동으로 시작됩니다. `recorder` 구성 요소를 실행하지 *않는* 경우, 계산을 수행하기 위해 두 개의 속성이 둘 이상의 값을 필요로하기 때문에 센서가 작동하기 시작하는데 시간이 걸릴 수 있습니다.

## 설정

통계 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# enable the recorder integration (optional)
recorder:

# Example configuration.yaml entry
sensor:
  - platform: statistics
    entity_id: sensor.cpu
  - platform: statistics
    entity_id: binary_sensor.movement
    max_age:
      minutes: 30
```

{% configuration %}
entity_id:
  description: The entity to monitor. Only [sensors](/integrations/sensor/) and [binary sensor](/integrations/binary_sensor/).
  required: true
  type: string
name:
  description: Name of the sensor to use in the frontend.
  required: false
  default: Stats
  type: string
sampling_size:
  description: Size of the sampling. If the limit is reached then the values are rotated.
  required: false
  default: 20
  type: integer
max_age:
  description: Maximum age of measurements. Setting this to a time interval will cause older values to be discarded.
  required: false
  type: time
precision:
  description: Defines the precision of the calculated values, through the argument of round().
  required: false
  default: 2
  type: integer
{% endconfiguration %}

<p class='img'>
  <img src='{{site_root}}/images/screenshots/stats-sensor.png' />
</p>
