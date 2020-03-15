---
title: "템플릿 커버(Template Cover)"
description: "Instructions on how to integrate Template Covers into Home Assistant."
ha_category:
  - Cover
ha_release: 0.48
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 통합구성요소들을 결합한 커버를 만들 수 있고, 커버(Cover)의 열기, 닫기, 중지, 위치 및 기울기 명령 각각에 대해 스크립트를 실행하거나 서비스를 호출 할 수 있습니다.

## 설정

설치에서 템플릿 커버를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 : 

{% raw %}

```yaml
# Example configuration.yaml entry
cover:
  - platform: template
    covers:
      garage_door:
        friendly_name: "Garage Door"
        value_template: "{{ states('sensor.garage_door')|float > 0 }}"
        open_cover:
          service: script.open_garage_door
        close_cover:
          service: script.close_garage_door
        stop_cover:
          service: script.stop_garage_door
```

{% endraw %}

{% configuration %}
  covers:
    description: List of your covers.
    required: true
    type: map
    keys:
      friendly_name:
        description: 프론트 엔드에서 사용할 이름.
        required: false
        type: string
      entity_id:
        description: Cover의 엔티티 상태 변경에만 반응하는 엔티티 ID 목록입니다. 자동 분석에서 모든 관련 엔티티를 찾지 못하면 사용할 수 있습니다.
        required: false
        type: [string, list]
      value_template:
        description: Cover 상태를 가져 오는 템플릿을 정의. 유효한 값은 `open`/`true` 혹은 `closed`/`false`. [`value_template`](#value_template) 그리고 [`position_template`]
        required: exclusive
        type: template
      position_template:
        description: Cover 상태를 가져 오는 템플릿을 정의. 올바른 값은 `0`(닫힘)과 `100`(열림) 사이의 숫자. [`value_template`](#value_template)과 [`position_template`](#position_template)은 동시에 지정 불가.
        required: exclusive
        type: template
      icon_template:
        description: 사용할 아이콘을 지정하기위한 템플릿을 정의.
        required: false
        type: template
      availability_template:
        description: 컴포넌트의 `available` 상태를 가져 오도록 템플리트를 정의. 템플릿이 `true`를 반환하면 `available` 입니다. 템플릿이 다른 값을 반환하면 장치는 `unavailable`입니다. `availability_template`이 설정되어 있지 않으면 구성 요소는 항상 `available` 입니다.
        required: false
        type: template
        default: true
      device_class:
        description: 프런트 엔드에 표시되는 장치 상태 및 아이콘을 변경하여 [class of the device](/integrations/cover/)를 설정합니다.
        required: false
        type: string
      open_cover:
        description: Cover를 열 때 실행할 동작을 정의합니다. [`open_cover`](# open_cover)를 지정하면 [`close_cover`](# close_cover)도 지정해야합니다. [`open_cover`](#open_cover) 및 [`set_cover_position`](#set_cover_position) 중 하나 이상을 지정해야합니다.
        required: inclusive
        type: action
      close_cover:
        description: Cover를 닫을 때 실행할 동작을 정의합니다.
        required: inclusive
        type: action
      stop_cover:
        description: Cover가 멈출 때 실행할 동작을 정의합니다.
        required: false
        type: action
      set_cover_position:
        description: Cover가 특정값으로 설정 될 때 실행할 동작을 정의합니다. (`0` 과 `100` 사이).
        required: false
        type: action
      set_cover_tilt_position:
        description: Cover 틸트(기울기)가 특정값으로 설정 될 때 실행할 동작을 정의합니다 (`0` 과 `100` 사이).
        required: false
        type: action
      optimistic:
        description: 사용할 Cover 위치 지정 [optimistic mode](#optimistic-mode).
        required: false
        type: boolean
        default: false
      tilt_optimistic:
        description: 사용할 Cover 팉트(기울기) 위치 지정 [optimistic mode](#optimistic-mode).
        required: false
        type: boolean
        default: false
      tilt_template:
        description: Cover의 틸트(기울기) 상태를 얻기 위해 템플릿을 정의합니다. 올바른 값은 `0`(닫힘)과 `100`(열림) 사이의 숫자입니다.
        required: false
        type: template
{% endconfiguration %}

## 고려 사항

로드하는 데 추가시간이 더 걸리는 플랫폼의 상태를 사용하는 경우, 시작시 템플릿 표시등이 `unknown` 상태가 될 수 있습니다. 그러면 해당 플랫폼이 로드를 완료 할 때까지 로그 파일에 오류 메시지가 나타납니다. 
템플릿에서 `is_state()` 함수를 사용하면 이런 상황을 피할 수 있습니다. 
예를 들어, `true`/`false`를 반환하는 동등한 상황으로 {% raw %}`{{ states.cover.source.state == 'open' }}`{% endraw %}로 대체할 경우 절대 uknown을 나타내지 않습니다. 

result:
{% raw %}`{{ is_state('cover.source', 'open') }}`{% endraw %}

## Optimistic 모드

optimistic 모드에서는 Cover 위치 상태가 내부적으로 유지됩니다. 이 모드는 [`value_template`](#value_template) 또는 [`position_template`](#position_template)을 지정하지 않으면 자동으로 활성화됩니다. 
Cover가 제대로 움직이는지 여부를 알 수 있는 방법이 없기 때문에 피드백 메커니즘이 없으면 신뢰성이 떨어질 수 있습니다. [`optimistic`](#optimistic) 속성을 사용하여 표지를 optimistic 모드로 강제 설정할 수 있습니다. 
`tilt_position`에는 [`tilt_template`](#tilt_template)이 지정되지 않았거나 [`tilt_optimistic`](# tilt_optimistic) 속성이 사용될 때 활성화되는 동등한 모드가 있습니다.

## 사례 

이 섹션에서는 Cover를 사용하는 방법에 대한 실제 예를 보여줍니다.

### 차고 문

이 예에서는 제어 가능한 스위치 및 위치 센서가있는 차고 문을 Cover로 변환합니다.

{% raw %}

```yaml
cover:
  - platform: template
    covers:
      garage_door:
        friendly_name: "Garage Door"
        position_template: "{{ states('sensor.garage_door') }}"
        open_cover:
          service: switch.turn_on
          data:
            entity_id: switch.garage_door
        close_cover:
          service: switch.turn_off
          data:
            entity_id: switch.garage_door
        stop_cover:
          service: switch.turn_on
          data:
            entity_id: switch.garage_door
        icon_template: >-
          {% if states('sensor.garage_door')|float > 0 %}
            mdi:garage-open
          {% else %}
            mdi:garage
          {% endif %}
```

{% endraw %}

### 여러 개폐 장치 (Multiple Covers)

이 예에서는 한 번에 둘 이상의 Cover를 제어 할 수 있습니다.

{% raw %}

```yaml
homeassistant:
  customize:
    cover_group:
      assume_state: true

cover:
  - platform: template
    covers:
      cover_group:
        friendly_name: "Cover Group"
        open_cover:
          service: script.cover_group
          data:
            modus: 'open'
        close_cover:
          service: script.cover_group
          data:
            modus: 'close'
        stop_cover:
          service: script.cover_group
          data:
            modus: 'stop'
        set_cover_position:
          service: script.cover_group_position
          data_template:
            position: "{{position}}"
        value_template: "{{is_state('sensor.cover_group', 'open')}}"
        icon_template: >-
          {% if is_state('sensor.cover_group', 'open') %}
            mdi:window-open
          {% else %}
            mdi:window-closed
          {% endif %}
        entity_id:
          - cover.bedroom
          - cover.livingroom

sensor:
  - platform: template
    sensors:
      cover_group:
        value_template: >-
          {% if is_state('cover.bedroom', 'open') %}
            open
          {% elif is_state('cover.livingroom', 'open') %}
            open
          {% else %}
            closed
          {% endif %}

script:
  cover_group:
    sequence:
      - service_template: "cover.{{modus}}_cover"
        data:
          entity_id:
            - cover.bedroom
            - cover.livingroom
  cover_group_position:
    sequence:
      - service: cover.set_cover_position
        data_template:
          entity_id:
            - cover.bedroom
            - cover.livingroom
          position: "{{position}}"

automation:
  - alias: "Close covers at night"
    trigger:
      - platform: sun
        event: sunset
        offset: '+00:30:00'
    action:
      - service: cover.set_cover_position
        data:
          entity_id: cover.cover_group
          position: 25
```

{% endraw %}

### 아이콘 변화

이 예는 Cover 상태에 따라 아이콘을 변경하는 방법을 보여줍니다.

{% raw %}

```yaml
cover:
  - platform: template
    covers:
      cover_group:
        friendly_name: "Cover Group"
        open_cover:
          service: script.cover_group
          data:
            modus: 'open'
        close_cover:
          service: script.cover_group
          data:
            modus: 'close'
        stop_cover:
          service: script.cover_group
          data:
            modus: 'stop'
        value_template: "{{is_state('sensor.cover_group', 'open')}}"
        icon_template: >-
          {% if is_state('sensor.cover_group', 'open') %}
            mdi:window-open
          {% else %}
            mdi:window-closed
          {% endif %}
```

{% endraw %}

### 엔티티 사진 변화 (Change The Entity Picture)

이 예는 Cover 상태를 기반으로 엔티티 그림을 변경하는 방법을 보여줍니다

{% raw %}

```yaml
cover:
  - platform: template
    covers:
      cover_group:
        friendly_name: "Cover Group"
        open_cover:
          service: script.cover_group
          data:
            modus: 'open'
        close_cover:
          service: script.cover_group
          data:
            modus: 'close'
        stop_cover:
          service: script.cover_group
          data:
            modus: 'stop'
        value_template: "{{is_state('sensor.cover_group', 'open')}}"
        icon_template: >-
          {% if is_state('sensor.cover_group', 'open') %}
            /local/cover-open.png
          {% else %}
            /local/cover-closed.png
          {% endif %}
```

{% endraw %}
