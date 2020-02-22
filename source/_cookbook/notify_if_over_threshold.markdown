---
title: "센서를 기반으로 알림 보내기"
description: "Basic example of how to send a templated notification if a sensor is over a given threshold"
ha_category: Automation Examples
---

다음 예는 센서가 임계값을 초과하면 pushbullet을 통해 알림을 보냅니다.

```yaml

notify me:
  platform: pushbullet
  api_key: "API_KEY_HERE"
  name: mypushbullet

automation:
  - alias: FanOn
    trigger:
      platform: numeric_state
      entity_id: sensor.furnace
      above: 2
    action:
      service: notify.mypushbullet
      data_template:
        title: "Furnace fan is running"
        message: "Fan running because current is {% raw %}{{ states('sensor.furnace') }}{% endraw %} amps"
```

해당 한계 아래로 다시 떨어질 때 알림을 받으려면 다음을 추가하십시오.

```yaml
  - alias: FanOff
    trigger:
      platform: numeric_state
      entity_id: sensor.furnace
      below: 2
    action:
      service: notify.mypushbullet
      data_template:
        title: "Furnace fan is stopped"
        message: "Fan stopped because current is {% raw %}{{ states('sensor.furnace') }}{% endraw %} amps"
```
