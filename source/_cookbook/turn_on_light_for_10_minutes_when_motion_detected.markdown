---
title: "모션 감지 후 10분 동안 조명 켜기"
description: "Turn on lights for 10 minutes when motion detected."
ha_category: Automation Examples
---

#### 재설정 가능한 꺼짐 타이머로 조명 켜기

이 레시피는 모션이있을 때 조명을 켜고 모션 이벤트없이 10 분이 지나면 조명을 끕니다.

```yaml
automation:
- alias: Turn on kitchen light when there is movement
  trigger:
    platform: state
    entity_id: sensor.motion_sensor
    to: 'on'
  action:
    service: light.turn_on
    entity_id: light.kitchen_light

- alias: Turn off kitchen light 10 minutes after last movement
  trigger:
    platform: state
    entity_id: sensor.motion_sensor
    to: 'off'
    for:
      minutes: 10
  action:
    service: light.turn_off
    entity_id: light.kitchen_light
```

또는 여러 센서/트리거의 경우 :

```yaml
automation:
- alias: Turn on hallway lights when the doorbell rings, the front door opens or if there is movement
  trigger:
  - platform: state
    entity_id: sensor.motion_sensor, binary_sensor.front_door, binary_sensor.doorbell
    to: 'on'
  action:
  - service: light.turn_on
    data:
      entity_id:
        - light.hallway_0
        - light.hallway_1
  - service: timer.start
    data:
      entity_id: timer.hallway

- alias: Turn off hallway lights 10 minutes after trigger
  trigger:
    platform: event
    event_type: timer.finished
    event_data:
      entity_id: timer.hallway
  action:
    service: light.turn_off
    data:
      entity_id:
        - light.hallway_0
        - light.hallway_1

timer:
  hallway:
    duration: '00:10:00'
```

또한 시간에 따라 조명이 켜지지 않도록 제한하고 페이딩 조명을 켜고 끄는 전환을 구현할 수도 있습니다. :

```yaml
- alias: Motion Sensor Lights On
  trigger:
    platform: state
    entity_id: binary_sensor.ecolink_pir_motion_sensor_sensor
    to: 'on'
  condition: 
    condition: time
    after: '07:30'
    before: '23:30'
  action:
    service: homeassistant.turn_on
    entity_id: group.office_lights
    data: 
      transition: 15


- alias: Motion Sensor Lights Off
  trigger:
    - platform: state
      entity_id: binary_sensor.ecolink_pir_motion_sensor_sensor
      to: 'off'
      for:
        minutes: 15
  action:
    - service: homeassistant.turn_off
      entity_id: group.office_lights
      data: 
        transition: 160
```
