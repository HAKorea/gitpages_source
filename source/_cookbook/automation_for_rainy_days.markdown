---
title: "비오는 날 자동화"
description: "Basic example how to use weather conditions to set states"
ha_category: Automation Examples
---

비가오고 있는지를 알려주는 'precip_intensity'조건이 있는 [Dark Sky](/integrations/darksky) 센서가 필요합니다. `cloud_cover`와 같은 다른 속성으로 실험 할 수도 있습니다.

비가 올 때, 누군가 집에 있고, 오후 혹은 그 이후에 거실의 조명을 켜십시오.

```yaml
automation:
  - alias: 'Rainy Day'
    trigger:
      - platform: state
        entity_id: sensor.precip_intensity
        to: 'rain'
    condition:
      - condition: state
        entity_id: all
        state: 'home'
      - condition: time
        after: '14:00'
        before: '23:00'
    action:
      service: light.turn_on
      entity_id: light.couch_lamp
```

물론 비가 오지 않을 때는 램프를 끄십시오. 단, 일몰 전 1 시간 이내에 있어야합니다.

```yaml
  - alias: 'Rain is over'
    trigger:
      - platform: state
        entity_id: sensor.precip_intensity
        to: 'None'
    condition:
      - condition: sun
        after: 'sunset'
        after_offset: '-01:00:00'
    action:
      service: light.turn_off
      entity_id: light.couch_lamp
```

