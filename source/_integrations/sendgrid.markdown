---
title: 센드그리드(SendGrid)
description: Instructions on how to add email notifications via SendGrid to Home Assistant.
logo: sendgrid.png
ha_category:
  - Notifications
ha_release: 0.14
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/-Q-Aa8ggbIg" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`sendgrid` 알림 플랫폼은 검증된 클라우드 기반 이메일 플랫폼인 [SendGrid](https://sendgrid.com/)를 통해 이메일 알림을 보냅니다.

## 셋업

SendGrid의 [API 키](https://app.sendgrid.com/settings/api_keys)가 필요합니다.

## 설정

설치시 SendGrid를 통해 알림 이메일을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: sendgrid
    api_key: YOUR_API_KEY
    sender: SENDER_EMAIL_ADDRESS
    recipient: YOUR_RECIPIENT
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
api_key:
  description: Your SendGrid API key.
  required: true
  type: string
sender:
  description: The e-mail address of the sender.
  required: true
  type: string
sender_name:
  description: The name of the sender. Defaults to "Home Assistant" if not set.
  required: false
  type: string
recipient:
  description: The recipient of the notification.
  required: true
  type: string
{% endconfiguration %}

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.