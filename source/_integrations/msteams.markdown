---
title: 마이크로소프트 Teams
description: Instructions on how to send a notification to a Microsoft Teams channel.
logo: msteams.jpg
ha_category:
  - Notifications
ha_release: 0.101
ha_codeowners:
  - '@peroyvind'
---

`Microsoft Teams` 플랫폼을 사용하면 Home Assistant에서 [Microsoft Teams](https://products.office.com/en-us/microsoft-teams/group-chat-software)의 팀 채널로 알림을 보낼 수 있습니다.

## 셋업

팀에 알림을 보내려면 들어오는 Webhook 앱을 팀 채널에 추가해야합니다. 앱이 추가되면 `configuration.yaml`에 추가해야하는 웹 후크 URL을 받게됩니다.

## 설정

설치에 Microsoft Teams 플랫폼을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
notify:
  - platform: msteams
    url: https://outlook.office.com/webhook/<ID>
```

{% configuration %}
name:
  description: Setting this parameter allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  type: string
  default: "notify"
url:
  description: The webhook URL created in the setup step.
  required: true
  type: string
{% endconfiguration %}

### Microsoft Teams 서비스 데이터

확장된 기능을 위해 다음 속성을 `data`에 배치할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `image_url`            |      yes | Attach an image to the message.

URL에서 파일을 게시하는 예 :

```yaml
title: Title of the message.
message: Message that will be added.
data:
  image_url: URL_OF_IMAGE
```
