---
title: 태양광인버터(Fronius)
description: Instructions on how to connect your Fronius Inverter to Home Assistant.
ha_category:
  - Energy
  - Sensor
logo: fronius.png
ha_iot_class: Local Polling
ha_release: 0.96
ha_codeowners:
  - '@nielstron'
---

`fronius` 센서는 [Fronius](https://www.fronius.com/) 태양광 인버터, 배터리 시스템 또는 스마트 미터를 폴링하고 그 값을 Home Assistant에서 센서로 표시합니다.

## 설정

이 센서를 활성화하려면`configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
sensor:
  - platform: fronius
    resource: FRONIUS_URL
    monitored_conditions:
    - sensor_type: inverter
```

{% configuration %}
resource:
  description: "The IP address of the Fronius device"
  required: true
  type: string
monitored_conditions:
  description: "Conditions to display in the frontend"
  required: true
  type: list
  keys:
    sensor_type:
      description: "The kind of device, can be one of \"inverter\", \"storage\", \"meter\", or \"power_flow\""
      required: true
      type: string
    scope:
      description: "The device type for storage and inverter, can be either \"device\" or \"system\""
      required: false
      type: string
      default: "device"
    device:
      description: "The id of the device to poll"
      required: false
      default: "\"1\" for inverters and \"0\" for other devices such as storages in compliance with Fronius Specs"
{% endconfiguration %}

## 데이터 모니터

모니터가 되게 하는 조건으로 선택된 각 센서 유형은 센서 세트를 Home Assistant에 추가합니다.

- `power_flow`

    현재 일 또는 연도에 생산된 에너지 및 생산된 전체 에너지와 같은 누적 데이터.
    또한 실시간 값들은 다음과 같습니다. : 
    
    - Power fed to the grid (if positive) or taken from the grid (if negative).
    - Power load as a generator (if positive) or consumer (if negative).
    - Battery charging power (if positive) or discharging power (if negative) and information about backup or standby mode.
    - Photovoltaic production.
    - Current relative self-consumption of produced energy.
    - Current relative autonomy.

- `inverter`

    현재 일 또는 연도에 생산 된 에너지 및 생산 된 전체 에너지와 같은 누적 데이터.
    또한 AC/DC power, current, voltage, frequency에 대한 실시간 값입니다.
    데이터는 장치 범위를 선택할 때만 표시됩니다.

- `meter`

    상(phase)에서 지원되는 경우  power, current, voltage에 대한 자세한 정보.
    데이터는 장치 범위를 선택할 때만 표시됩니다.

- `storage`

    설치된 배터리에 대한 current, voltage, state, cycle count, capacity 등에 대한 자세한 정보

일부 데이터 (예: 태양광 생산)는 0이 아닌 경우에만 Fronius 장치에서 제공합니다.
해당 센서는 사용 가능한 즉시 홈어시스턴트에 엔티티로 추가됩니다.
예를 들어 야간에 홈어시스턴트를 시작하면, 태양광 관련 데이터를 제공하는 센서가 없을 수 있습니다.
Fronius 장치가 필요한 데이터를 제공하기 시작할 때, 일출시에 값이 추가되므로 문제가 되지 않습니다.

## 사례

하나의 Fronius 장치가 제공하는 구성 요소를 더 포함 할 때 통합된 센서 목록은 아래와 같이 제공 될 수 있습니다.

```yaml
sensor:
  - platform: fronius
    resource: FRONIUS_IP_ADDRESS
    monitored_conditions:
    - sensor_type: inverter
      device: 1
    - sensor_type: meter
      scope: system
    - sensor_type: meter
      device: 3
    - sensor_type: storage
      device: 0
    - sensor_type: power_flow
```
