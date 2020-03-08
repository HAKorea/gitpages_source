---
title: "온습도조절기(Modbus Climate)"
description: "Instructions how to integrate a Modbus thermostat within Home Assistant."
logo: modbus.png
ha_category:
  - Climate
ha_release: 0.68
ha_iot_class: Local Polling
---


`modbus` 온도 조절 장치를 사용하면 [Modbus](http://www.modbus.org/) 레지스터의 센서값 (현재 온도) 및 목표값 (대상 온도)을 사용할 수 있습니다.

## 설정

To use your Modbus thermostat in your installation, add the following to your `configuration.yaml` file:
설치에서 Modbus 온도 조절기를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
climate:
  - platform: modbus
    name: Watlow F4T
    hub: hub1
    slave: 1
    data_type: uint
    count: 1
    scale: 0.1
    offset: 0
    precision: 1
    max_temp: 30
    min_temp: 15
    temp_step: 1
    target_temp_register: 2782
    current_temp_register: 27586
```

{% configuration %}
name:
  description: Name of the device
  required: true
  type: string
hub:
  description: The name of the hub.
  required: false
  default: default
  type: string
slave:
  description: The number of the slave (Optional for tcp and upd Modbus, use 1).
  required: true
  type: integer
target_temp_register:
  description: Register number for target temperature (Setpoint).
  required: true
  type: integer
current_temp_register:
  description: Register number for current temperature (Process value).
  required: true
  type: integer
data_type:
  description: Response representation (int, uint, float, custom). If float selected, value will converted to IEEE 754 floating point format.
  required: false
  type: string
  default: float
count:
  description: Number of registers to read.
  required: false
  type: integer
precision:
  description: Number of valid decimals.
  required: false
  type: integer
  default: 0
scale:
  description: Scale factor (output = scale * value + offset).
  required: false
  type: float
  default: 1
offset:
  description: Final offset (output = scale * value + offset).
  required: false
  type: float
  default: 0
max_temp:
  description: Maximum setpoint temperature.
  required: false
  type: integer
  default: 35
min_temp:
  description: Maximum setpoint temperature.
  required: false
  type: integer
  default: 5 
temp_step:
  description: The supported step size a target temperature can be increased/decreased.
  required: false
  type: float
  default: 0.5 
temperature_unit:
  description: Temperature unit reported by the current_temp_register. C or F
  required: false
  type: string
  default: C
{% endconfiguration %}


### 서비스

| Service | Description |
| ------- | ----------- |
| set_temperature | Set Temperature. Requires `value` to be passed in, which is the desired target temperature. `value` should be in the same type as `data_type` |
