---
title: 아보드(Abode)
description: Instructions on integrating Abode home security with Home Assistant.
logo: abode.jpg
ha_category:
  - Hub
  - Alarm
  - Binary Sensor
  - Camera
  - Cover
  - Light
  - Lock
  - Sensor
  - Switch
ha_release: 0.52
ha_iot_class: Cloud Push
ha_config_flow: true
ha_codeowners:
  - '@shred86'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/S5NcbONhyBI" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`abode` 통합구성요소를 통해 사용자는 Abode Home Security 시스템을 Home Assistant에 연동하고 경보 시스템과 센서를 사용하여 집안을 자동화 할 수 있습니다.

Abode Security에 대한 자세한 내용은 [Abode website](https://goabode.com/)를 방문하십시오.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- **Alarm Control Panel**: 현재 경보 상태를 보고하고 시스템을 설정 및 해제하는데 사용할 수 있습니다.
- [**Binary Sensor**](/integrations/abode/#binary-sensor): `Quick Actions`, `Door Contacts`, `Connectivity` 센서 (원격조정, 키패드 및 상태 표시기), `Moisture` 센서 및 `Motion` 또는 `Occupancy` 센서에 대해 보고입니다. 또한 세팅된 모든 Abode `Quick Actions`도 리스트합니다. quick actions 이진 센서의 `entity_id`를 [trigger_quick_action service](/integrations/abode/#trigger_quick_action)에 전달하여 이러한 quick actions를 트리거할 수 있습니다.
- **Camera**: `Camera` 장치에 대해 보고하고 최신 캡처된 스틸 이미지를 다운로드하여 표시합니다.
- **Cover**: `Secure Barriers`에 대한 보고이며 커버를 열고 닫는 데 사용할 수 있습니다.
- **Lock**: `Door Locks`에 대한 보고이며 문을 lock/unlock 하는 데 사용할 수 있습니다.
- [**Light**](/integrations/abode/#light): `Dimmer` 조명에 대해 보고하며 조명을 켜거나 끄는 데 사용할 수 있습니다.
- [**Switch**](/integrations/abode/#switch): `Power Switch` 장치에 대해 보고하며 전원 스위치를 켜고 끄는 데 사용할 수 있습니다. 또한 Abode 시스템에 설정된 `Automations`에 대한 보고를 통해 이를 활성화 또는 비활성화 할 수 있습니다 (Abode의 CUE 자동화에서는 작동하지 않음).
- **Sensor**: `Temperature`, `Humidity`, `Light`에 대해 보고합니다.

## 설정

설치에서 Abode 장치를 사용하려면 통합구성요소 페이지에서 Abode 계정을 추가하십시오. Abode 계정에서 2 단계 인증을 비활성화해야합니다. 또는 다음 `abode` 섹션을`configuration.yaml` 파일에 추가하여 Abode를 설정할 수 있습니다.

```yaml
# Example configuration.yaml entry
abode:
  username: abode_username
  password: abode_password
```

{% configuration %}
username:
  description: Username for your Abode account.
  required: true
  type: string
password:
  description: Password for your Abode account.
  required: true
  type: string
polling:
  description: >
    Enable polling if cloud push updating is less reliable.
    Will update the devices once every 30 seconds.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

## Events

Abode에서 트리거 할 수 있는 많은 이벤트가 있습니다.
다음과 같은 이벤트로 그룹화됩니다.

- **abode_alarm**: Fired when an alarm event is triggered from Abode. This includes Smoke, CO, Panic, and Burglar alarms.
- **abode_alarm_end**: Fired when an alarm end event is triggered from Abode.
- **abode_automation**: Fired when an Automation is triggered from Abode.
- **abode_panel_fault**: Fired when there is a fault with the Abode hub. This includes events like loss of power, low battery, tamper switches, polling failures, and signal interference.
- **abode_panel_restore**: Fired when the panel fault is restored.
- **abode_disarm**: Fired when the alarm is disarmed.
- **abode_arm**: Fired when the alarm is armed (home or away).
- **abode_test**: Fired when a sensor is in test mode.
- **abode_capture**: Fired when an image is captured.
- **abode_device**: Fired for device changes/additions/deletions.
- **abode_automation_edit**: Fired for changes to automations.

모든 이벤트에는 다음과 같은 필드가 있습니다.

Field | Description
----- | -----------
`device_id` | The Abode device ID of the event.
`device_name` | The Abode device name of the event.
`device_type` | The Abode device type of the event.
`event_code` | The event code of the event.
`event_name` | The name of the event.
`event_type` | The type of the event.
`event_utc` | The UTC timestamp of the event.
`user_name` | The Abode user that triggered the event, if applicable.
`app_type` | The Abode app that triggered the event (e.g. web app, iOS app, etc.).
`event_by` | The keypad user that triggered the event.
`date` | The date of the event in the format `MM/DD/YYYY`.
`time` | The time of the event in the format `HH:MM AM`.

알려진 event_codes의 고유 목록이 [여기](https://github.com/MisterWil/abodepy/files/1262019/timeline_events.txt)있습니다. 

## 서비스

### `change_setting` 서비스

Abode 시스템의 설정을 변경하십시오.
설정 및 유효한 값의 전체 목록을 보려면 [AbodePy settings section](https://github.com/MisterWil/abodepy/blob/master/README.rst#settings)을 참조하십시오. 

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `setting` | No | The setting you wish to change.
| `value` | No | The value you wish to change the setting to.

### `capture_image` 서비스

Abode IR 카메라에 새로운 정지 이미지를 요청하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | No | String or list of strings that point at `entity_id`s of Abode cameras.

### `trigger_quick_action` 서비스

Abode 시스템에서 quick action 자동화를 시작하십시오.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | No | String or list of strings that point at `entity_id`s of binary_sensors that represent your Abode quick actions.
