---
title: "RFLink Sensor"
description: "Instructions on how to integrate RFLink sensors into Home Assistant."
logo: rflink.png
ha_category:
  - Sensor
ha_release: 0.38
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/oYfbEyzT-Gs" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rflink` 통합구성요소는 [RFLink gateway firmware](http://www.nemcon.nl/blog2/)를 사용하는 장치 (예: [Nodo RFLink Gateway](https://www.nodo-shop.nl/nl/21-rflink-gateway))를 지원합니다. RFLink 게이트웨이는 저렴한 하드웨어 (Arduino + 트랜시버)를 사용하여 여러 RF 무선 장치와 양방향 통신을 가능하게하는 Arduino 펌웨어입니다. 

## 설정

먼저 [RFLink 허브](/integrations/rflink/)를 설정해야합니다.

RFLink 허브를 설정하면 센서가 자동으로 감지되어 추가됩니다.

RFLink 센서 ID는 protocol, ID 및 type(옵션)으로 구성됩니다 (예: `alectov1_0334_temp`). 일부 센서는 여러 유형의 데이터를 내보냅니다. 각각 자체적으로 생성됩니다.

센서의 ID를 알고 나면 Home Assistant에서 센서를 설정하는데 사용할 수 있습니다 (예: 다른 그룹에 추가하거나 숨기거나 익숙한 이름을 설정하는 등).

장치를 센서로 설정 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: rflink
    devices:
      alectov1_0334_temp: {}
```

{% configuration %}
automatic_add:
  description: Automatically add new/unconfigured devices to Home Assistant if detected.
  required: false
  default: true
  type: boolean
devices:
  description: A list of sensors.
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
        sensor_type:
          description: Override automatically detected type of sensor. For list of [values](/integrations/sensor.rflink/#sensors-types) see below.
          required: true
          type: string
        unit_of_measurement:
          description: Override automatically detected unit of sensor.
          required: false
          type: string
        aliases:
          description: "Alternative RFLink ID's this device is known by."
          required: false
          type: [list, string]
{% endconfiguration %}

## 센서 타입

센서 타입 값들 :

- average_windspeed
- barometric_pressure
- battery
- weather_forecast
- doorbell_melody
- command
- co2_air_quality
- current_phase_1
- current_phase_2
- current_phase_3
- distance
- firmware
- humidity_status
- humidity
- hardware
- kilowatt
- light_intensity
- meter_value
- total_rain
- rain_rate
- revision
- noise_level
- temperature
- uv_intensity
- version
- voltage
- watt
- windchill
- winddirection
- windgusts
- windspeed
- windtemp

## 센서 숨기기/무시하기

Sensors are added automatically when the RFLink gateway intercepts a wireless command in the ether. To prevent cluttering the frontend use any of these methods:
RFLink 게이트웨이가 이더넷에서 무선 명령을 가로 채면 센서가 자동으로 추가됩니다. 프론트 엔드가 복잡해지지 않게하려면 다음 방법 중 하나를 사용하십시오.

- 설정되지 않은 새 센서 자동 추가를 비활성화합니다 (`auto_add`를 `false`로 설정).
- [customizations](/getting-started/customizing-devices/)를 사용하여 원치 않는 장치 숨기기
- [Ignore devices on a platform level](/integrations/rflink/#ignoring-devices)

## 지원 장치

[device support](/integrations/rflink/#device-support) 참조. 

## 추가 설정 사례

`automatic_add`가 비활성화되고 `aliases`가 있는 다중 센서

```yaml
# Example configuration.yaml entry
sensor:
  - platform: rflink
    automatic_add: false
    devices:
      oregontemp_0d93_temp:
        sensor_type: temperature
      oregontemp_0d93_bat:
        sensor_type: battery
      tunex_c001_temp:
        sensor_type: temperature
        aliases:
          - xiron_4001_temp
      tunex_c001_hum:
        sensor_type: humidity
        aliases:
          - xiron_4001_hum
      tunex_c001_bat:
        sensor_type: battery
        aliases:
          - xiron_4001_bat
```
