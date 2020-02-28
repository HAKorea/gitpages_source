---
title: "탬플릿 팬(Template Fan)"
description: "Instructions how to setup the Template fans within Home Assistant."
ha_category:
  - Fan
ha_release: 0.69
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 통합구성요소를 결합하고 팬(fan)의 각 turn_on, turn_off, set_speed, set_oscillating 및 set_direction 명령에 대해 스크립트를 실행하거나 서비스를 호출하는 기능을 제공하는 팬(fan)을 만듭니다

설치에서 템플릿 팬을 활성화하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

{% raw %}

```yaml
# Example configuration.yaml entry
fan:
  - platform: template
    fans:
      bedroom_fan:
        friendly_name: "Bedroom fan"
        value_template: "{{ states('input_boolean.state') }}"
        speed_template: "{{ states('input_select.speed') }}"
        oscillating_template: "{{ states('input_select.osc') }}"
        direction_template: "{{ states('input_select.direction') }}"
        turn_on:
          service: script.fan_on
        turn_off:
          service: script.fan_off
        set_speed:
          service: script.fan_speed
          data_template:
            speed: "{{ speed }}"
        set_oscillating:
          service: script.fan_oscillating
          data_template:
            oscillating: "{{ oscillating }}"
        set_direction:
          service: script.fan_direction
          data_template:
            direction: "{{ direction }}"
        speeds:
          - '1'
          - '2'
          - '3'
```

{% endraw %}

{% configuration %}
  fans:
    description: 팬 목록.
    required: true
    type: map
    keys:
      friendly_name:
        description: 프론트 엔드에서 사용할 이름.
        required: false
        type: string
      value_template:
        description: "팬 상태를 가져 오기위한 템플릿을 정의. 유효한 값 : 'on'/'off'"
        required: true
        type: template
      speed_template:
        description: 팬 속도를 얻을 수있는 템플릿을 정의
        required: false
        type: template
      oscillating_template:
        description: "팬의 OSC 상태를 가져 오기위한 템플릿을 정의. 유효한 값 : true/false"
        required: false
        type: template
      direction_template:
        description: "팬의 방향을 알 수있는 템플릿을 정의합니다. 유효한 값 : 'forward'/'reverse'"
        required: false
        type: template
      availability_template:
        description: 컴포넌트의 `available` 상태를 가져오도록 템플리트를 정의합니다. 템플릿이 `true` 를 반환하면 장치는  `available`. 템플릿이 다른 값을 반환하면 장치는 `unavailable`. `availability_template`이 설정되어 있지 않으면 구성 요소는 항상 `available`입니다.
        required: false
        type: template
        default: true
      turn_on:
        description: 팬이 켜질 때 실행할 동작을 정의.
        required: true
        type: action
      turn_off:
        description: 팬이 꺼질 때 실행할 동작을 정의.
        required: true
        type: action
      set_speed:
        description: 팬에 속도 명령이 제공 될 때 실행할 동작을 정의.
        required: false
        type: action
      set_oscillating:
        description: 팬에 osc state 명령이 제공 될 때 실행할 동작을 정의.
        required: false
        type: action
      set_direction:
        description: 팬에 방향 명령이 제공 될 때 실행할 동작을 정의.
        required: false
        type: action
      speeds:
        description: 팬이 작동 할 수있는 속도 목록.
        required: false
        type: [string, list]
        default: ['low', 'medium', 'high']
{% endconfiguration %}
