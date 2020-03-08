---
title: "KNX 이진 센서"
description: "Instructions on how to setup the KNX binary sensors within Home Assistant."
logo: knx.png
ha_category:
  - Binary Sensor
ha_release: 0.24
ha_iot_class: Local Push
---

<div class='note'>
  
이 통합구성요소를 사용하려면 `knx` 통합구성요소를 올바르게 설정해야합니다. [KNX Integration](/integrations/knx)을 참조하십시오.

</div>

`knx` 센서 플랫폼을 사용하면 [KNX](https://www.knx.org/) 이진 센서를 모니터링 할 수 있습니다.

이진 센서는 읽기 전용입니다. knx-bus에 쓰려면 노출을 구성하십시오 [KNX Integration - Expose](/integrations/knx/#exposing-sensor-values-or-time-to-knx-bus).

## 설정

`knx` 통합구성요소는 정확하게 설정되어야합니다. [KNX Integration](/integrations/knx)을 참조하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: knx
    state_address: '6/0/2'
```

{% configuration %}
state_address:
  description: KNX group address of the binary sensor.
  required: true
  type: string
name:
  description: A name for this device used within Home Assistant.
  required: false
  type: string
sync_state:
  description: Actively read the value from the bus. If `False` no GroupValueRead telegrams will be sent to the bus.
  required: false
  type: boolean
  default: True
device_class:
  description: Sets the [class of the device](/integrations/binary_sensor/), changing the device state and icon that is displayed on the frontend.
  required: false
  type: string
significant_bit:
  description: Specify which significant bit of the KNX value should be used.
  required: false
  type: integer
  default: 1
reset_after:
  description: Reset back to OFF state after specified milliseconds.
  required: false
  type: integer
{% endconfiguration %}

### 자동화 액션

이진 센서에 액션을 연결할 수도 있습니다 (예: 스위치를 눌렀을 때 조명 켜기). 이 예에서, 버튼을 한 번 누르면 하나의 조명이 켜지고, 버튼을 두 번 누르면 다른 하나가 켜집니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: knx
    name: Livingroom.3Switch3
    state_address: '5/0/26'
    automation:
      - counter: 1
        hook: 'on'
        action:
          - entity_id: light.hue_color_lamp_1
            service: homeassistant.turn_on
      - counter: 2
        hook: 'on'
        action:
          - entity_id: light.hue_bloom_1
            service: homeassistant.turn_on
          - entity_id: light.hue_bloom_2
            service: homeassistant.turn_on
```

{% configuration %}
name:
  description: A name for this device used within Home Assistant.
  required: false
  type: string
counter:
  description: Set to 2 if your only want the action to be executed if the button was pressed twice. To 3 for three times button pressed.
  required: false
  type: integer
  default: 1
hook:
  description: Indicates if the automation should be executed on what state of the binary sensor. Values are "on" or "off".
  required: false
  type: string
  default: "on"
action:
  description: Specify a list of actions analog to the [automation rules](/docs/automation/action/).
  required: false
  type: list
{% endconfiguration %}
