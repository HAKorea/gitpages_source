---
title: 수영장스파관리(AquaLogic)
description: Instructions on how to integrate an AquaLogic controller within Home Assistant.
logo: hayward.png
ha_category:
  - Hub
  - Sensor
  - Switch
ha_release: '0.80'
ha_iot_class: Local Push
---

AquaLogic 통합구성요소는 Hayward/Goldline AquaLogic/ProLogic 수영장 컨트롤러에 대한 연결을 제공합니다. 수영장 컨트롤러에 연결된 RS-485 이더넷 어댑터가 필요합니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Sensor](#sensor)
- [Switch](#switch)

## 설정

AquaLogic 통합구성요소를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
aqualogic:
  host: IP_ADDRESS
  port: PORT
```

{% configuration %}
host:
  description: The domain name or IP address of the RS-485 to Ethernet adapter connected to the pool controller, e.g., 192.168.1.1.
  required: true
  type: string
port:
  description: The port provided by the RS-485 to Ethernet adapter.
  required: true
  type: integer
{% endconfiguration %}

## Sensor

AquaLogic 컴포넌트를 활성화려하면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: aqualogic
    monitored_conditions:
      - pool_temp
```

{% configuration %}
monitored_conditions:
  description: List of items you want to monitor.
  required: false
  default: all
  type: list
  keys:
    air_temp:
      description: The air temperature.
    pool_temp:
      description: The pool temperature.
    spa_temp:
      description: The spa temperature.
    pool_chlorinator:
      description: The pool chlorinator setting.
    spa_chlorinator:
      description: The spa chlorinator setting.
    salt_level:
      description: The current salt level.
    pump_speed:
      description: The current pump speed (Hayward VS pumps only).
    pump_power:
      description: The current pump power usage (Hayward VS pumps only).
    status:
      description: The current system status.
{% endconfiguration %}

## Switch

AquaLogic 컴포넌트를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  - platform: aqualogic
    monitored_conditions:
      - lights
      - filter
```

{% configuration %}
monitored_conditions:
  description: List of items you want to monitor/control.
  required: false
  default: all
  type: list
  keys:
    filter:
      description: Controls the filter pump.
    filter_low_speed:
      description: Controls low speed mode on the filter pump (multi-speed pumps only).
    lights:
      description: Controls the Lights relay.
    aux_1:
      description: Controls the Aux 1 relay.
    aux_2:
      description: Controls the Aux 2 relay.
    aux_3:
      description: Controls the Aux 3 relay.
    aux_4:
      description: Controls the Aux 4 relay.
    aux_5:
      description: Controls the Aux 5 relay.
    aux_6:
      description: Controls the Aux 6 relay.
    aux_7:
      description: Controls the Aux 7 relay.
{% endconfiguration %}
