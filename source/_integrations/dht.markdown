---
title: DHT Sensor
description: Instructions on how to integrate DHTxx sensors within Home Assistant.
ha_category:
  - DIY
ha_release: 0.7
logo: dht.png
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/GsG1OClojOk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`dht` 센서 플랫폼을 사용하면 DHT11, DHT22 또는 AM2302 장치에서 현재 온도와 습도를 얻을 수 있습니다.

## 설정

설치시 DHTxx 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  platform: dht
  sensor: DHT22
  pin: 23
  monitored_conditions:
    - temperature
    - humidity
```

{% configuration %}
sensor:
  description: The sensor type, supported devices are DHT11, DHT22, and AM2302.
  required: true
  type: string
pin:
  description: The pin the sensor is connected to.
  required: true
  type: integer
name:
  description: The name of the sensor.
  required: false
  default: DHT Sensor
  type: string
monitored_conditions:
  description: Conditions to monitor. Available conditions are only *temperature* and *humidity*.
  required: true
  type: list
  keys:
    temperature:
      description: Temperature at the sensor's location.
    humidity:
      description: Humidity level at the sensor's location.
temperature_offset:
  description: Add or subtract a value from the temperature.
  required: false
  default: 0
  type: [integer, float]
humidity_offset:
  description: Add or subtract a value from the humidity.
  required: false
  default: 0
  type: [integer, float]
{% endconfiguration %}

센서가 연결된 핀 이름은 플랫폼마다 이름이 다릅니다. 비글 본의 경우 'P8_11', 라즈베리 파이의 경우 '23'.

### 사례

GPIO4 (PIN 7)에 연결된 DHT22 센서가 있는 Raspberry Pi 3의 예 :

```yaml
sensor:
  - platform: dht
    sensor: DHT22
    pin: 4
    temperature_offset: 2.1
    humidity_offset: -3.2
    monitored_conditions:
      - temperature
      - humidity
```
