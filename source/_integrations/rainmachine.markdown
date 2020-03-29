---
title: 레인머신(RainMachine)
description: Instructions on how to integrate RainMachine units within Home Assistant.
logo: rainmachine.png
ha_category:
  - Irrigation
  - Binary Sensor
  - Sensor
  - Switch
ha_release: 0.69
ha_iot_class: Local Polling
ha_config_flow: true
ha_codeowners:
  - '@bachya'
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/Q0afxjfgPKs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rainmachine` 통합구성요소는 [RainMachine smart Wi-Fi sprinkler controllers](https://www.rainmachine.com/)와 관련된 모든 플랫폼을 연동하기 위한 주요 통합구성요소입니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. :

- Binary Sensor
- Sensor
- [Switch](#switch)

## 기본 설정

RainMachine 장치에 연결하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
rainmachine:
  controllers:
    - ip_address: 192.168.1.100
      password: YOUR_PASSWORD
```

추가 기능을 설정하려면 다음과 같이 `configuration.yaml`의 `rainmachine` 섹션에서 `binary_sensor`, `sensor` 및/또는 `switches` 키 아래에 설정 옵션을 추가하십시오.

```yaml
rainmachine:
  controllers:
    - ip_address: 192.168.1.100
      password: YOUR_PASSWORD
      binary_sensors:
        # binary sensor configuration options...
      sensors:
        # sensor configuration options...
      switches:
        # switch configuration options...
```

{% configuration %}
ip_address:
  description: The IP address or hostname of your RainMachine unit.
  required: false
  type: string
password:
  description: Your RainMachine password.
  required: true
  type: string
port:
  description: The TCP port used by your unit for the REST API.
  required: false
  type: integer
  default: 8080
ssl:
  description: Whether communication with the local device should occur over HTTPS.
  required: false
  type: boolean
  default: true
scan_interval:
  description: The frequency (in seconds) between data updates.
  required: false
  type: integer
  default: 60
binary_sensors:
  description: Binary sensor-related configuration options.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The conditions to create sensors from.
      required: false
      type: list
      default: all (`extra_water_on_hot_days`, `flow_sensor`, `freeze`, `freeze_protection`, `hourly`, `month`, `raindelay`, `rainsensor`, `weekday`)
sensors:
  description: Sensor-related configuration options.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The conditions to create sensors from.
      required: false
      type: list
      default: all (`flow_sensor_clicks_cubic_meter`, `flow_sensor_consumed_liters`, `flow_sensor_start_index`, `flow_sensor_watering_clicks`,`freeze_protect_temp`)
switches:
  description: Switch-related configuration options.
  required: false
  type: map
  keys:
    zone_run_time:
      description: The default number of seconds that a zone should run when turned on.
      required: false
      type: integer
      default: 600
{% endconfiguration %}

## 서비스

### `rainmachine.disable_program`

RainMachine 프로그램을 비활성화하십시오. 이는 프로그램 스위치가
UI에서 `Unavailable` 임을 나타냅니다.

| Service Data Attribute    | Optional | Description             |
|---------------------------|----------|-------------------------|
| `program_id`              |      no  | The program to disable  |

### `rainmachine.disable_zone`

RainMachine 영역을 비활성화하십시오. 이는 프로그램 스위치가
UI에서 `Unavailable` 임을 나타냅니다.

| Service Data Attribute    | Optional | Description             |
|---------------------------|----------|-------------------------|
| `zone_id`                 |      no  | The zone to disable     |

### `rainmachine.enable_program`

RainMachine 프로그램을 활성화하십시오.

| Service Data Attribute    | Optional | Description             |
|---------------------------|----------|-------------------------|
| `program_id`              |      no  | The program to enable   |

### `rainmachine.enable_zone`

RainMachine 영역을 활성화하십시오.

| Service Data Attribute    | Optional | Description             |
|---------------------------|----------|-------------------------|
| `zone_id`                 |      no  | The zone to enable      |

### `rainmachine.pause_watering`

몇 초 동안 모든 급수 활동을 일시 중지하십시오.

| Service Data Attribute    | Optional | Description                    |
|---------------------------|----------|--------------------------------|
| `seconds`                 |      no  | The number of seconds to pause |

### `rainmachine.start_program`

RainMachine 프로그램을 시작하십시오.

| Service Data Attribute    | Optional | Description          |
|---------------------------|----------|----------------------|
| `program_id`              |      no  | The program to start |

### `rainmachine.start_zone`

RainMachine 영역을 설정된 시간 (초) 동안 시작하십시오.

| Service Data Attribute    | Optional | Description                                          |
|---------------------------|----------|------------------------------------------------------|
| `zone_id`                 |      no  | The zone to start                                    |
| `zone_run_time`           |      yes | The number of seconds to run; defaults to 60 seconds |

### `rainmachine.stop_all`

모든 급수 활동을 중지하십시오.

### `rainmachine.stop_program`

RainMachine 프로그램을 중지하십시오.

| Service Data Attribute    | Optional | Description          |
|---------------------------|----------|----------------------|
| `program_id`              |      no  | The program to stop  |

### `rainmachine.stop_zone`

RainMachine 영역을 중지하십시오.

| Service Data Attribute    | Optional | Description          |
|---------------------------|----------|----------------------|
| `zone_id`                 |      no  | The zone to stop     |

### `rainmachine.unpause_watering`

모든 급수 활동을 일시 중지하십시오.

## Switch

`rainmachine` 스위치 플랫폼을 사용하면 [RainMachine smart Wi-Fi sprinkler controller](https://www.rainmachine.com/) 내에서 프로그램 및 영역을 제어할 수 있습니다.

### 장치 제어하기

홈어시스턴트가 로드되면 모든 활성화된 프로그램 및 영역에 대해 새 스위치가 추가됩니다. 이들은 예상대로 작동합니다.

- Program On/Off: starts/stops a program
- Zone On/Off: starts/stops a zone (using the `zone_run_time` parameter to determine how long to run for)

프로그램과 영역이 연결되어 있습니다. 프로그램이 실행되는 동안 프로그램 및 영역 스위치가 켜져 있습니다. 둘 중 하나를 끄면 다른 하나가 꺼집니다 (웹 앱에서처럼).