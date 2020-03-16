---
title: 심플리세이프(SimpliSafe)
description: Instructions on how to integrate SimpliSafe into Home Assistant.
logo: simplisafe.png
ha_release: 0.81
ha_category:
  - Alarm
  - Lock
ha_config_flow: true
ha_codeowners:
  - '@bachya'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/FV6603-j27k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`simplisafe` 통합구성요소는 [SimpliSafe home security](https://simplisafe.com) (V2 및 V3) 시스템을 Home Assistant에 연동합니다. 여러 개의 SimpliSafe 계정을 수용할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Alarm Control Panel**: 현재 경보 상태를 보고하고 시스템을 arm 및 disarm하는데 사용할 수 있습니다.
- **Lock**: `Door Locks`에 대해 보고하며 lock을 lock 및 unlock하는 데 사용할 수 있습니다.

## 설정

이 구성요소를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
simplisafe:
  accounts:
    - username: user@email.com
      password: password123
```

{% configuration %}
username:
  description: The email address of a SimpliSafe account.
  required: true
  type: string
password:
  description: The password of a SimpliSafe account.
  required: true
  type: string
code:
  description: A code to enable or disable the alarm in the frontend.
  required: false
  type: string
{% endconfiguration %}

## 서비스

아래의 서비스 호출에 필요한 `system_id` 매개 변수는 연동한 `alarm_control_panel` 엔티티에 대한 장치 상태 속성을 보면 알 수 있습니다.

### `simplisafe.remove_pin`

SimpliSafe PIN을 제거하십시오 (label 또는 PIN 값 기준).

| Service Data Attribute    | Optional | Description                                 |
|---------------------------|----------|---------------------------------------------|
| `system_id`                 |      no  | The ID of a SimpliSafe system               | 
| `label_or_pin`              |      no  | The PIN label or value to remove            |

### `simplisafe.set_pin`

SimpliSafe PIN을 설정하십시오.

| Service Data Attribute    | Optional | Description                                 |
|---------------------------|----------|---------------------------------------------|
| `system_id`                 |      no  | The ID of the system to remove the PIN from |
| `label`                     |      no  | The label to show in the SimpliSafe UI      |
| `pin`                       |      no  | The PIN value to use                        |

### `simplisafe.system_properties`

하나 이상의 시스템 속성을 설정하십시오.

볼륨을 나타내는 모든 속성에는 다음값을 사용해야합니다.

* Off: `0`
* Low: `1`
* Medium: `2`
* High: `3`

| Service Data Attribute    | Optional | Description                                                                  |
|---------------------------|----------|------------------------------------------------------------------------------|
| `system_id`                 |      no  | The ID of a SimpliSafe system                                                | 
| `alarm_duration`            |      yes | The number of seconds a triggered alarm should sound                         |
| `chime_volume`              |      yes | The volume of the door chime                                                 |
| `entry_delay_away`          |      yes | The number of seconds to delay triggering when entering with an "away" state |
| `entry_delay_home`          |      yes | The number of seconds to delay triggering when entering with a "home" state  |
| `exit_delay_away`           |      yes | The number of seconds to delay triggering when exiting with an "away" state  |
| `exit_delay_home`           |      yes | The number of seconds to delay triggering when exiting with a "home" state   |
| `light`                     |      yes | Whether the light on the base station should display when armed              |
| `voice_prompt_volume`       |      yes | The volume of the base station's voice prompts                               |
