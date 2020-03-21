---
title: "RFLink Binary Sensor"
description: "Instructions on how to integrate RFLink binary sensors into Home Assistant."
logo: rflink.png
ha_category:
  - Binary Sensor
ha_iot_class: Local Push
ha_release: 0.81
---

<iframe width="690" height="388" src="https://www.youtube.com/embed/yR_o82oZADQ" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`rflink` 통합구성요소는 [RFLink 게이트웨이 펌웨어](http://www.nemcon.nl/blog2/)를 사용하는 장치, 예를 들어 [Nodo RFLink Gateway](https://www.nodo-shop.nl/nl/21-rflink-gateway). RFLink 게이트웨이는 저렴한 하드웨어 (Arduino + 트랜시버)를 사용하여 여러 RF 무선 장치와 양방향 통신을 가능하게하는 Arduino 펌웨어입니다.

먼저 [RFLink 허브](/integrations/rflink/)를 설정해야합니다.

RFLink 통합구성요소는 `binary_sensor`, `switch`, `light`의 차이점을 모릅니다. 따라서 모든 전환 가능한 장치는 기본적으로 자동으로 `light`으로 추가됩니다.

RFLink binary_sensor/switch/light ID는 protocol, id, switch/channel로 구성됩니다. 예: `newkaku_0000c6c2_1`.

이진 센서의 ID를 알고 나면 Home Assistant에서 이진 센서 유형으로 설정하여 이를 숨기거나 더 좋은 이름을 설정할 수 있습니다.

이진 센서로 장치 설정 :

```yaml
# Example configuration.yaml entry
binary_sensor:
   - platform: rflink
     devices:
       pt2262_00174754_0: {}
```

{% configuration %}
devices:
  description: A list of binary sensors.
  required: false
  type: list
  keys:
    rflink_ids:
      description: RFLink ID of the device
      required: true
      type: map
      keys:
        name:
          description: Name for the device.
          required: false
          default: RFLink ID
          type: string
        aliases:
          description: Alternative RFLink ID's this device is known by.
          required: false
          type: list
        device_class:
          description: Sets the [class of the device](/integrations/binary_sensor/), changing the device state and icon that is displayed on the frontend.
          required: false
          type: string
        off_delay:
          description: For sensors that only sends 'On' state updates, this variable sets a delay after which the sensor state will be updated back to 'Off'.
          required: false
          type: integer
        force_update:
          description: Sends update events even if the value has not changed. Useful for sensors that only sends `On`.
          required: false
          type: boolean
          default: false
{% endconfiguration %}

### 센서 상태

처음에는 이진 센서의 상태를 알 수 없습니다. 센서 업데이트가 수신되면 상태를 알 수 있으며 프런트 엔드에 표시됩니다.

### 장치 지원

See [device support](/integrations/rflink/#device-support)
[device support](/integrations/rflink/#device-support) 참조

### 추가 설정 사례

사용자 정의 이름 및 장치 클래스(Device Class)와 off_delay를 가진 다중 센서

```yaml
# Example configuration.yaml entry
binary_sensor:
   - platform: rflink
     devices:
       pt2262_00174754_0:
         name: PIR Entrance
         device_class: motion
         off_delay: 5
       pt2262_00174758_0:
         name: PIR Living Room
         device_class: motion
         off_delay: 5
```
