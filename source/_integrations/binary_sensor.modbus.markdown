---
title: Modbus Binary Sensor(Modbus 이진 센서)
description: "Instructions on how to set up Modbus binary sensors within Home Assistant."
logo: modbus.png
ha_category:
  - Binary Sensor
ha_release: 0.28
ha_iot_class: Local Push
---

`modbus` 이진 센서를 사용하면 [Modbus](http://www.modbus.org/) coils 에서 데이터를 수집 할 수 있습니다.

## 설정

Modbus 바이너리 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: modbus
    coils:
      - name: Sensor1
        hub: hub1
        slave: 1
        coil: 100
      - name: Sensor2
        hub: hub1
        slave: 1
        coil: 110
```

{% configuration %}
coils:
  description: The array contains a list of coils to read from.
  required: true
  type: [map, list]
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
      description: The number of the slave (Optional for TCP and UDP Modbus).
      required: true
      type: integer
    coil:
      description: Coil number.
      required: true
      type: integer
    device_class:
      description: The [type/class](/integrations/binary_sensor/#device-class) of the binary sensor to set the icon in the frontend.
      required: false
      type: device_class
      default: None
{% endconfiguration %}

[Platform options](/docs/configuration/platform_options/#scan-interval) 설명서에 표시된대로 센서 업데이트에 대한 기본 30 초 스캔 간격을 변경할 수 있습니다.

## 전체 예시

스캔 간격이 10 초인 센서의 예 :

```yaml
binary_sensor:
  - platform: modbus
    scan_interval: 10
    coils:
      - name: Sensor1
        hub: hub1
        slave: 1
        coil: 100
      - name: Sensor2
        hub: hub1
        slave: 1
        coil: 110
```
