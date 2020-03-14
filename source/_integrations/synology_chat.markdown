---
title: 시놀로지 Chat(Synology Chat)
description: Instructions on how to add a Synology Chat Bot notifications to Home Assistant.
ha_release: 0.65
logo: synology.png
ha_category:
  - Notifications
---

`synology_chat` 알림 플랫폼을 사용하면 [Synology Chat](https://www.synology.com/en-us/dsm/feature/chat)를 설치해서 Synology Chat 봇으로 알림을 전달할 수 있습니다.

Synology Chat 봇을 설정하려면 먼저 [Synology Chat Integration Incoming Webhook](https://www.synology.com/en-us/knowledgebase/DSM/tutorial/Collaboration/How_to_configure_webhooks_and_slash_commands_in_Chat_Integration#t2.1) 을 만들어야합니다. 이 작업이 완료되면 Webhook URL이 생성됩니다. 이상의 내용이 홈어시스턴트 설정에 필요한 것들입니다.

설치시 Synology Chat 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 : 

```yaml
# Example configuration.yaml entry
notify:
  - platform: synology_chat
    name: hass_synchat
    resource: https://example.your.synology.com/webapi/entry.cgi?api=SYNO.Chat.External&method=incoming&version=1&token=ABCDEFG
```

{% configuration %}
name:
  description: "`name` 매개 변수를 설정하면 여러 알리미를 작성할 수 있습니다. 알리미는 서비스 `notify.NOTIFIER_NAME`에 바인딩합니다."
  required: true
  type: string
verify_ssl:
  description: HTTPS resources에 대한 SSL/TLS 검증(verification)을 해제해야 하는 경우 (자체 서명 된 인증서 등).
  required: false
  type: boolean
  default: true
resource:
  description: 수신 웹 후크 URL
  required: true
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오. 

Service Call의 예 :

```json
{"message": "This is a test message", 
 "data":{
     "file_url":"https://example.com/wp-content/uploads/sites/14/2011/01/cat.jpg"
     }
 }
```
