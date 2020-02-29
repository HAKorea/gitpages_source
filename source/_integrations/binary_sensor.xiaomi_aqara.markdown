---
title: "샤오미 이진 센서"
description: "Instructions on how to setup the Xiaomi binary sensors within Home Assistant."
logo: xiaomi.png
ha_category:
  - Binary Sensor
ha_release: "0.50"
ha_iot_class: Local Push
---

`xiaomi aqara` 이진 센서 플랫폼을 사용하면 [Xiaomi](https://www.mi.com/en/) 이진 센서에서 데이터를 얻을 수 있습니다.

요구 사항은 [`xiaomi aqara` 통합구성요소](/integrations/xiaomi_aqara/)를 설정해야합니다.

### 지원되는 센서 유형

| Name | Zigbee entity | Model no. | States | Event | Event key | Event values |
| ---- | ------------- | --------- | ------ | ----- | --------- | ------------ |
| Motion Sensor (1st gen) | motion | RTCGQ01LM | on, off | `xiaomi_aqara.motion` | | |
| Motion Sensor (2nd gen) | sensor_motion.aq2 | RTCGQ11LM | on, off | `xiaomi_aqara.motion` | | |
| Xiaomi Door and Window Sensor (1st gen) | magnet | MCCGQ01LM | on, off | | | |
| Aqara Door and Window Sensor (2nd gen) | sensor_magnet.aq2 | MCCGQ11LM | on, off | | | |
| Smoke Detector | smoke | JTYJ-GD-01LM/BW | on, off | | | |
| Gas Leak Detector | natgas | JTQJ-BF-01LM/BW | on, off | | | |
| Water Leak Sensor | sensor_wleak.aq1 | SJCGQ11LM | on, off | | | |
| Button (1st gen) | switch | WXKG01LM | on (through long_click_press), off | `xiaomi_aqara.click`| `click_type`| `long_click_press`, `long_click_release`, `hold`, `single`, `double` |
| Button (2nd gen) | sensor_switch.aq2, remote.b1acn01 | WXKG11LM | off (always) | `xiaomi_aqara.click` | `click_type` | `single`, `double` |
| Button (2nd gen, model b) | sensor_switch.aq3 | WXKG12LM | off (always) | `xiaomi_aqara.click` | `click_type` | `single`, `double`, `long_click_press`, `shake` |
| Aqara Wireless Switch (Single) | 86sw1 | WXKG03LM | off (always) | `xiaomi_aqara.click` | `click_type` | `single` |
| Aqara Wireless Switch (Double) | 86sw2 | WXKG02LM | off (always) | `xiaomi_aqara.click` | `click_type` | `single`, `both` |
| Aqara Wireless Switch (Single) (2nd gen) | remote.b186acn01 | WXKG03LM | off (always) | `xiaomi_aqara.click` | `click_type` | `single`, `double`, `long` |
| Aqara Wireless Switch (Double) (2nd gen) | remote.b286acn01 | WXKG02LM | off (always) | `xiaomi_aqara.click` | `click_type` | `single`, `double`, `long`, `both`, `double_both`, `long_both` |
| Cube | cube | MFKZQ01LM | off (always) | `xiaomi_aqara.cube_action` | `action_type`, `action_value` (rotate) | `flip90`, `flip180`, `move`, `tap_twice`, `shake_air`, `swing`, `alert`, `free_fall`, `rotate` (degrees at action_value) |
| Vibration Sensor | vibration | DJT11LM | off (always) | `xiaomi_aqara.movement` | `movement_type` | `vibrate`, `tilt`, `free_fall` |

### 자동화 샘플

#### Motion

```yaml
- alias: If there is motion and its dark turn on the gateway light
  trigger:
    platform: state
    entity_id: binary_sensor.motion_sensor_158d000xxxxxc2
    from: 'off'
    to: 'on'
  condition:
    condition: numeric_state
    entity_id: sensor.illumination_34ce00xxxx11
    below: 300
  action:
    - service: light.turn_on
      entity_id: light.gateway_light_34ce00xxxx11
      data:
        brightness: 5
    - service: automation.turn_on
      data:
        entity_id: automation.MOTION_OFF
- alias: If there no motion for 5 minutes turn off the gateway light
  trigger:
    platform: state
    entity_id: binary_sensor.motion_sensor_158d000xxxxxc2
    from: 'on'
    to: 'off'
    for:
      minutes: 5
  action:
    - service: light.turn_off
      entity_id: light.gateway_light_34ce00xxxx11
    - service: automation.turn_off
      data:
        entity_id: automation.Motion_off
```

#### Door and/or Window

```yaml
- alias: If the window is open turn off the radiator
  trigger:
    platform: state
    entity_id: binary_sensor.door_window_sensor_158d000xxxxxc2
    from: 'off'
    to: 'on'
  action:
    service: climate.set_operation_mode
    entity_id: climate.livingroom
    data:
      operation_mode: 'Off'
- alias: If the window is closed for 5 minutes turn on the radiator again
  trigger:
    platform: state
    entity_id: binary_sensor.door_window_sensor_158d000xxxxxc2
    from: 'on'
    to: 'off'
    for:
      minutes: 5
  action:
    service: climate.set_operation_mode
    entity_id: climate.livingroom
    data:
      operation_mode: 'Smart schedule'
- alias: Notify if door is opened when away
  trigger:
    platform: state
    entity_id: binary_sensor.door_window_sensor_15xxxxxxc9xx6b
    from: 'off'
    to: 'on'
  condition:
    - condition: state
      entity_id: group.family
      state: 'not_home'
  action:
    - service: notify.notify_person
      data:
        message: 'The door has been opened'
```

#### Smoke

```yaml
- alias: Send notification on fire alarm
  trigger:
    platform: state
    entity_id: binary_sensor.smoke_sensor_158d0001574899
    from: 'off'
    to: 'on'
  action:
    - service: notify.html5
      data:
        title: Fire alarm!
        message: Fire/Smoke detected!
    - service: xiaomi_aqara.play_ringtone
      data:
        gw_mac: xxxxxxxxxxxx
        ringtone_id: 2
        ringtone_vol: 100
```

#### Gas

```yaml
- alias: Send notification on gas alarm
  trigger:
    platform: state
    entity_id: binary_sensor.natgas_sensor_158dxxxxxxxxxx
    from: 'off'
    to: 'on'
  action:
    - service: notify.html5
      data_template:
        title: Gas alarm!
        message: 'Gas with a density of {% raw %}{{ state_attr('binary_sensor.natgas_sensor_158dxxxxxxxxxx', 'density') }}{% endraw %} detected.'
```

#### 샤오미 무선 버튼

이 페이지 상단의 표에 표시된 것처럼 3 가지 버전의 버튼이 있습니다. 원형 버튼의 경우 사용 가능한 이벤트는 `single`, `double`, `hold`, `long_click_press`, `long_click_release` 입니다. Aqara 브랜드 버튼은 사각형입니다. 모델 WXKG11LM은 `single`, `double` 이벤트만 지원합니다. WXKG12LM은 `single`, `double`, `long_click_press`, `shake` 이벤트를 지원합니다. Aqara 버전의 경우 더블 클릭을 생성하기 위해 두 번의 클릭 사이의 지연 시간이 라운드 버튼보다 커야합니다. 너무 빨리 클릭하면 단일 클릭 이벤트가 생성됩니다.

```yaml
- alias: Toggle dining light on single press
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.switch_158d000xxxxxc2
      click_type: single
  action:
    service: switch.toggle
    entity_id: switch.wall_switch_left_158d000xxxxx01
- alias: Toggle couch light on double click
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.switch_158d000xxxxxc2
      click_type: double
  action:
    service: switch.toggle
    entity_id: switch.wall_switch_right_158d000xxxxx01
- alias: Let a dog bark on long press
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.switch_158d000xxxxxc2
      click_type: long_click_press
  action:
    service: xiaomi_aqara.play_ringtone
    data:
      gw_mac: xxxxxxxxxxxx
      ringtone_id: 8
      ringtone_vol: 8
```

#### 샤오미 큐브

사용 가능한 이벤트는 `flip90`, `flip180`, `move`, `tap_twice`, `shake_air`, `swing`, `alert`, `free_fall`, `rotate`. 통합구성요소는 마지막 액션을 속성 `last_action`으로 저장합니다 

```yaml
- alias: Cube event flip90
  trigger:
    platform: event
    event_type: xiaomi_aqara.cube_action
    event_data:
      entity_id: binary_sensor.cube_15xxxxxxxxxxxx
      action_type: flip90
  action:
    - service: light.turn_on
      entity_id: light.gateway_light_28xxxxxxxxxx
      data:
        color_name: "springgreen"
- alias: Cube event flip180
  trigger:
    platform: event
    event_type: xiaomi_aqara.cube_action
    event_data:
      entity_id: binary_sensor.cube_15xxxxxxxxxxxx
      action_type: flip180
  action:
    - service: light.turn_on
      entity_id: light.gateway_light_28xxxxxxxxxx
      data:
        color_name: "darkviolet"
- alias: Cube event move
  trigger:
    platform: event
    event_type: xiaomi_aqara.cube_action
    event_data:
      entity_id: binary_sensor.cube_15xxxxxxxxxxxx
      action_type: move
  action:
    - service: light.turn_on
      entity_id: light.gateway_light_28xxxxxxxxxx
      data:
        color_name: "gold"
- alias: Cube event tap_twice
  trigger:
    platform: event
    event_type: xiaomi_aqara.cube_action
    event_data:
      entity_id: binary_sensor.cube_15xxxxxxxxxxxx
      action_type: tap_twice
  action:
    - service: light.turn_on
      entity_id: light.gateway_light_28xxxxxxxxxx
      data:
        color_name: "deepskyblue"
- alias: Cube event shake_air
  trigger:
    platform: event
    event_type: xiaomi_aqara.cube_action
    event_data:
      entity_id: binary_sensor.cube_15xxxxxxxxxxxx
      action_type: shake_air
  action:
    - service: light.turn_on
      entity_id: light.gateway_light_28xxxxxxxxxx
      data:
        color_name: "blue"
```

#### 아카라 무선 스위치

Aqara 무선 스위치는 단일 키 및 이중 키 버전으로 제공됩니다. 각 키는 클릭 이벤트 `single` 로 제한되는 무선 버튼처럼 작동합니다. 이중 키 버전은 `binary_sensor.wall_switch_both_158xxxxxxxxx12`라는 세 번째 장치를 추가하며 두 키를 모두 누르면 `both` 라는 클릭 이벤트를 보고합니다.

```yaml
- alias: Decrease brightness of the gateway light
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.wall_switch_left_158xxxxxxxxx12
      click_type: single
  action:
    service: light.turn_on
    entity_id: light.gateway_light_34xxxxxxxx13
    data_template:
      brightness: {% raw %}>-
        {% if state_attr('light.gateway_light_34xxxxxxxx13', 'brightness') %}
          {% if state_attr('light.gateway_light_34xxxxxxxx13', 'brightness') - 60 >= 10 %}
            {{state_attr('light.gateway_light_34xxxxxxxx13', 'brightness') - 60}}
          {% else %}
            {{state_attr('light.gateway_light_34xxxxxxxx13', 'brightness')}}
          {% endif %}
        {% else %}
          10
        {% endif %}{% endraw %}

- alias: Increase brightness of the gateway light
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.wall_switch_right_158xxxxxxxxx12
      click_type: single
  action:
    service: light.turn_on
    entity_id: light.gateway_light_34xxxxxxxx13
    data_template:
      brightness: {% raw %}>-
        {% if state_attr('light.gateway_light_34xxxxxxxx13', 'brightness') %}
          {% if state_attr('light.gateway_light_34xxxxxxxx13', 'brightness') + 60 <= 255 %}
            {{state_attr('light.gateway_light_34xxxxxxxx13', 'brightness') + 60}}
          {% else %}
            {{state_attr('light.gateway_light_34xxxxxxxx13', 'brightness')}}
          {% endif %}
        {% else %}
          10
        {% endif %}{% endraw %}

- alias: Turn off the gateway light
  trigger:
    platform: event
    event_type: xiaomi_aqara.click
    event_data:
      entity_id: binary_sensor.wall_switch_both_158xxxxxxxxx12
      click_type: both
  action:
    service: light.turn_off
    entity_id: light.gateway_light_34xxxxxxxx13
```

#### 진동 센서

이 자동화는 거실 램프를 진동 / 기울기에서 토글합니다.

```yaml
- alias: Turn on Living Room Lamp on vibration
  trigger:
    platform: event
    event_type: xiaomi_aqara.movement
    event_data:
      entity_id: binary_sensor.vibration_xxxx000000
      movement_type: vibrate
  action:
    service: light.toggle
    data:
      entity_id: light.living_room_lamp
- alias: Turn on Living Room Lamp on tilt
  trigger:
    platform: event
    event_type: xiaomi_aqara.movement
    event_data:
      entity_id: binary_sensor.vibration_xxxx000000
      movement_type: tilt
  action:
    service: light.toggle
    data:
      entity_id: light.living_room_lamp
```
