---
title: 이진입력(Input Boolean)
description: Instructions on how to integrate the Input Boolean integration into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.11
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`input_boolean`통합구성요소를 통해 사용자는 프론트 엔드에서 제어 할 수 있고 자동화 조건 내에서 사용할 수있는 boolean 값을 정의 할 수 있습니다. 예를 들어 특정 자동화를 비활성화하거나 활성화하는 데 사용할 수 있습니다.

설치에서 input boolean을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오

```yaml
# Example configuration.yaml entry
input_boolean:
  notify_home:
    name: Notify when someone arrives home
    initial: off
    icon: mdi:car
```

{% configuration %}
  input_boolean:
    description: 입력 별칭. 여러 항목이 허용됩니다.
    required: true
    type: map
    keys:
      name:
        description: 친숙한 입력 이름.
        required: false
        type: string
      initial:
        description: 홈어시스턴트 시작시 초기 값.
        required: false
        type: boolean
        default: false
      icon:
        description: 프런트 엔드에서 입력 요소 앞에 표시되는 아이콘입니다.
        required: false
        type: icon
{% endconfiguration %}

### Services

이 통합구성요소는 다음과 같은 서비스를 제공하여 `input_boolean`의 상태를 수정하고 홈어시스턴트 자체를 다시 시작하지 않고 설정합니다.

| Service | Data | Description |
| ------- | ---- | ----------- |
| `turn_on` | `entity_id(s)`<br>`area_id(s)` | 특정 `input_boolean` entities 값을 `on`으로
| `turn_off` | `entity_id(s)`<br>`area_id(s)` | 특정 `input_boolean` entities 값을 `off`로
| `toggle` | `entity_id(s)`<br>`area_id(s)` | 특정 `input_boolean` entities 값을 `Toggle`로
| `reload` | | `input_boolean` 설정 리로드 |

### Restore State

`initial` 에 유효한 값을 설정하면이 통합구성요소는 해당 값으로 설정된 상태로 시작됩니다. 그렇지 않으면, 홈어시스턴트 중지 이전의 상태를 복원합니다.

## Automation Examples

위의 `input_boolean`을 사용한 자동화의 예는 다음과 같습니다. 이 동작은 스위치가 켜져있는 경우에만 발생합니다. 

```yaml
automation:
  alias: Arriving home
  trigger:
    platform: state
    entity_id: binary_sensor.motion_garage
    to: 'on'
  condition:
    condition: state
    entity_id: input_boolean.notify_home
    state: 'on'
  action:
    service: notify.pushbullet
    data:
      title: ""
      message: "Honey, I'm home!"
```

자동화에서 `input_boolean.turn_on`,`input_boolean.turn_off` 또는 `input_boolean.toggle`을 사용하여 `input_boolean`의 상태를 설정하거나 변경할 수도 있습니다.

```yaml
    - service: input_boolean.turn_on
      data:
        entity_id: input_boolean.notify_home
```
