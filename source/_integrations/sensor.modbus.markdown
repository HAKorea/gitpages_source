---
title: Modbus Sensor
description: "Instructions on how to integrate Modbus sensors into Home Assistant."
logo: modbus.png
ha_category:
  - Sensor
ha_release: pre 0.7
ha_iot_class: Local Push
---

`modbus` 센서를 사용하면 [Modbus](http://www.modbus.org/) 레지스터에서 데이터를 수집할 수 있습니다.

## 설정

Modbus 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  platform: modbus
  registers:
    - name: Sensor1
      hub: hub1
      unit_of_measurement: °C
      slave: 1
      register: 100
    - name: Sensor2
      hub: hub1
      unit_of_measurement: mg
      slave: 1
      register: 110
      count: 2
    - name: Sensor3
      hub: hub1
      unit_of_measurement: °C
      slave: 1
      register: 120
      register_type: input
      data_type: float
      scale: 0.01
      offset: -273.16
      precision: 2
```

{% configuration %}
registers:
  description: The array contains a list of relevant registers to read from.
  required: true
  type: map
  keys:
    name:
      description: Name of the sensor.
      required: true
      type: string
    hub:
      description: The name of the hub.
      required: false
      default: default
      type: string
    slave:
      description: The number of the slave (Optional for tcp and upd Modbus).
      required: true
      type: integer
    register:
      description: Register number.
      required: true
      type: integer
    register_type:
      description: Modbus register type (holding, input), default holding.
      required: false
      type: string
    unit_of_measurement:
      description: Unit to attach to value.
      required: false
      type: integer
    device_class:
      description: The [type/class](/integrations/sensor/#device-class) of the sensor to set the icon in the frontend.
      required: false
      type: device_class
      default: None
    count:
      description: Number of registers to read.
      required: false
      type: integer
      default: 1
    reverse_order:
      description: Reverse the order of registers when count >1.
      required: false
      default: false
      type: boolean
    scale:
      description: Scale factor (output = scale * value + offset).
      required: false
      default: 1
      type: float
    offset:
      description: Final offset (output = scale * value + offset).
      required: false
      default: 0
      type: float
    precision:
      description: Number of valid decimals.
      required: false
      default: 0
      type: integer
    data_type:
      description: Response representation (int, uint, float, custom). If float selected, value will be converted to IEEE 754 floating point format.
      required: false
      default: int
      type: string
    structure:
      description: "If data_type is custom specify here a double quoted python struct format string to unpack the value. See python documentation for details. Ex: >i."
      required: false
      type: string
{% endconfiguration %}

[Platform options](/docs/configuration/platform_options/#scan-interval) 설명서에 표시된대로 센서 업데이트에 대한 기본 30 초 스캔 간격을 변경할 수 있습니다.

<div class='note'>

스케일(scale) 또는 오프셋(offset)을 부동 소수점 값으로 지정하면 배정도 부동 소수점 산술(double precision floating point arithmetic)이 최종값을 계산하는데 사용됩니다. 이로 인해 2^53보다 큰 값의 정밀도가 손실될 수 있습니다.

</div>

### 전체 사례

스캔 간격이 10 초인 온도 센서의 예 :

```yaml
sensor:
- platform: modbus
  scan_interval: 10
  registers:
    - name: Room_1
      hub: hub1
      slave: 10
      register: 0
      register_type: holding
      unit_of_measurement: °C
      count: 1
      scale: 0.1
      offset: 0
      precision: 1
      data_type: integer
```
