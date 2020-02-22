---
title: "알림 메시지 보내기"
description: "Send a reminder"
ha_category: Automation Examples
---

Always forget to eat lunch? Let Home Assistant send you a reminder.
항상 점심을 식사를 잊습니까? 홈어시스턴트가 알림을 보내도록합니다.

Add a [notify platform](/integrations/notify/) of your choice.
선택한 [notify platform](/integrations/notify/)을 추가하십시오.

```yaml
notify:
  - platform: xmpp
    name: jabber
    sender: YOUR_JID
    password: YOUR_JABBER_ACCOUNT_PASSWORD
    recipient: YOUR_RECIPIENT
```

and automation part to your `configuration.yaml` file.

```yaml
automation:
  - alias: Send message at a given time
    trigger:
      platform: time
      at: '12:15:00'
    action:
      service: notify.jabber
      data:
        message: 'Time for lunch'
```
