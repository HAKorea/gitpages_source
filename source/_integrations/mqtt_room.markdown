---
title: MQTT Room Presence
description: Instructions on how to track room presence within Home Assistant.
logo: mqtt.png
ha_category:
  - Presence Detection
ha_release: 0.27
ha_iot_class: Configurable
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/A57jFYDzOto" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`mqtt_room` 센서 플랫폼을 사용하면 MQTT 클라이언트를 사용하여 장치의 실내 위치를 감지 할 수 있습니다.

## 설정

이 장치 추적기를 설치에 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: mqtt_room
    device_id: 123testid
```

{% configuration %}
device_id:
  description: The device id to track for this sensor.
  required: true
  type: string
name:
  description: The name of the sensor.
  required: false
  default: Room Sensor
  type: string
state_topic:
  description: The topic that contains all subtopics for the rooms.
  required: true
  type: string
timeout:
  description: "The time in seconds after which a room presence state is considered old. An example: device1 is reported at scanner1 with a distance of 1. No further updates are sent from scanner1. After 5 seconds scanner2 reports device1 with a distance of 2. The old location info is discarded in favor of the new scanner2 information as the timeout has passed."
  required: false
  default: 5
  type: integer
away_timeout:
  description: The time in seconds after which the state should be set to `not_home` if there were no updates. `0` disables the check.
  required: false
  default: 0
  type: integer
{% endconfiguration %}

## 사용법

room topics에 publish해야하는 JSON 예 :

```json
{
  "id": "123testid",
  "name": "Test Device",
  "distance": 5.678
}
```

### 클라이언트 세팅하기 

이 연동은 주어진 형식으로 데이터를 전송하는 모든 소프트웨어와 작동합니다. 각 클라이언트는 검색된 장치를 설정된 topic의 자체 하위 topic에 게시(post)해야합니다. :

- [**room-assistant**](https://github.com/mKeRix/room-assistant): Node.js를 기반으로 블루투스 LE 비콘을 찾습니다.
- [**Happy Bubbles Presence Server**](https://github.com/happy-bubbles/presence): Go를 기반으로하는 Happy Bubbles BLE 스캔 장치의 재실 감지 서버
- [**ESP32-MQTT-room**](https://jptrsn.github.io/ESP32-mqtt-room/): ESP32에서 실행되며 C ++/Arduino를 기반으로 Bluetooth LE 장치를 찾습니다.
