---
title: 변화율(Derivative)
description: Instructions on how to integrate Derivative Sensor into Home Assistant.
ha_category:
  - Utility
  - Energy
ha_release: 0.105
ha_iot_class: Local Push
logo: derivative.png
ha_qa_scale: internal
ha_codeowners:
  - '@afaucogney'
---

`derivative` 플랫폼은 source 센서가 제공한 값의 변화율을 추정하는 센서를 생성합니다. 
Derivative 센서는 **source** 변경시 업데이트됩니다.

## 설정

설치에서 Derivative 센서를 ​​활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: derivative
    source: sensor.current_speed
```

{% configuration %}
source:
  description: The entity ID of the sensor providing numeric readings
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  default: source entity ID meter
  type: string
round:
  description: Round the calculated derivative value to at most N decimal places.
  required: false
  default: 3
  type: integer
unit_prefix:
  description: Metric unit to prefix the derivative result ([Wikipedia](https://en.wikipedia.org/wiki/Unit_prefix)]). Available symbols are "n" (1e-9), "µ" (1e-6), "m" (1e-3), "k" (1e3), "M" (1e6), "G" (1e9), "T" (1e12).
  required: false
  default: None
  type: string
unit_time:
  description: SI unit of time to integrate over. Available units are s, min, h, d.
  required: false
  default: h
  type: string
unit:
  description: Unit of Measurement to be used for the derivative.
  required: false
  type: string
time_window:
  description: The time window in which to calculate the derivative. This is useful for sensor that output discrete values. By default the derivative is calculated between two consecutive updates.
  default: 0
  required: false
  type: time
{% endconfiguration %}

## 온도 변화율 사례

예를 들어, 몇 초마다 값을 출력하지만 가장 가까운 반값으로 반올림하는 온도 센서 `sensor.temperature`가 있습니다.
이는 두 개의 연속 출력값이 동일 할 수 있음을 의미합니다 (따라서 미분은 `Δy=0`이기 때문에 `Δy/Δx=0`입니다).
그러나 실제로 온도는 시간이 지남에 따라 변할 수 있습니다.
이를 캡처하려면 `time_window`를 사용해야합니다, 즉각적인 피크값들은 높은 변화율의 결과로 나오지 않도록 하게 하고, 다음 센서 업데이트시 변화율이 0으로 나오지 않습니다. 

`time_window`를 사용하는 예제 설정은

```yaml
sensor:
  - platform: derivative
    source: sensor.temperature
    name: Temperature change per hour
    round: 1
    unit_time: h
    time_window: "00:30:00"  # we look at the change over the last half hour
```
