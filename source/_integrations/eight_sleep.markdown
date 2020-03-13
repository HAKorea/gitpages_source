---
title: 스마트침대(Eight Sleep)
description: Interface an Eight Sleep smart cover or mattress to Home Assistant
logo: eight_sleep.png
ha_category:
  - Health
  - Binary Sensor
  - Sensor
ha_release: 0.44
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@mezz64'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/F1p9Zfb9GxM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`eight_sleep` 통합구성요소를 통해 Home Assistant는 [Eight Sleep](https://eightsleep.com/) 스마트 커버 또는 매트리스에서 데이터를 가져올 수 있습니다.

현재 홈 어시스턴트에서 다음 장치 유형이 지원됩니다.

- Binary Sensor - 홈어시스턴트를 통해 [Eight Sleep](https://eightsleep.com/) 커버/매트리스에 사람의 존재 상태를 관찰 할 수 있습니다.
- Sensor - 여기에는 침대 상태 및 현재 및 이전 수면 세션의 결과가 포함됩니다.

## 설정

침대의 현재 상태와 수면 세션의 결과를 전달하기 위해 'Sensor' 플랫폼을 사용하고 침대에 당신의 존재를 나타내는 'Binary Sensor' 플랫폼을 사용하여 설정됩니다. 침대의 난방 수준과 지속 시간을 설정하는 서비스도 제공됩니다.

홈어시스턴트 구성 요소를 설정하기 전에 Eight Sleep 앱에 기록된 수면 세션이 2개 이상 있어야합니다.

시작하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
eight_sleep:
  username: YOUR_E_MAIL_ADDRESS
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: Eight Sleep 계정과 연결된 이메일 주소.
  required: true
  type: string
password:
  description: Eight Sleep 계정과 관련된 비밀번호.
  required: true
  type: string
partner:
  description: 침대의 양쪽에 대한 데이터를 가져올 것인지 정의.
  required: false
  type: boolean
  default: false
{% endconfiguration %}

### 지원되는 기능

Sensors:

- eight_left/right_bed_state
- eight_left/right_sleep_session
- eight_left/right_previous_sleep_session
- eight_left/right_bed_temperature
- eight_left/right_sleep_stage
- eight_room_temperature

Binary Sensors:

- eight_left/right_bed_presence

### `heat_set` 서비스

eight_sleep / heat_set 서비스를 사용하여 침대의 목표 난방 수준과 난방 기간을 조정할 수 있습니다.

| Service data attribute | Optional | Description |
| ---------------------- | -------- | ----------- |
| `entity_id` | no | Entity ID of bed state to adjust.
| `target` | no | Target heating level from 0-100.
| `duration` | no | Duration to heat at the target level in seconds.

스크립트 예 :

```yaml
script:
  bed_set_heat:
    sequence:
      - service: eight_sleep.heat_set
        data:
          entity_id: "sensor.eight_left_bed_state"
          target: 35
          duration: 3600
```
