---
title: 올인원알림서비스(Apprise)
description: Instructions on how to add Apprise notifications to Home Assistant.
logo: apprise.png
ha_category:
  - Notifications
ha_release: 0.101
ha_codeowners:
  - '@caronc'
---

[Apprise 서비스](https://github.com/caronc/apprise/)는 _거의 모든 알림 플랫폼_ 에 Home Assistant를 연결할 수 있는 올인원 솔루션입니다. (예 : Amazon SNS, Discord, Telegram, Slack, MSTeams, Twilio 등)

Apprise 지원 알림을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry using URLs
notify:
  - platform: apprise
    url: YOUR_APPRISE_URLS
```

원격 또는 로컬로 저장하는 동안 고유한 설정 파일을 미리 정의 할 수도 있습니다. `config` 옵션 만 사용하면됩니다.

```yaml
# Example configuration.yaml entry using externally located Apprise
# Configuration Files/Sites:
notify:
  - platform: apprise
    config: YOUR_APPRISE_CONFIG_URLS
```

정의하려는 URL 또는 Apprise 설정 위치 수에는 제한이 없습니다. 두 줄을 서로 함께 사용할 수도 있습니다.

```yaml
# Example configuration.yaml entry using all options
notify:
  - platform: apprise
    config: YOUR_APPRISE_CONFIG_URLS
    url: YOUR_APPRISE_URLS
```

{% configuration %}
name:
  description: The notifier will bind to the service `notify.NAME`.
  required: false
  type: string
  default: notify
url:
  description: One or more Apprise URLs
  required: false
  type: string
config:
  description: One or more Apprise Configuration URLs
  required: false
  type: string
{% endconfiguration %}

#### service call 사례

```yaml
- service: notify.apprise
  data:
    message: "A message from Home Assistant"
```

설정 파일을 사용하여 Apprise URL을 저장하는 경우 태그를 연관시키는 추가 보너스가 있습니다. 기본적으로 홈어시스턴트의 Apprise는 연관된 태그가 없는 요소에만 알립니다. 다음과 같이 할당한 태그를 기반으로 특정 서비스에만 알리는 데 집중할 수 있습니다.

```yaml
- service: notify.apprise
  data:
    message: "A message from Home Assistant"
    target: [
      "tag_name1",
    ]
```

`all` 태그는 URL과 관련된 태그가 있는지 여부에 관계없이 모든 것을 완전히 알리도록 예약되어 있습니다.

### 참고

Apprise는 50 가지가 넘는 지원 알림 서비스를 지원합니다. 각각에는 활용할 수 있는 자체 조정 및 사용자 정의가 있습니다.

- URL을 구성하는 방법에 대한 지침을 보려면 [여기](https://github.com/caronc/apprise/wiki#notification-services)를 방문하십시오.
- 자신의 Apprise 설정 파일 (`config` 가이드를 통해 참조)을 사용자 정의하는 방법에 대한 지침은 다음을 확인하십시오.
   - [Text Formatted URLs](https://github.com/caronc/apprise/wiki/config_text)
   - [YAML Formatted URLs](https://github.com/caronc/apprise/wiki/config_yaml)
