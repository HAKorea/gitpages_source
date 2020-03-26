---
title: 식물 관리(Plant Monitor)
description: Instructions on how to setup plant monitoring with Home Assistant.
logo: home-assistant.png
ha_category:
  - Environment
ha_release: 0.44
ha_quality_scale: internal
ha_codeowners:
  - '@ChristianKuehnel'
---

이 `plant` 구성 요소를 사용하면 식물의 수분, 전도도, 광도, 온도 및 배터리 수준을 단일 UI 요소로 병합할 수 있습니다. 또한 각 측정에 대한 최소값과 최대 값 설정을 지원하며 해당 한계 내에 있지 않은 경우 상태를 "problem"로 변경합니다. 

## 설정

`plant` 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
plant:
  name_of_your_plant:
    sensors:
      moisture: sensor.my_sensor_moisture
      battery: sensor.my_sensor_battery
      temperature: sensor.my_sensor_temperature
      conductivity: sensor.my_sensor_conductivity
      brightness: sensor.my_sensor_brightness
    min_moisture: 20
```

{% configuration %}
entity_id:
  description: Set by you and is used by the integration as the `entity_id`.
  required: true
  type: list
  keys:
    sensors:
      description: List of sensor measure entities.
      required: true
      type: list
      keys:
        moisture:
          description: Moisture of the plant. Measured in %. Can have a min and max value set optionally.
          required: false
          type: string
        battery:
          description: Battery level of the plant sensor. Measured in %. Can only have a min level set optionally.
          required: false
          type: string
        temperature:
          description: Temperature of the plant. Measured in degrees Celsius. Can have a min and max value set optionally.
          required: false
          type: string
        conductivity:
          description: Conductivity of the plant. Measured in µS/cm. Can have a min and max value set optionally.
          required: false
          type: string
        brightness:
          description: Light exposure of the plant. Measured in Lux. Can have a min and max value set optionally.
          required: false
          type: string
    min_moisture:
      description: Minimum moisture level before triggering a problem.
      required: false
      default: 20
      type: integer
    max_moisture:
      description: Maximum moisture level before triggering a problem.
      required: false
      default: 60
      type: integer
    min_battery:
      description: Minimum battery level before triggering a problem.
      required: false
      default: 20
      type: integer
    min_conductivity:
      description: Minimum conductivity level before triggering a problem.
      required: false
      default: 500
      type: integer
    max_conductivity:
      description: Maximum conductivity level before triggering a problem.
      required: false
      default: 3000
      type: integer
    min_temperature:
      description: Minimum temperature before triggering a problem.
      required: false
      type: float
    max_temperature:
      description: Maximum temperature before triggering a problem.
      required: false
      type: float
    min_brightness:
      description: Minimum brightness before triggering a problem. In contrast to the other values, this check is *not* looking at the current situation, but rather at the last days. A problem is only reported if the maximum brightness over the last days was lower than min_brightness. You can use this to check if the plant gets enough light during the course of the day.
      required: false
      type: integer
    max_brightness:
      description: Maximum brightness before triggering a problem.
      required: false
      type: integer
    check_days:
      description: time interval (in days) used when checking `min_brightness`.
      required: false
      default: 3
      type: integer
{% endconfiguration %}

## 사례

### 일반 MQTT 센서를 사용하여 데이터 가져 오기

이는 `plant` 센서가 사용하는 판독값을 제공하기 위해 다수의 `MQTT sensors`를 사용하는 실제 예입니다.
이 데이터의 또 다른 좋은 소스는 [Mi Flora](/integrations/miflora) 구성 요소입니다.

센서 데이터가 최소/최대값 내에있는 경우 상태는 `ok`이며, 그렇지 않으면 상태는 `problem`입니다. plant에 문제가있는 경우 이를 사용하여 알림을 트리거 할 수 있습니다. 물론 센서가 설정되고 데이터를 제공하는 시스템의 속성만 모니터링 할 수 있습니다.

## 데이터 소스

데이터의 주요 소스는 일반적으로 [PlantGateway](https://github.com/ChristianKuehnel/plantgateway)에서 데이터를 수신하는 [MiFlora sensor](/integrations/miflora) 또는 [MQTT sensor](/integrations/sensor.mqtt/)입니다.

PlantGateway를 통해 데이터를 얻기위한 MQTT 센서의 일반적인 설정입니다.

{% raw %}

```yaml
# Example configuration.yaml entry
plant:
  simulated_plant:
    sensors:
      moisture: sensor.mqtt_plant_moisture
      battery: sensor.mqtt_plant_battery
      temperature: sensor.mqtt_plant_temperature
      conductivity: sensor.mqtt_plant_conductivity
      brightness: sensor.mqtt_plant_brightness
    min_moisture: 20
    max_moisture: 60
    min_battery: 17
    min_conductivity: 500
    min_temperature: 15

sensor:
  - platform: mqtt
    name: my_plant_moisture
    state_topic: my_plant_topic
    value_template: '{{ value_json.moisture | int }}'
    unit_of_measurement: '%'
  - platform: mqtt
    name: my_plant_battery
    state_topic: my_plant_topic
    value_template: '{{ value_json.battery | int }}'
    unit_of_measurement: '%'
  - platform: mqtt
    name: my_plant_temperature
    state_topic: my_plant_topic
    value_template: '{{ value_json.temperature | float }}'
    unit_of_measurement: '°C'
  - platform: mqtt
    name: my_plant_conductivity
    state_topic: my_plant_topic
    value_template: '{{ value_json.conductivity | int }}'
    unit_of_measurement: 'µS/cm'
  - platform: mqtt
    name: my_plant_brightness
    state_topic: my_plant_topic
    value_template: '{{ value_json.brightness | int }}'
    unit_of_measurement: 'Lux'
```

{% endraw %}

`state_topic`을 PlantGateway에서 설정한 값으로 바꿔야합니다. 또한 MQTT 서버의 글로벌 설정에 따라 다릅니다.