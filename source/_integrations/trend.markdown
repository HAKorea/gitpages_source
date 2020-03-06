---
title: 트렌드(Trend)
description: Instructions on how to integrate Trend binary sensors into Home Assistant.
ha_category:
  - Utility
logo: home-assistant.png
ha_release: 0.28
ha_iot_class: Local Push
ha_quality_scale: internal
---

`trend` 플랫폼을 사용하면 다른 엔티티의 숫자 `state` 또는 `state_attributes` 경향을 보여주는 센서를 만들 수 있습니다. 이 센서에는 트렌드(경향)를 설정하기 위해 기본 센서의 업데이트가 두 개 이상 필요합니다. 따라서 정확한 상태를 표시하는 데 시간이 걸릴 수 있습니다. 트렌드를 기반으로 작업을 수행하려는 자동화의 일부로 유용할 수 있습니다.

## 설정

트렌드 바이너리 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: trend
    sensors:
      cpu_speed:
        entity_id: sensor.cpu_speed
```

{% configuration %}
sensors:
  description: List of your sensors.
  required: true
  type: map
  keys:
    entity_id:
      description: The entity that this sensor tracks.
      required: true
      type: string
    attribute:
      description: >
        The attribute of the entity that this sensor tracks.
        If no attribute is specified then the sensor will track the state.
      required: false
      type: string
    device_class:
      description: Sets the [class of the device](/integrations/binary_sensor/), changing the device state and icon that is displayed on the frontend.
      required: false
      type: string
    friendly_name:
      description: Name to use in the Frontend.
      required: false
      type: string
    invert:
      description: >
        Invert the result. A `true` value would
        mean descending rather than ascending.
      required: false
      type: boolean
      default: false
    max_samples:
      description: Limit the maximum number of stored samples.
      required: false
      type: integer
      default: 2
    min_gradient:
      description: >
        The minimum rate at which the observed value
        must be changing for this sensor to switch on.
        The gradient is measured in sensor units per second.
      required: false
      type: string
      default: 0.0
    sample_duration:
      description: >
        The duration **in seconds** to store samples for.
        Samples older than this value will be discarded.
      required: false
      type: integer
      default: 0
{% endconfiguration %}

## 여러 샘플 사용하기

선택적 `sample_duration` 및 `max_samples` 매개 변수를 지정하면 여러 샘플을 저장하고 장기 트렌드를 감지하는 데 사용할 수 있습니다.

상태가 변경 될 때마다 새로운 샘플이 샘플시간과 함께 저장됩니다. `sample_duration`시간 보다 오래된 샘플은 폐기됩니다. 

그런 다음 트렌드 라인을 사용 가능한 샘플에 맞추고 이 라인의 gradient를 `min_gradient`와 비교하여 트렌드 센서의 상태를 결정합니다. gradient는 초당 센서 단위로 측정됩니다. - 온도가 시간당 2 도씩 떨어지는 시점을 알고 싶다면 (-2) / (60 x 60) = -0.00055의 gradient를 사용하십시오.

저장된 샘플의 현재 수가 상태 페이지에 표시됩니다.

## 사례

이 섹션에는이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

이 예는 태양이 여전히 떠오르면 `true`를 나타냅니다.

```yaml
binary_sensor:
  - platform: trend
    sensors:
      sun_rising:
        entity_id: sun.sun
        attribute: elevation
```

이 예에서는 온도가 시간당 최소 3도 이상으로 상승 또는 하강하는지를 나타내는 두 개의 센서를 만들고 2 시간 동안 샘플을 수집합니다.

```yaml
binary_sensor:
  - platform: trend
    sensors:
      temp_falling:
        entity_id: sensor.outside_temperature
        sample_duration: 7200
        min_gradient: -0.0008
        device_class: cold

      temp_rising:
        entity_id: sensor.outside_temperature
        sample_duration: 7200
        min_gradient: 0.0008
        device_class: heat
```
