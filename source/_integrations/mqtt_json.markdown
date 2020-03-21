---
title: MQTT JSON
description: Instructions on how to use JSON MQTT to track devices in Home Assistant.
logo: mqtt.png
ha_category:
  - Presence Detection
ha_iot_class: Configurable
ha_release: 0.44
---

`mqtt_json` 장치 추적기 플랫폼을 사용하면 새 위치에 대한 MQTT topic을 모니터링하여 현재 상태를 감지 할 수 있습니다. 이 플랫폼을 사용하려면 각 장치마다 고유한 topic을 지정하십시오.

## 설정

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
device_tracker:
  - platform: mqtt_json
    devices:
      paulus_oneplus: location/paulus
      annetherese_n4: location/annetherese
```

{% configuration %}
devices:
  description: List of devices with their topic.
  required: true
  type: list
qos:
  description: The QoS level of the topic.
  required: false
  type: string
{% endconfiguration %}

## 사용법

이 플랫폼은 GPS 정보가 포함 된 JSON 형식의 페이로드를 수신합니다 (예 :

```json
{"longitude": 1.0,"gps_accuracy": 60,"latitude": 2.0,"battery_level": 99.9}
```

Where `longitude` is the longitude, `latitude` is the latitude, `gps_accuracy` is the accuracy in meters, `battery_level` is the current battery level of the device sending the update.
`longitude` and `latitude` are required keys, `gps_accuracy` and `battery_level` are optional.
