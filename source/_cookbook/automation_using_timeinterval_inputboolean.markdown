---
title: "시간간격과 Input_boolean 사용"
description: "Automation to get a random color every 2 minutes that can be turned on/off."
ha_category: Automation Examples
---

#### input_boolean 상태에 따라 Hue 조명을 일정 시간 간격으로 임의의 색상으로 변경

_Note, 필립스 Hue는 현재 Random Effect를 지원하는 유일한 조명 플랫폼._

```yaml
input_boolean:
  loop_livingcolors:
    name: Loop LivingColors
    initial: off
    icon: mdi:spotlight

automation:
# Changes Hue light every two minutes to random color if input boolean is set to on
- alias: 'Set LivingColors to random color'
  trigger:
    platform: time_pattern
    minutes: '/2'
  condition:
    condition: state
    entity_id: input_boolean.loop_livingcolors
    state: 'on'
  action:
    service: light.turn_on
    entity_id: light.woonkamer_livingcolors
    data:
      effect: random
      transition: 5
      brightness: 255
```
