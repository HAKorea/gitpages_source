---
title: 프롤(Prowl)
description: Instructions on how to add Prowl notifications to Home Assistant.
logo: prowl.png
ha_category:
  - Notifications
ha_release: 0.52
---

`prowl` 플랫폼은 [Prowl](https://www.prowlapp.com/)을 사용하여 Home Assistant에서 iOS 장치로 푸시 알림을 전달합니다.

[Prowl website](https://www.prowlapp.com/)로 이동하여 새 API 키를 작성하십시오.

설치에 Prowl 알림을 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
notify:
  - name: NOTIFIER_NAME
    platform: prowl
    api_key: YOUR_API_KEY
```

{% configuration %}
name:
  description: Setting the optional parameter `name` allows multiple notifiers to be created. The notifier will bind to the service `notify.NOTIFIER_NAME`.
  required: false
  default: notify
  type: string
api_key:
  description: The Prowl API key to use.
  required: true
  type: string
{% endconfiguration %}

### Prowl 서비스 데이터

확장된 기능을 위해 다음과 같은 속성을 `data`로 배치할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `priority`             |      yes | Priority level, for more info refer to the [Prowl API documentation](https://www.prowlapp.com/api.php#add). |

알림을 사용하려면 [getting started with automation page](/getting-started/automation/)를 참조하십시오.