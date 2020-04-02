---
title: "enocean 스위치로 Philips Hue 제어"
description: "Automation to switch a Philips Hue lamp with an enocean switch."
ha_category: Automation Examples
---

enocean 벽스위치와 일부 Philips Hue 램프가 있다고 가정하십시오. enocean 벽스위치는 button_pressed 이벤트를 발생시키고 램프를 켜고 끄는데 사용되는 여러 매개 변수를 전달합니다. 

event_data:

* which
* pushed
* onoff
* id
* devname

```yaml
enocean:
  device: /dev/ttyUSB0

binary_sensor:
  - platform: enocean
    id: [0x00,0x01,0x02,0x03]
    name: living_room_switch

automation:
  - alias: Turn on living room light
    trigger:
      platform: event
      event_type: button_pressed
      event_data:
        onoff: 1
        devname: living_room_switch
    action:
      service: light.turn_on
      entity_id: light.hue_color_lamp_3

  - alias: Turn off living room light
    trigger:
      platform: event
      event_type: button_pressed
      event_data:
        onoff: 0
        devname: living_room_switch
    action:
      service: light.turn_off
      entity_id: light.hue_color_lamp_3
```
