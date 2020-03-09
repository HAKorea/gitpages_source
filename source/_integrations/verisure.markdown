---
title: 버리슈어(Verisure)
description: Instructions on how to setup Verisure devices within Home Assistant.
logo: verisure.png
ha_category:
  - Hub
  - Alarm
  - Binary Sensor
  - Camera
  - Lock
  - Sensor
  - Switch
ha_release: pre 0.7
ha_iot_class: Cloud Polling
---

Home Assistant는 [Verisure](https://www.verisure.com/) 장치 연동을 지원합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- Alarm
- Camera
- Switch (Smartplug)
- Sensor (Thermometers, Hygrometers and Mouse detectors)
- Lock
- Binary Sensor (Door & Window)

## 설정

Verisure를 Home Assistant와 연동하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
verisure:
  username: USERNAME
  password: PASSWORD
```

{% configuration %}
username:
  description: The username to Verisure mypages.
  required: true
  type: string
password:
  description: The password to Verisure mypages.
  required: true
  type: string
alarm:
  description: Set to `true` to show alarm, `false` to disable.
  required: false
  type: boolean
  default: true
hygrometers:
  description: Set to `true` to show hygrometers, `false` to disable.
  required: false
  type: boolean
  default: true
smartplugs:
  description: Set to `true` to show smartplugs, `false` to disable.
  required: false
  type: boolean
  default: true
locks:
  description: Set to `true` to show locks, `false` to disable.
  required: false
  type: boolean
  default: true
default_lock_code:
  description: Code that will be used to lock or unlock, if none is supplied.
  required: false
  type: string
thermometers:
  description: Set to `true` to show thermometers, `false` to disable.
  required: false
  type: boolean
  default: true
mouse:
  description: Set to `true` to show mouse detectors, `false` to disable.
  required: false
  type: boolean
  default: true
door_window:
  description: Set to `true` to show mouse detectors, `false` to disable.
  required: false
  type: boolean
  default: true
code_digits:
  description: Number of digits in PIN code.
  required: false
  type: integer
  default: 4
giid:
  description: The GIID of your installation (If you have more then one alarm system). To find the GIID for your systems run 'python verisure.py EMAIL PASSWORD installations'.
  required: false
  type: string
{% endconfiguration %}

## 경보 제어판

Verisure 경보 제어판 플랫폼을 사용하면 [Verisure](https://www.verisure.com/) 경보를 제어 할 수 있습니다.

위 지침에 따라 Verisure 허브를 먼저 설정해야합니다.

`changed_by` 속성은 [automation](/getting-started/automation/)에서 알람을 armed/disarmed 한 사람에 따라 다른 작업을 수행 할 수 있습니다.

```yaml
automation:
  - alias: Alarm status changed
    trigger:
      - platform: state
        entity_id: alarm_control_panel.alarm_1
    action:
      - service: notify.notify
        data_template:
          message: >
            {% raw %}Alarm changed from {{ trigger.from_state.state }}
            to {{ trigger.to_state.state }}
            by {{ trigger.to_state.attributes.changed_by }}{% endraw %}
```

## 서비스

| Service | Description |
| ------- | ----------- |
| disable_autolock | Disables autolock function for a specific lock. |
| enable_autolock | Enables autolock function for a specific lock. |
| smartcam_capture | Capture a new image from a specific smartcam. |
