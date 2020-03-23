---
title: 클릭샌드 SMS(ClickSend SMS)
description: Instructions on how to add ClickSend notifications to Home Assistant.
logo: clicksend.png
ha_category:
  - Notifications
ha_release: 0.48
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/puuK07yPbsw" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`clicksend` 플랫폼은 [ClickSend](https://clicksend.com)를 사용하여 Home Assistant에서 알림을 전달합니다.

## 전제 조건

[ClickSend Dashboard](https://dashboard.clicksend.com) 섹션으로 이동하여 새 프로젝트를 작성하십시오. 프로젝트를 만든 후에는 `username`과 `api_key`를 얻을 수 있습니다.

## 설정

ClickSend를 설치에 추가하려면 Home Assistant `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: clicksend
    name: ClickSend
    username: CLICKSEND_USERNAME
    api_key: CLICKSEND_API_KEY
    recipient: PHONE_NO
    
# Multiple recipients
notify:
  - platform: clicksend
    name: ClickSend
    username: CLICKSEND_USERNAME
    api_key: CLICKSEND_API_KEY
    recipient: [PHONE_NO1, PHONE_NO2]
```

{% configuration %}
name:
  description: "Setting the optional parameter name allows multiple notifiers to be created. The default value is `ClickSend`. The notifier will bind to the service `notify.NOTIFIER_NAME`."
  required: false
  type: string
username:
  description: Your Clicksend username.
  required: true
  type: string
api_key:
  description: Your Clicksend API Key.
  required: true
  type: string
recipient:
  description: "A single or multiple phone numbers. This is where you want to send your SMS notification messages, e.g., `09171234567` or `[09171234567, 09177654321]`."
  required: true
  type: [string, list]
sender:
  description: The name or number of the sender.
  required: false
  type: string
  default: 'hass'
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.