---
title: Times of the Day
description: Instructions on how to integrate Times of the Day binary sensors within Home Assistant.
ha_category:
  - Binary Sensor
ha_release: 0.89
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`tod` 플랫폼은 현재 시간이 정의 된 시간 범위 내에 있는지 확인하여 그 값을 얻을 바이너리 센서를 지원합니다.

시간 범위는 절대 현지 시간으로 제공되거나 위치의 태양 위치를 기반으로 계산 된 `sunrise` 또는 `sunset` 키워드를 사용하여 제공 할 수 있습니다.

태양 위치기반 범위 외에도 음수 또는 양수 오프셋을 설정할 수 있습니다.

## 설정 

다음은 `configuration.yaml` 파일에 센서를 추가하는 예입니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: tod
    name: Early Morning
    after: sunrise
    after_offset: '-02:00'
    before: '07:00'

  - platform: tod
    name: Late Morning
    after: '10:00'
    before: '12:00'
```

{% configuration %}
name:
  description: 센서 이름.
  required: true
  type: string
before:
  description: 시간 범위 시작을 위한 절대 로컬 시간 값 또는 태양 이벤트.
  required: true
  type: [string, time]
before_offset:
  description: 시작 시간 범위의 시간 오프셋입니다.
  required: false
  type: time
after:
  description: 시간 범위 종료를위한 절대 로컬 시간 값 또는 태양 이벤트.
  required: true
  type: [string, time]
after_offset:
  description: 시작 시간 범위의 시간 오프셋입니다.
  type: time
  required: false
{% endconfiguration %}

## 고려 사항 

이 센서의 주요 목적은 `sun.sun` 통합구성요소 속성 을 참조하여 복잡한 템플릿을 생성하는 대신 간단한 시간 범위 정의를 사용하는 것입니다 .

이 조건에서 센서 상태는 ON입니다 `after` + `after_offset` <= `current time` < `before` + `before_offset`

만약 `after`시간이 `before`보다 늦으면 다음 날이 고려됩니다. 예:

```yaml
binary_sensor:
  - platform: tod
    name: Night
    after: sunset
    before: sunrise
```

위의 예에서 다음날 `sunrise`은 시간 범위 끝으로 계산됩니다.