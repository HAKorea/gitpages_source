---
title: "RFLink Switch"
description: "Instructions on how to integrate RFLink switches into Home Assistant."
logo: rflink.png
ha_category:
  - Switch
ha_release: 0.38
---

`rflink` 통합구성요소는 [RFLink gateway firmware](http://www.nemcon.nl/blog2/)를 사용하는 장치 (예: [Nodo RFLink 게이트웨이](https://www.nodo-shop.nl/nl/21-rflink-gateway))를 지원합니다. RFLink 게이트웨이는 저렴한 하드웨어 (Arduino + 트랜시버)를 사용하여 여러 RF 무선 장치와 양방향 통신을 가능하게하는 Arduino 펌웨어입니다.

먼저 [RFLink hub](/integrations/rflink/)를 설정해야합니다.

RFLink 통합구성요소는 `switch`, `binary_sensor` 및 `light`의 차이점을 모릅니다. 따라서 모든 전환 가능한 장치는 기본적으로 자동으로 `light`로 추가됩니다. 

RFLink binary_sensor/switch/light ID는 protocol, id, switch/channel로 구성됩니다. (예: `newkaku_0000c6c2_1`)

스위치의 ID를 알면 HA에서 스위치 유형으로 설정하고 예를 들어 다른 그룹에 추가하거나 숨기거나 멋진 이름을 설정하는데 사용할 수 있습니다.

장치를 스위치로 설정 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: rflink
    devices:
      newkaku_0000c6c2_1: {}
      conrad_00785c_0a: {}
```

{% configuration %}
device_defaults:
  description: The defaults for the devices.
  required: false
  type: map
  keys:
    fire_event:
      description: Set default `fire_event` for RFLink switch devices (see below).
      required: false
      default: False
      type: boolean
    signal_repetitions:
      description: Set default `signal_repetitions` for RFLink switch devices (see below).
      required: false
      default: 1
      type: integer
devices:
  description: A list of switches.
  required: false
  type: list
  keys:
    rflink_ids:
      description: RFLink ID of the device
      required: true
      type: map
      keys:
        name:
          description: Name for the device.
          required: false
          default: RFLink ID
          type: string
        aliases:
          description: Alternative RFLink ID's this device is known by.
          required: false
          type: [list, string]
        group_aliases:
          description: "`aliases` which only respond to group commands."
          required: false
          type: [list, string]
        no_group_aliases:
          description: "`aliases` which do not respond to group commands."
          required: false
          type: [list, string]
        fire_event:
          description: Fire a `button_pressed` event if this device is turned on or off.
          required: false
          default: false
          type: boolean
        signal_repetitions:
          description: Set default `signal_repetitions` for RFLink switch devices (see below).
          required: false
          default: 1
          type: integer
        group:
          description: Allow switch to respond to group commands (ALLON/ALLOFF).
          required: false
          default: true
          type: boolean
        aliases:
          description: Alternative RFLink ID's this device is known by.
          required: false
          type: [list, string]
        group_aliases:
          description: "`aliases` which only respond to group commands."
          required: false
          type: [list, string]
        no_group_aliases:
          description: "`aliases` which do not respond to group commands."
          required: false
          type: [list, string]
{% endconfiguration %}

## Switch state

처음에는 스위치 상태를 알 수 없습니다. 스위치가 켜지거나 꺼질 때 (프론트 엔드 또는 무선 리모트를 통해) 상태가 알려져 있으며 프론트 엔드에 표시됩니다.

때때로 스위치는 여러 무선 리모컨으로 제어되며 각 리모컨에는 스위치에 자체 코드가 프로그래밍되어 있습니다. 다른 리모컨을 통해 스위치를 제어했을때 상태를 추적하려면 해당하는 원격 코드를 별명(aliases)으로 추가하십시오. : 

```yaml
# Example configuration.yaml entry
switch:
  - platform: rflink
    devices:
      newkaku_0000c6c2_1:
        name: Ceiling fan
        aliases:
          - newkaku_000000001_2
          - kaku_000001_a
```

alias ID의 모든 on/off 명령은 스위치의 현재 상태를 업데이트합니다. 그러나 프런트 엔드를 통해 명령을 보낼 때는 primary ID 만 사용됩니다.

## 장치 지원

[장치 지원](/integrations/rflink/#device-support) 참조하십시오. 

### 추가 설정 사례 

신호 반복 및 사용자 정의 이름을 가진 여러 스위치

```yaml
# Example configuration.yaml entry
switch:
  - platform: rflink
    device_defaults:
      fire_event: true
      signal_repetitions: 2
    devices:
      newkaku_0000c6c2_1:
        name: Ceiling fan
      conrad_00785c_0a:
        name: Motion sensor kitchen
```
