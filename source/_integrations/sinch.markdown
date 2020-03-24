---
title: 신치 SMS(Sinch SMS)
description: Instructions on how to add Sinch notifications to Home Assistant.
logo: sinch.png
ha_category:
  - Notifications
ha_release: 0.101
ha_codeowners:
  - '@bendikrb'
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/P2OCfXsSIU0" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`sinch` 플랫폼은 [Sinch](https://www.sinch.com/products/messaging/sms/)를 사용하여 Home Assistant에서 알림을 전달합니다.

## 전제 조건

[Sinch Dashboard](https://dashboard.sinch.com/sms/api/rest)로 이동하여 "Add new REST API"를 클릭하십시오. 이제 `service_plan_id`와`api_key`를 얻을 수 있습니다.

## 설정

설치시 Sinch를 추가하려면 Home Assistant `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - platform: sinch
    service_plan_id: SINCH_SERVICE_PLAN_ID
    api_key: SINCH_API_KEY
```

{% configuration %}
name:
  description: "Setting the optional parameter name allows multiple notifiers to be created. The default value is `Sinch`. The notifier will bind to the service `notify.NOTIFIER_NAME`."
  required: false
  type: string
service_plan_id:
  description: Your Sinch Service Plan ID.
  required: true
  type: string
api_key:
  description: Your API Token.
  required: true
  type: string
default_recipient:
  description: "A single or multiple phone numbers. This is where you want to send your SMS notification messages by default (when not specifying `target` in the service call), e.g., `09171234567` or `[09171234567, 09177654321]`."
  required: false
  type: [string, list]
sender:
  description: The name or number of the sender.
  required: false
  type: string
  default: 'Home Assistant'
{% endconfiguration %}

To use notifications, please see the [getting started with automation page](/getting-started/automation/).

### 전체 설정 예시

```yaml
# Example configuration.yaml entry
notify:
  - platform: sinch
    name: Sinch
    service_plan_id: SINCH_SERVICE_PLAN_ID
    api_key: SINCH_API_KEY
    default_recipient: [PHONE_NO1, PHONE_NO2]
    sender: Home Assistant
```
