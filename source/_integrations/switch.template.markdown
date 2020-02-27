---
title: "템플릿 스위치"
description: "Instructions on how to integrate Template Switches into Home Assistant."
ha_category:
  - Switch
ha_release: 0.13
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 구성 요소를 결합하는 스위치를 만듭니다. 

예를 들어, 모터를 작동하는 토글 스위치가 있는 차고 문과 문이 열려 있는지 또는 닫혀 있는지 알 수 있는 센서가 있는 경우 차고 문이 열려 있는지 닫혀 있는지 알 수 있는 스위치로 이들을 결합 할 수 있습니다.

이를 통해 GUI를 단순화하고 자동화를보다 쉽게 ​​작성할 수 있습니다. 결합한 통합구성요소를 `hidden`으로 표시하여 자체적으로 나타나지 않도록 할 수 있습니다. 

## 설정 

설치에서 템플릿 스위치를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

{% raw %}

```yaml
# Example configuration.yaml entry
switch:
  - platform: template
    switches:
      skylight:
        value_template: "{{ is_state('sensor.skylight', 'on') }}"
        turn_on:
          service: switch.turn_on
          data:
            entity_id: switch.skylight_open
        turn_off:
          service: switch.turn_off
          data:
            entity_id: switch.skylight_close
```

{% endraw %}

{% configuration %}
  switches:
    description: List of your switches.
    required: true
    type: map
    keys:
      friendly_name:
        description: 프론트 엔드에서 사용할 이름
        required: false
        type: string
      entity_id:
        description: 스위치의 엔티티 상태 변경에만 반응하는 엔티티 ID 목록. 자동 분석에서 모든 관련 엔티티를 찾지 못하면 사용할 수 있습니다.
        required: false
        type: [string, list]
      value_template:
        description: 스위치 상태를 설정하기위한 템플릿을 정의
        required: true
        type: template
      availability_template:
        description: 컴포넌트의 `available` 상태를 가져 오도록 템플리트를 정의. 템플릿이 `true`를 반환하면 `available` 입니다. 템플릿이 다른 값을 반환하면 장치는 `unavailable`입니다. `availability_template`이 설정되어 있지 않으면 구성 요소는 항상 `available` 입니다.
        required: false
        type: template
        default: true
      turn_on:
        description: 스위치가 켜질 때 실행할 동작을 정의.
        required: true
        type: action
      turn_off:
        description: 스위치가 꺼질 때 실행할 동작을 정의.
        required: true
        type: action
      icon_template:
        description: 스위치 아이콘의 템플릿을 정의.
        required: false
        type: template
      entity_picture_template:
        description: 스위치 그림의 템플릿을 정의.
        required: false
        type: template
{% endconfiguration %}

## 고려사항 

로드하는 데 추가시간이 더 걸리는 플랫폼의 상태를 사용하는 경우, 시작시 템플릿 표시등이 `unknown` 상태가 될 수 있습니다. 그러면 해당 플랫폼이 로드를 완료 할 때까지 로그 파일에 오류 메시지가 나타납니다. 
템플릿에서 `is_state()` 함수를 사용하면 이런 상황을 피할 수 있습니다. 
예를 들어, `true`/`false`를 반환하는 동등한 상황으로 {% raw %}`{{ states.switch.source.state == 'on' }}`{% endraw %}로 대체할 경우 절대 uknown 결과를 나타내지 않습니다. {% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %}

## 사례 

이 섹션에는이 스위치를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 스위치 복사 (Copy Switch)

이 예는 다른 스위치를 복사하는 스위치를 보여줍니다.

{% raw %}

```yaml
switch:
  - platform: template
    switches:
      copy:
        value_template: "{{ is_state('switch.source', 'on') }}"
        turn_on:
          service: switch.turn_on
          data:
            entity_id: switch.target
        turn_off:
          service: switch.turn_off
          data:
            entity_id: switch.target
```

{% endraw %}

### 토글 스위치 (Toggle Switch)

이 예는 센서에서 상태를 가져오고 스위치를 토글하는 스위치를 보여줍니다.

{% raw %}

```yaml
switch:
  - platform: template
    switches:
      blind:
        friendly_name: "Blind"
        value_template: "{{ is_state_attr('switch.blind_toggle', 'sensor_state', 'on') }}"
        turn_on:
          service: switch.toggle
          data:
            entity_id: switch.blind_toggle
        turn_off:
          service: switch.toggle
          data:
            entity_id: switch.blind_toggle
```

{% endraw %}

### 센서와 두개 스위치 (Sensor and Two Switches)

이 예는 센서에서 상태를 가져오고 두 개의 모멘터리 스위치를 사용하여 장치를 제어하는 ​​스위치를 보여줍니다.

{% raw %}

```yaml
switch:
  - platform: template
    switches:
      skylight:
        friendly_name: "Skylight"
        value_template: "{{ is_state('sensor.skylight', 'on') }}"
        turn_on:
          service: switch.turn_on
          data:
            entity_id: switch.skylight_open
        turn_off:
          service: switch.turn_on
          data:
            entity_id: switch.skylight_close
```

{% endraw %}

### 아이콘 변화

이 예는 주야간 주기를 기준으로 아이콘을 변경하는 방법을 보여줍니다.

{% raw %}

```yaml
switch:
  - platform: template
    switches:
      garage:
        value_template: "{{ is_state('cover.garage_door', 'on') }}"
        turn_on:
          service: cover.open_cover
          data:
            entity_id: cover.garage_door
        turn_off:
          service: cover.close_cover
          data:
            entity_id: cover.garage_door
        icon_template: >-
          {% if is_state('cover.garage_door', 'open') %}
            mdi:garage-open
          {% else %}
            mdi:garage
          {% endif %}
```

{% endraw %}

### 엔티티 사진 변화 (Change The Entity Picture)

이 예는 주야간주기를 기반으로 엔티티 사진을 변경하는 방법을 보여줍니다.

{% raw %}

```yaml
switch:
  - platform: template
    switches:
      garage:
        value_template: "{{ is_state('cover.garage_door', 'on') }}"
        turn_on:
          service: cover.open_cover
          data:
            entity_id: cover.garage_door
        turn_off:
          service: cover.close_cover
          data:
            entity_id: cover.garage_door
        entity_picture_template: >-
          {% if is_state('cover.garage_door', 'open') %}
            /local/garage-open.png
          {% else %}
            /local/garage-closed.png
          {% endif %}
```

{% endraw %}
