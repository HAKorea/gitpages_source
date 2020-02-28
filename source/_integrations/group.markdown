---
title: 그룹(group)
description: Instructions on how to setup groups within Home Assistant.
logo: home-assistant.png
ha_category:
  - Organization
ha_release: pre 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

Groups을 통해 사용자는 여러 entity를 하나로 결합 할 수 있습니다.

**Developer Tools** 에서 **States** <img src='/images/screenshots/developer-tool-states-icon.png' class='no-shadow' height='38' /> 페이지를 확인하고 **Current entities:** 를 탐색합니다. : 사용할 수있는 모든 entities에 대한 목록이 나옵니다.

```yaml
# Example configuration.yaml entry
group:
  kitchen:
    name: Kitchen
    entities:
      - switch.kitchen_pin_3
  climate:
    name: Climate
    entities:
      - sensor.bedroom_temp
      - sensor.porch_temp
  awesome_people:
    name: Awesome People
    entities:
      - device_tracker.dad_smith
      - device_tracker.mom_smith
```

{% configuration %}
name:
  description: 그룹 이름.
  required: false
  type: string
entities:
  description: 배열 또는 쉼표로 구분 된 문자열, 그룹화 할 entity 목록.
  required: true
  type: list
all:
  description: 만일 **all** 그룹화된 entity들이 *on* 명령을 내리면, 반드시 group 상태도 *on*이 되야할 경우 `true`로 설정.
  required: false
  type: boolean
  default: false
icon:
  description: 프런트 엔드에 표시되는 아이콘입니다.
  required: false
  type: string
{% endconfiguration %}

## Group behavior

기본적으로 어떤 group의 구성원이 `on`일 경우 group은 모두 on 입니다. device tracker와 마찬가지로, 한 group의 구성원이 `home`일 경우 group은 `home`을 나타냅니다.
만일  `all` 옵션을 `true`로 세팅했다면, 이 행위는 모든 group이 `on` 상태가 되고 역시 마찬가지로 모든 group의 멤버들은 `on`을 실행하게 됩니다.
