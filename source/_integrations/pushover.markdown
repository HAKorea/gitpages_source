---
title: 푸시오버(Pushover)
description: Instructions on how to add Pushover notifications to Home Assistant.
logo: pushover.png
ha_category:
  - Notifications
ha_release: pre 0.7
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/zYrDOHn-CkA" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

[Pushover service](https://pushover.net/)는 알림 구성 요소를 위한 플랫폼입니다. 이를 통해 통합구성요소는 Pushover를 사용하여 사용자에게 메시지를 보낼 수 있습니다.

## 설정

API 키를 얻으려면 Pushover 웹사이트에서 [register an application](https://pushover.net/apps/clone/home_assistant)이 필요합니다. Pushover 사용자 키는 [Pushover dashboard](https://pushover.net/dashboard)에서 찾을 수 있습니다.

Pushover 알림을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: pushover
    api_key: YOUR_API_KEY
    user_key: YOUR_USER_KEY
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
api_key:
  description: Your API key.
  required: true
  type: string
user_key:
  description: Your user key for Pushover.
  required: true
  type: string
{% endconfiguration %}

Example Automation:

```yaml
- service: notify.entity_id
      data:
        message: "This is the message"
        title: "Title of message"
        data:
          url: "https://www.home-assistant.io/"
          sound: pianobar
          priority: 0
          attachment: "http://example.com/image.png"
```

중첩된 `data` 섹션의 구성 요소 별 값은 선택사항입니다.

`attachment` 매개 변수를 사용하여 이미지 첨부 파일을 추가할 수 있습니다. 이 매개 변수는 이미지의 유효한 URL (예: `http://example.com/image.png`) 또는 로컬 파일 레퍼런스(예: `/tmp/image.png`)입니다.

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.

알림을 보낼 때 Pushover [API documentation](https://pushover.net/api)에 따라 선택적 매개 변수를 설정할 수도 있습니다.

인텐트(intent)에 대해 Alexa 통합구성요소에서 트리거된 알림 예는 다음과 같이 메시지에 [Automation Templating](/getting-started/automation-templating/)을 사용합니다. : 

{% raw %}

```yaml
# Example configuration.yaml entries
alexa:
  intents:
    LocateIntent:
      action:
        service: notify.notify
        data_template:
          message: "The location of {{ User }} has been queried via Alexa."
        data:
          title: "Home Assistant"
          data:
            sound: falling
            device: pixel
            url: "https://www.home-assistant.io/"
            attachment: "/tmp/image.png"
```

{% endraw %}
