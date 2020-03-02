---
title: 테슬라
description: Instructions on how to integrate Tesla car into Home Assistant.
logo: tesla.png
ha_category:
  - Car
  - Binary Sensor
  - Climate
  - Presence Detection
  - Lock
  - Sensor
  - Switch
ha_release: 0.53
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@zabuldon'
  - '@alandtse'
---

The `Tesla` integration offers integration with the [Tesla](https://auth.tesla.com/login) cloud service and provides presence detection as well as sensors such as charger state and temperature.
`Tesla` 통합구성요소는 [Tesla](https://auth.tesla.com/login) 클라우드 서비스와의 연동을 제공하고 재실 상태 감지와 충전기 상태 및 온도와 같은 센서를 제공합니다.

이 통합구성요소는 다음 플랫폼을 제공합니다:

- Binary sensors - 주차 및 충전기 연결.
- Sensors - 배터리 수준, 내부 / 외부 온도, 주행 거리계, 예상 범위 및 충전 속도 및 기타.
- Device tracker - 자동차의 위치 ​​추적
- Lock - 도어 잠금. 테슬라의 도어락을 제어
- Climate - HVAC 제어.  Tesla의 HVAC 시스템을 제어 (켜기/끄기, 목표 온도 설정) 할 수 있습니다.
- Switch - Charger and max range switch to allow you to start/stop charging and set max range charging. Update switch to allow you to disable polling of vehicles to conserve battery

## Configuration

Home Assistant offers the Tesla integration through **Configuration** -> **Integrations** -> **Tesla**.

Enter username and password and then continue.

Alternatively, Home Assistant will also load Tesla via the  `configuration.yaml`. Add the following to your `configuration.yaml` file:

```yaml
# Example configuration.yaml entry
tesla:
  username: YOUR_EMAIL_ADDRESS
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The email address associated with your Tesla account.
  required: true
  type: string
password:
  description: The password associated with your Tesla account.
  required: true
  type: string
scan_interval:
  description: API polling interval in seconds. Minimum value can't be less than 300 (5 minutes). Very frequent polling can use battery.
  required: false
  type: integer
  default: 300
{% endconfiguration %}
