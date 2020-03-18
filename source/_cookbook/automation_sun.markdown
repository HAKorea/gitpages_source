---
title: "태양을 사용하는 예시"
description: "Automation examples that use the sun."
ha_category: Automation Examples
---

#### 집에 사람이 있는 경우 일몰 45분전에 거실조명 켜기.

```yaml
automation:
  trigger:
    platform: sun
    event: sunset
    offset: "-00:45:00"
  condition:
    condition: state
    entity_id: all
    state: home
  action:
    service: light.turn_on
    entity_id: group.living_room_lights
```

#### 기상시간에 맞춰 자연스런 조명 연출하기 

_필립스 Hue와 LIFX는 현재 transition을 지원하는 유일한 조명 플랫폼입니다._

```yaml
automation:
  trigger:
    platform: time
    at: "07:15:00"
  action:
    service: light.turn_on
    entity_id: light.bedroom
    data:
      # 900 seconds = 15 minutes
      transition: 900
```

#### 태양 일출/일몰 알림 보내기

태양 상태가 변경되면 [PushBullet](/integrations/pushbullet)을 통해 알림을 보냅니다 .

```yaml
automation:
  - alias: 'Send notification when sun rises'
    trigger:
      platform: sun
      event: sunrise
      offset: '+00:00:00'
    action:
      service: notify.pushbullet
      data:
        message: 'The sun is up.'
  - alias: 'Send notification when sun sets'
    trigger:
      platform: sun
      event: sunset
      offset: '+00:00:00'
    action:
      service: notify.pushbullet
      data:
        message: 'The sun is down.'
```

#### 태양 고도에 따른 조명 및 블라인드 자동화

태양 기반 자동화는 시간 기반 오프셋(offset)을 사용하는 것보다 계절에따라 더 잘 변하기 때문에 일몰/일출의 오프셋에 대처하는 것이 낫습니다.

```yaml
- alias: 'Turn a few lights on when the sun gets dim'
  trigger:
    platform: numeric_state
    entity_id: sun.sun
    value_template: "{% raw %}{{ state_attr('sun.sun', 'elevation') }}{% endraw %}"
    below: 3.5
  action:
    service: scene.turn_on
    entity_id: scene.background_lights

- alias: 'Turn more lights on as the sun gets dimmer'
  trigger:
    platform: numeric_state
    entity_id: sun.sun
    value_template: "{% raw %}{{ state_attr('sun.sun', 'elevation') }}{% endraw %}"
    below: 1.5
  action:
    service: scene.turn_on
    entity_id: scene.more_lights

- alias: 'Close blind at dusk'
  trigger:
    platform: numeric_state
    entity_id: sun.sun
    value_template: "{% raw %}{{ state_attr('sun.sun', 'elevation') }}{% endraw %}"
    below: -2.5
  action:
    service: switch.turn_off
    entity_id: switch.blind

```
