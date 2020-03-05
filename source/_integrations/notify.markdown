---
title: 알림(Notifications)
description: Instructions on how to add user notifications to Home Assistant.
logo: home-assistant.png
ha_category:
  - Notifications
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`notify` 통합구성요소로 다양한 플랫폼에 notification을 보낼 수 있습니다. 이를 사용하려면 하나 이상의 notification 대상인 notify를 설정해야합니다. [integrations list](/integrations/#notifications) 사용 사례에 맞는 알림 대상을 확인하십시오.

Home Assistant 웹 인터페이스에 notification을 보내려면 [Persistent Notification integration](/integrations/persistent_notification/)을 사용할 수 있습니다.

## 서비스

`notify` 플랫폼은 일단 로드되면 알림(notifications)을 보내기 위해 호출할 수있는 서비스를 노출합니다

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `message`              |       no | notification 본문.
| `title`                |      yes | notification 제목.
| `target`               |      yes | 일부 플랫폼에서는 notification을 받을 수신자를 지정할 수 있습니다. 지원되는 경우 플랫폼 페이지를 참조하십시오.
| `data`                 |      yes | 기능이 확장된 플랫폼에서. 지원되는 경우 플랫폼 페이지를 참조하십시오.

notify 통합구성요소는 `data_template`으로 [templates](/topics/templating/) 지정을 지원합니다. 
이를 통해 notifications에 현재 홈어시스턴트 상태를 사용할 수 있습니다.

[automation setup](/getting-started/automation/)의 [action](/getting-started/automation-action/)에서 사용자정의 된 주제를 사용하면 다음과 같이 보일 수 있습니다.

```yaml
action:
  service: notify.notify
  data:
    message: "Your message goes here"
    title: "Custom subject"
```

### 작동하는지 테스트

[notifier](/integrations/#notifications)를 설정 한 후 notify 플랫폼을 올바르게 설정했는지 테스트하는 간단한 방법은 사이드 바에서 **개발자 도구**를 연 다음 **Service** 탭을 선택하는 것입니다. **Service** 드롭 다운 메뉴에서 서비스를 선택하고 **Service Data** 필드에 아래 샘플을 입력 한 다음 **CALL SERVICE** 버튼을 누릅니다.

```json
{
  "message": "The sun is {% raw %}{% if is_state('sun.sun', 'above_horizon') %}up{% else %}down{% endif %}{% endraw %}!"
}
```

자동화에 상응하는 내용은 다음과 같습니다. :

```yaml
action:
  service: notify.notify
  data_template:
    message: "The sun is {% raw %}{% if is_state('sun.sun', 'above_horizon') %}up{% else %}down{% endif %}{% endraw %}!"
```

이미지 전송을 지원하는 서비스의 경우.

```json
{ "message": "Test plugin",
  "data": {
    "photo": {
        "url": "http://www.gbsun.de/gbpics/berge/berge106.jpg"
    }
  }
}
```

자동화에 상응하는 내용은 다음과 같습니다.

```yaml
action:
  service: notify.notify
  data:
    message: "Test plugin"
    data:
      photo:
        url: "http://www.gbsun.de/gbpics/berge/berge106.jpg"
```


서비스가 위치 전송을 지원하면 이 샘플의 데이터를 사용할 수 있습니다.

```json
{ "message": "Test plugin",
  "data": {
    "location": {
      "latitude": 7.3284,
      "longitude": 46.38234
    }
  }
}
```

자동화에 상응하는 내용은 다음과 같습니다.

```yaml
action:
  service: notify.notify
  data:
    message: "Test plugin"
    data:
      location:
        latitude: 7.3284
        longitude: 46.38234
```
