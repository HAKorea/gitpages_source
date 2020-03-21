---
title: 메신저연동(MessageBird)
description: Instructions on how to add user notifications to Home Assistant.
logo: message_bird.png
ha_category:
  - Notifications
ha_release: 0.16
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/V7eUf2UsO4Q" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`MessageBird` 알림 플랫폼은 [MessageBird](https://www.messagebird.com/)를 사용하여 SMS 메시지로 알림을 휴대폰으로 보냅니다.

## 셋업

API 키를 검색하려면 https://www.messagebird.com/으로 이동하십시오.

## 설정

설치시 MessageBird 알림을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: message_bird
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your MessageBird API key.
  required: true
  type: string
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
sender:
  description: Setting the optional parameter `sender`. This will be the sender of the SMS. It may be either a telephone number (e.g., `+4915112345678`) or a text with a maximum length of 11 characters.
  required: false
  default: HA
  type: string
{% endconfiguration %}

### 사용법

MessageBird는 알림 플랫폼이므로 알림 서비스 [as described here](/integrations/notify/)를 호출하여 제어할 수 있습니다. 지정된 휴대폰 번호로 알림을 보냅니다.

#### 서비스 페이로드 사례

```json
{
  "message": "A message for many people",
  "target": [ "+49123456789", "+43123456789" ]
}
```
