---
title: "재실 여부에 따라 알림을 보내는 예"
description: "Examples sending notification depending of the presence"
ha_category: Automation Examples
---

알려진 장치 목록의 누군가가 로컬 네트워크에 연결하면 메시지가 전송됩니다. 다시 말해 누군가가 집에 도착했을 때입니다. [Nmap](/integrations/nmap_tracker) 장치 추적기 또는 이와 유사한 통합구성요소를 사용하는 경우에만 작동합니다.

이 예에서는 [Telegram](/integrations/telegram)을 사용하여 알림을 보냅니다.

```yaml
notify:
  - name: Telegram
    platform: telegram
    api_key: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    chat_id: xxxxxxxxx
```

자동화 규칙을 추가하십시오. 추적하려는 장치와 일치하도록 `device_name_here`를 변경하십시오 .

```yaml
automation:
  trigger:
    platform: state
    entity_id: device_tracker.device_name_here
    from: 'not_home'
    to: 'home'
  action:
    service: notify.Telegram
    data:
      message: 'Person is now home'
```
