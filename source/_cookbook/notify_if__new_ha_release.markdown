---
title: "새로운 홈어시스턴트가 출시되면 알림 보내기"
description: "Basic example of how to send a notification if a new Home Assistant release is available"
ha_category: Automation Examples
---

다음 예는 새로운 홈어시스턴트 릴리스가 사용 가능한 경우 XMPP를 통해 알림을 보냅니다. : 

```yaml
notify:
  - platform: xmpp
    name: jabber
    sender: sender@jabber.org
    password: !secret xmpp_password
    recipient: recipient@jabber.org

automation:
  - alias: Update notification
    trigger:
      - platform: state
        entity_id: binary_sensor.updater
        from: 'off'
        to: 'on'
    action:
      - service: notify.jabber
        data:
          message: 'There is a new Home Assistant release available.'
```

원하는 경우 [templates](/topics/templating/)를 사용하여 Home Assistant의 릴리즈 번호를 포함할 수 있습니다. 다음 예는 [Pushbullet](/integrations/pushbullet)을 통해 메시지에 홈어시스턴트 버전으로 알림을 보냅니다.

```yaml
notify:
  - platform: pushbullet
    api_key: 'YOUR_KEY_HERE'
    name: pushbullet

automation:
  - alias: Update notification
    trigger:
      - platform: state
        entity_id: binary_sensor.updater
        from: 'off'
        to: 'on'
    action:
      - service: notify.pushbullet
        data_template: 
          title: 'New Home Assistant Release'
          target: 'YOUR_TARGET_HERE' #See Pushbullet integration for usage
          message: "Home Assistant {% raw %} {{ state_attr('binary_sensor.updater', 'newest_version') }} {% endraw %} is now available."
```

