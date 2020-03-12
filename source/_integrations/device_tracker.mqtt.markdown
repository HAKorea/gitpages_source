---
title: "MQTT 장치 추적기(MQTT Device Tracker)"
description: "Instructions on how to use MQTT to track devices in Home Assistant."
logo: mqtt.png
ha_category:
  - Presence Detection
ha_iot_class: Configurable
ha_release: 0.7.3
---


`mqtt` 장치 추적기 플랫폼을 사용하면 새 위치에 대한 MQTT topic을 모니터링하여 현재 상태를 감지 할 수 있습니다. 이 플랫폼을 사용하려면 각 장치마다 고유한 topic를 지정하십시오.

## 설정

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: mqtt
    devices:
      paulus_oneplus: 'location/paulus'
      annetherese_n4: 'location/annetherese'
```

{% configuration %}
devices:
  description: List of devices with their topic.
  required: true
  type: list
qos:
  description: The QoS level of the topic.
  required: false
  type: integer
payload_home:
  description: The payload value that represents the 'home' state for the device.
  required: false
  type: string
  default: 'home'
payload_not_home:
  description: The payload value that represents the 'not_home' state for the device.
  required: false
  type: string
  default: 'not_home'
source_type:
  description: Attribute of a device tracker that affects state when being used to track a [person](/integrations/person/). Valid options are `gps`, `router`, `bluetooth`, or `bluetooth_le`.
  required: false
  type: string
{% endconfiguration %}

## 완전한 설정 예

```yaml
# Complete configuration.yaml entry
device_tracker:
  devices:
    paulus_oneplus: 'location/paulus'
    annetherese_n4: 'location/annetherese'
  qos: 1
  payload_home: 'present'
  payload_not_home: 'not present'
  source_type: bluetooth
```

## 사용법

topic에 publish 할수 있는 JSON 사례 (예: mqtt.publish 서비스를 통해) :

```json
{
  "topic": "location/paulus",
  "payload": "home"
}
```
