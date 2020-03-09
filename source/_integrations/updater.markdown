---
title: 업데이터(Updater)
description: Detecting when Home Assistant updates are available.
logo: home-assistant.png
ha_category:
  - Binary Sensor
ha_release: 0.8
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`updater` 바이너리 센서는 매일 새로운 릴리스를 확인합니다. 업데이트가 가능하면 상태가 "on"이 됩니다. 그렇지 않으면 상태가 "off"가 됩니다. 최신 버전과 릴리스 정보에 대한 링크는 Updater의 속성입니다. [Hass.io](/hassio/)에는 자체 출시 일정이 있으므로 **Hass.io에서 이 센서를 사용하는 것은 의미가 없습니다.**

updater 통합구성요소는 실행중인 Home Assistant 인스턴스 및 해당 환경에 대한 기본 정보도 수집합니다. 이 정보에는 현재 홈어시스턴트 버전, 시간대, Python 버전 및 운영 체제 정보가 포함됩니다. 식별 가능한 정보 (예: IP 주소, GPS 좌표 등)는 수집되지 않습니다. 개인 정보가 걱정된다면 Python [source code](https://github.com/home-assistant/home-assistant/tree/dev/homeassistant/components/updater)를 면밀히 조사해보십시오.

<div class='note'>

`updater` 바이너리 센서는 시작 후 첫 번째 업데이트를 수행 할 때까지 1 시간 동안 기다립니다. 이 기간 동안 `unavailable` 상태가됩니다. 그런 다음 하루에 한 번 새로운 릴리스를 확인합니다.

</div>

## 설정

본 통합구성요소는 설정에서 [`default_config:`](https://www.home-assistant.io/integrations/default_config/) 행을 비활성화하거나 제거하지 않은 한 기본적으로 활성화되어 있습니다. 이 경우 다음 예는 이 연동을 수동으로 활성화하는 방법을 보여줍니다.

```yaml
updater:
```

{% configuration %}
reporting:
  description: Whether or not to share system information when checking for updates.
  required: false
  type: boolean
  default: true
include_used_components:
  description: Whether or not to report the integrations that you are using in Home Assistant.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

Updater의 데이터에 대한 자세한 내용은 [detailed overview](/docs/backend/updater/)를 확인하십시오. 업데이트를 확인할 때 정보를 공유하지 않기로 선택한 경우 `reporting: false`를 설정할 수 있습니다.

사용중인 연동상황을 Home Assistant 개발자에게보고 할 수 있습니다. 이것은 그들이 관심있는 것들을 개선하는데 집중할 수 있도록 도와 줄 것입니다. 이 옵션을 활성화하려면 `include_used_components: true`를 추가해야합니다.

```json
"components": [
    "apcupsd",
    "api",
    "automation",
    "binary_sensor",
    "binary_sensor.zwave",
    "camera",
    "camera.uvc",
    "config",
    "config.core",
    ...
]
```

## 알림(Notification)

보너스를 추가하기 위해 이 구성 요소 엔티티의 상태가 변경될 때 notifier와 함께 메시지를 보내도록 자동화 연동을 작성할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
automation:
  alias: Update Available Notification
  trigger:
    - platform: state
      entity_id: binary_sensor.updater
      from: 'off'
      to: 'on'
  action:
    - service: notify.notify
      data_template:
        message: "Home Assistant {{ state_attr('binary_sensor.updater', 'newest_version') }} is available."
```
{% endraw %}
