---
title: "템플릿 Vacuum"
description: "Instructions how to setup Template vacuums within Home Assistant."
ha_category: Vacuum
ha_release: 0.96
ha_iot_class: Local Push
logo: home-assistant.png
ha_quality_scale: internal
---

`template` 플랫폼은 통합구성요소들을 결합하여 진공청소기 플랫폼을 만들고, 해당 플랫폼에 start, pause, stop, return_to_base, clean_spot, locate, set_fan_speed 명령 각 스크립트 또는 서비스를 실행하는 기능을 제공합니다 

설치에서 Template 진공청소기를 사용 가능하게하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

{% raw %}

```yaml
# Example configuration.yaml entry
vacuum:
  - platform: template
    vacuums:
      living_room_vacuum:
        start:
          service: script.vacuum_start
```

{% endraw %}

{% configuration %}
  vacuums:
    description: 진공 청소기 목록.
    required: true
    type: map
    keys:
      friendly_name:
        description: 프론트 엔드에서 사용할 이름.
        required: false
        type: string
      value_template:
        description: "진공청소기 상태를 얻는 템플릿을 정의. 주요값: `docked`/`cleaning`/`idle`/`paused`/`returning`/`error`"
        required: false
        type: template
      battery_level_template:
        description: "진공청소기 상태의 배터리 수준을 얻기위한 템플릿을 정의. 유효한 값은 `0` 및 `100` 사이의 숫자 입니다."
        required: false
        type: template
      fan_speed_template:
        description: 진공의 팬 속도를 얻기위한 템플릿을 정의.
        required: false
        type: template
      availability_template:
        description: 컴포넌트의 `available` 상태를 받아오는 템플릿을 정의. 템플릿이 `true`를 반환하면 기기는 `available` 상태이고 다른 값을 반환하면 `unavailable` 상태로 템플릿을 작성해야 함. `availability_template`을 작성하지 않으면 컴포넌트의 `available` 상태는 항상 'true'입니다.
        required: false
        type: template
        default: true
      start:
        description: 청소가 시작될 때 실행할 동작을 정의.
        required: true
        type: action
      pause:
        description: 청소가 일시 중지 될 때 실행할 동작을 정의.
        required: false
        type: action
      stop:
        description: 청소가 중지 될 때 실행할 동작을 정의.
        required: false
        type: action
      return_to_base:
        description: 진공청소기가 기본 명령으로 복귀 될 때 실행할 액션을 정의.
        required: false
        type: action
      clean_spot:
        description: 진공청소기에 클린 스팟 명령이 제공 될 때 실행할 동작을 정의.
        required: false
        type: action
      locate:
        description: 진공청소기에 찾기 명령이 제공 될 때 실행할 동작을 정의
        required: false
        type: action
      set_fan_speed:
        description: 진공청소기에 팬 속도를 설정하라는 명령이 제공 될 때 실행할 동작을 정의.
        required: false
        type: action
      fan_speeds:
        description: 진공청소기에 지원되는 팬 속도 목록.
        required: false
        type: [string, list]
{% endconfiguration %}

## 사례 

### 하모니 허브로 진공 제어

이 예에서는 템플릿 진공을 사용하여 [Harmony Hub Remote component](/integrations/harmony)를 사용하여 IR 진공 청소기를 제어하는 ​​방법을 보여줍니다. 

```yaml
vacuum:
  - platform: template
    vacuums:
      living_room_vacuum:
        start:
          - service: remote.send_command
            data:
              entity_id: remote.harmony_hub
              command: Clean
              device: 52840686
        return_to_base:
          - service: remote.send_command
            data:
              entity_id: remote.harmony_hub
              command: Home
              device: 52840686
        clean_spot:
          - service: remote.send_command
            data:
              entity_id: remote.harmony_hub
              command: SpotCleaning
              device: 52840686
```

### 진공청소기 상태 

이 예는 템플릿을 사용하여 진공청소기 상태를 지정하는 방법을 보여줍니다.

{% raw %}

```yaml
vacuum:
  - platform: template
    vacuums:
      living_room_vacuum:
        value_template: "{{ states('sensor.vacuum_state') }}"
        battery_level_template: "{{ states('sensor.vacuum_battery_level')|int }}"
        fan_speed_template: "{{ states('sensor.vacuum_fan_speed') }}"
        start:
            service: script.vacuum_start
        pause:
            service: script.vacuum_pause
        stop:
            service: script.vacuum_stop
        return_to_base:
            service: script.vacuum_return_to_base
        clean_spot:
            service: script.vacuum_clean_spot
        locate:
            service: script.vacuum_locate_vacuum
        set_fan_speed:
            service: script.vacuum_set_fan_speed
            data_template:
              speed: "{{ fan_speed }}"
        fan_speeds:
            - Low
            - Medium
            - High
```

{% endraw %}
