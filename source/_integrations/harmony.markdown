---
title: Logitech Harmony Hub
description: Instructions on how to integrate Harmony Hub remotes into Home Assistant.
logo: logitech.png
ha_category:
  - Remote
ha_iot_class: Local Push
ha_release: 0.34
ha_codeowners:
  - '@ehendrix23'
---

`harmony` 원격 플랫폼을 사용하면 [Harmony Hub Device](https://www.logitech.com/en-us/product/harmony-hub)의 상태를 제어 할 수 있습니다

지원 유닛들 :

- Harmony Hub
- Harmony Companion
- Harmony Pro
- Harmony Elite

Harmony 리모컨을 설정하는 기본 방법은 [discovery component](/integrations/discovery/)를 활성화하는 것입니다.

그러나 장치를 수동으로 설정하려면 `configuration.yaml` 파일에 해당 설정을 추가해야합니다

```yaml
# Example configuration.yaml entry
remote:
  - platform: harmony
    name: Bedroom
    host: 10.168.1.13
```

`configuration.yaml` 설정을 추가하여 검색된 허브의 일부 기본 설정 값 (예 : `port` 또는 `activity`)을 대체 할 수 있습니다. 이 경우 플랫폼이 호스트 IP를 자동으로 감지하도록 `host` 설정을 비워 두십시오. 그러나 설정에서 `name`을 허브에 설정한 이름과 정확히 일치하도록 설정하여 플랫폼이 설정하려는 허브를 플랫폼이 인식하도록 합니다.

```yaml
# Example configuration.yaml entry with discovery
  - platform: harmony
    name: Living Room
    activity: Watch TV
```

{% configuration %}
name:
  description: 프런트 엔드에 표시할 허브 이름. 이 이름은 허브에서 설정한 이름과 일치해야합니다.
  required: true
  type: string
host:
  description: 하모니 장치의 IP주소. IP가 자동으로 검색되도록 하려면 비워두십시오.
  required: false
  type: string
port:
  description: 하모니 장치의 포트.
  required: false
  type: integer
  default: 5222
activity:
  description: "`turn_on` 서비스가 데이터없이 호출될 때 사용할 activity. 이때 발견된 허브에 대한 `activity` 세팅으로 덮어씁니다."
  required: false
  type: string
delay_secs:
  description: 장치에 명령을 보내는 사이의 기본 지속시간(초)입니다.
  required: false
  type: float
  default: 0.4
hold_secs:
  description: '"press" 명령전송과 "release" 명령전송 사이의 기본 지속시간(초)입니다.'
  required: false
  type: integer
  default: 0
{% endconfiguration %}

### 설정 파일 

시작시 하나의 파일이 다음 형식으로 장치당 홈어시스턴트 설정 디렉토리에 작성됩니다. :  `harmony_REMOTENAME.conf` 파일은 다음을 포함합니다

- 프로그래밍 된 모든 활동 이름 및 ID 번호 목록
- 프로그래밍 된 모든 장치 이름 및 ID 번호 목록
- 프로그래밍 된 장치 당 사용 가능한 모든 명령 목록

Harmony HUB에 새로운 설정이 있을 때마다 이 파일을 덮어 쓰므로 홈어시스턴트를 다시 시작할 필요가 없습니다.

### `remote.turn_off` 서비스

현재 activity 시작부터 스위치를 켠 모든 장치를 끕니다. 

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | 대상 엔티티ID

### `remote.turn_on` 서비스

activity를 시작하십시오. activity가 지정되지 않은 경우 configuration.yaml에서 기본 `activity`를 시작합니다. 지정된 activity는 [Home Assistant configuration directory](/docs/configuration/)에 기록된 설정 파일의 activity 이름 또는 activity ID 일 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | 대상 엔티티ID
| `activity`             |      yes | Activity ID 혹은 시작하는 Activity 이름.

##### 예시 

'harmony_REMOTENAME.conf' 파일에서 사용 가능한 activities를 찾을 수 있습니다. 예를 들면 다음과 같습니다. :

```text
{
    "Activities": {
        "-1": "PowerOff",
        "20995306": "Watch TV",
        "20995307": "Play Games",
        "20995308": "Listen Music"
    }
}
```

activity 이름 'Watch TV'을 사용하여 자동화를 통해 서비스를 호출하여이 activity를 켤 수 있습니다. : 

```yaml
action:
  - service: remote.turn_on
    entity_id: remote.bed_room_hub
    data:
       activity: "Watch TV"
```

### `remote.send_command` 서비스

단일 명령 또는 일련의 명령을 하나의 장치로 전송하면 장치 ID 및 사용 가능한 명령이 시작시 설정 파일에 기록됩니다. 선택적으로 명령을 반복할 횟수와 반복되는 명령 사이에서 원하는 지연시간을 지정할 수 있습니다. 

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | 대상 엔티티ID.
| `device`               |       no | 명령을 보낼 장치 ID 또는 장치 이름.
| `command`              |       no | 보낼 단일 명령 또는 명령 목록.
| `num_repeats`          |      yes | 명령을 반복 할 횟수.
| `delay_secs`           |      yes | 각 명령 전송 사이의 시간(초).

'harmony_REMOTENAME.conf' 파일에서 사용 가능한 장치 및 명령을 찾을 수 있습니다. 예를 들면 : 

```text
{
    "Devices": {
        "TV": {
            "commands": [
                "PowerOff",
                "PowerOn"
            ],
            "id": "327297814"
        },
        "Receiver": {
            "commands": [
                "PowerOff",
                "PowerOn",
                "VolumeUp",
                "VolumeDown",
                "Mute"
            ],
            "id": "428297615"
        }
    }
}
```

몇가지 버튼입력을 통한 일반적인 서비스 요청(service call)은 다음과 같습니다.

```yaml
service: remote.send_command
data:
  entity_id: remote.tv_room
  command:
    - PowerOn
    - Mute
  device: Receiver
  delay_secs: 0.6
```
혹은
```yaml
service: remote.send_command
data:
  entity_id: remote.tv_room
  command:
    - PowerOn
    - Mute
  device: 428297615
  delay_secs: 0.6
```

### `harmony.change_channel` 서비스

채널 변경 명령을 하모니 허브로 보냅니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | Entity ID to target.
| `channel`              |       no | Channel number to change to

A typical service call for changing the channel would be::
채널 변경을위한 일반적인 서비스 요청은 다음과 같습니다.

```yaml
service: harmony.change_channel
data:
  entity_id: remote.tv_room
  channel: 200
```

### `harmony.sync` 서비스

하모니 장치와 하모니 클라우드 간 강제 동기화 

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id`            |       no | Entity ID to target.

### 예시 

프론트 엔드에서 현재 활동을 표시하기 위해 템플리트 센서를 사용할 수 있습니다.

{% raw %}
```yaml
sensor:
  - platform: template
    sensors:
      family_room:
        value_template: '{{ state_attr("remote.family_room", "current_activity") }}'
        friendly_name: 'Family Room'
      bedroom:
        value_template: '{{ state_attr("remote.bedroom", "current_activity") }}'
        friendly_name: 'bedroom'
```
{% endraw %}

아래 예 `input_boolean`는 Harmony 리모컨의 현재 활동을 사용하여 스위치를 제어하는 ​​방법을 보여줍니다. 원격 상태가 변경되고 Kodi activity가 시작되면 스위치가 켜지고 원격 상태가 변경되고 현재 activity가 "PowerOff"이면 스위치가 꺼집니다.

{% raw %}
```yaml
automation:
  - alias: "Watch TV started from harmony hub"
    trigger:
      platform: state
      entity_id: remote.family_room
    condition:
      condition: template
      value_template: '{{ trigger.to_state.attributes.current_activity == "Kodi" }}'
    action:
      service: input_boolean.turn_on
      entity_id: input_boolean.notify
  - alias: "PowerOff started from harmony hub"
    trigger:
      platform: state
      entity_id: remote.family_room
    condition:
      condition: template
      value_template: '{{ trigger.to_state.attributes.current_activity == "PowerOff" }}'
    action:
      service: input_boolean.turn_off
      entity_id: input_boolean.notify
```
{% endraw %}
