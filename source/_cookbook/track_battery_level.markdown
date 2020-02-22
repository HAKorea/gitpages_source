---
title: "휴대폰 밧데리 잔량 추적"
description: "Basic example how to track the battery level of your mobile devices."
ha_category: Automation Examples
---

### 안드로이드 및 IOS 기기
[Home Assistant Companion Apps](https://companion.home-assistant.io/) iOS 및 안드로이드에 모든 위치 업데이트와 홈 어시스턴트에 현재 배터리 잔량을 전달합니다. 사용되는 센서의 기본 이름은 `sensor.battery_level`입니다

### iOS 기기

iOS (iPhone, iPad 등)를 실행하는 기기가있는 경우 [iCloud](/integrations/icloud) 통합구성요소는 배터리 잔량을 포함하여 기기에 대한 다양한 세부 정보를 수집합니다. 프론트 엔드에 표시하려면 [template sensor](/integrations/template)를 사용하십시오. `battery` [sensor device class](/integrations/sensor/#device-class)를 사용하여 배터리 수준에 따라 아이콘을 동적으로 변경할 수 있습니다.

{% raw %}
```yaml
sensor:
  - platform: template
    sensors:
      battery_iphone:
        friendly_name: iPhone Battery
        unit_of_measurement: '%'
        value_template: >-
            {%- if state_attr('device_tracker.iphone', 'battery') %}
                {{ state_attr('device_tracker.iphone', 'battery')|round }}
            {% else %}
                {{ states('sensor.battery_iphone') }}
            {%- endif %}
        device_class: battery
```
{% endraw %}

### 안드로이드 기기

Android 기기에서 공식 [Home Assistant companion app](https://companion.home-assistant.io/)을 설치하고 Home Assistance 인스턴스에 연결하면 프런트 엔드에 배터리 잔량을 표시 할 수 있습니다 [template sensor](/integrations/template)를 YAML 설정 파일에 추가합니다. 배터리 [sensor device class](/integrations/sensor/#device-class)를 사용하여 배터리 수준에 따라 아이콘을 동적으로 변경할 수 있습니다

{% raw %}
```yaml
sensor:
  - platform: template
    sensors:
      battery_phone:
        friendly_name: AndroidPhone Battery
        unit_of_measurement: '%'
        value_template: >-
            {%- if state_attr('device_tracker.xxxxx', 'battery_level') %}
                {{ state_attr('device_tracker.xxxxx', 'battery_level')|round }}
            {% else %}
                {{ states('device_tracker.xxxxx') }}
            {%- endif %}
        device_class: battery
```
{% endraw %}

Configuration/Devices Device Info/Entities에 표시된 대로 'device_tracker.xxxxx'를 휴대폰 이름으로 바꾸십시오 (예 : 'device_tracker.mi_a1'

#### MQTT

MQTT를 통해 보고서를 보내도록 자체 트랙을 구성한 경우 MQTT 센서를 통해 수신 된 데이터를 사용할 수 있습니다. 사용자 이름을 MQTT 사용자 이름으로 바꾸고 deviceid는 자체 트랙의 설정된 장치 ID로 바꾸십시오.

{% raw %}
```yaml
sensor:
  - platform: mqtt
    state_topic: "owntracks/username/deviceid"
    name: "Battery Tablet"
    unit_of_measurement: "%"
    value_template: '{{ value_json.batt }}'
    device_class: battery
```
{% endraw %}

#### HTTP

HTTP를 통해 홈어시스턴트 인스턴스로 보고서를 보내도록 Owntracks를 설정한 경우 템플리트 센서를 사용할 수 있습니다. `deviceid`를 Owntracks의 설정된 장치 ID로 바꿉니다.

{% raw %}
```yaml
sensor:
- platform: template
    sensors:
      your_battery_sensor_name:
        value_template: "{{ state_attr('device_tracker.deviceid', 'battery_level') }}"
        unit_of_measurement: '%'
```
{% endraw %}
