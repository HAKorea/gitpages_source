---
title: "Modbus Switch"
description: "Instructions on how to integrate Modbus switches into Home Assistant."
logo: modbus.png
ha_category:
  - Switch
ha_release: pre 0.7
ha_iot_class: Local Push
---

`modbus` 스위치 플랫폼을 사용하면 [Modbus](http://www.modbus.org/) coils 또는 registers를 제어할 수 있습니다.

## 설정

설치에서 Modbus 스위치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
switch:
  platform: modbus
  coils:
    - name: Switch1
      hub: hub1
      slave: 1
      coil: 13
    - name: Switch2
      slave: 2
      coil: 14
  registers:
    - name: Register1
      hub: hub1
      slave: 1
      register: 11
      command_on: 1
      command_off: 0
```

{% configuration %}
coils:
  description: A list of relevant coils to read from/write to.
  required: false
  type: map
  keys:
    hub:
      description: The name of the hub.
      required: false
      default: default
      type: string
    slave:
      description: The number of the slave (can be omitted for tcp and udp Modbus).
      required: true
      type: integer
    name:
      description: Name of the switch.
      required: true
      type: string
    coil:
      description: Coil number.
      required: true
      type: integer
register:
  description: A list of relevant registers to read from/write to.
  required: false
  type: map
  keys:
    hub_name:
      description: The hub to use.
      required: false
      default: default
      type: string
    slave:
      description: The number of the slave (can be omitted for tcp and udp Modbus).
      required: true
      type: integer
    name:
      description: Name of the switch.
      required: true
      type: string
    register:
      description: Register number.
      required: true
      type: integer
    command_on:
      description: Value to write to turn on the switch.
      required: true
      type: integer
    command_off:
      description: Value to write to turn off the switch.
      required: true
      type: integer
    verify_state:
      description: Define if is possible to readback the status of the switch.
      required: false
      default: true
      type: boolean
    verify_register:
      description: Register to readback.
      required: false
      default: same as register
      type: string
    register_type:
      description: Modbus register types are holding or input.
      required: false
      default: holding
      type: string
    state_on:
      description: Register value when switch is on.
      required: false
      default: same as command_on
      type: integer
    state_off:
      description: Register value when switch is off.
      required: false
      default: same as command_off
      type: integer
{% endconfiguration %}

[Platform options](/docs/configuration/platform_options/#scan-interval) 설명서에 표시된 대로 스위치 상태 업데이트에 대한 기본 30 초 스캔 간격을 변경할 수 있습니다.

### 전체 설정 사례

스캔 간격이 10 초인 온도 센서의 예 :

```yaml
switch:
  platform: modbus
  scan_interval: 10
  coils:
    - name: Switch1
      hub: hub1
      slave: 1
      coil: 13
    - name: Switch2
      hub: hub1
      slave: 2
      coil: 14
```
