---
title: 바베큐온도계(ThermoWorks Smoke)
description: Pulls temperature data for a ThermoWorks Smoke Thermometer connected with Smoke Gateway.
logo: thermoworks.png
ha_category:
  - Sensor
ha_release: 0.81
ha_iot_class: Cloud Polling
---

`thermoworks_smoke` 센서 플랫폼은 [ThermoWorks Smoke Thermometer](https://www.thermoworks.com/Smoke)의 데이터를 가져옵니다.
인터넷에 연결된 [Smoke WiFi Gateway](https://www.thermoworks.com/Smoke-Gateway)가 필요합니다.

데이터를 연결하고 가져 오려면 모바일 앱을 통해 장치를 계정에 미리 등록하고이 센서의 설정에 사용한 이메일 및 비밀번호를 제공해야합니다.

## 설정

설치에 센서를 추가하려면`configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: thermoworks_smoke
    email: "your email here"
    password: !secret thermoworks_pass
```

{% configuration %}
email:
  description: The email address with the device registered in the thermoworks smoke mobile app.
  required: true
  type: string
password:
  description: The password registered in the thermoworks smoke mobile app.
  required: true
  type: string
monitored_conditions:
  description: The sensors to add. Default is `probe1` and `probe2`. The full list is `probe1`, `probe2`, `probe1_min`, `probe1_max`, `probe2_min`, `probe2_max`.
  required: false
  type: list
exclude:
  description: Device serial numbers to ignore.
  required: false
  type: list
{% endconfiguration %}

## 사례

본 섹션에는 이 센서를 사용하는 방법에 대한 몇 가지 예가 포함되어 있습니다.

### Probe 1만

최소 및 최대 데이터가 있는 Probe 1 만 표시됩니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: thermoworks_smoke
    email: "your email here"
    password: !secret thermoworks_pass
    monitored_conditions:
    - probe1
    - probe1_min
    - probe1_max
```
{% endraw %}

### 장치 무시

이는 센서를 생성하는 장치를 제외시킵니다. `"00:00:00:00:00:00"`를 기기의 일련 번호로 바꿉니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: thermoworks_smoke
    email: "your email here"
    password: !secret thermoworks_pass
    exclude:
    - "00:00:00:00:00:00"
```
{% endraw %}

### Probe 1이 특정 온도를 초과 할 때 알림

자동화를 사용하여 Probe 1이 input_number 변수에 저장된 온도 이상으로 올라간 경우 알림을 트리거합니다.
기본적으로 앱에서 장치 이름은 "My Smoke"입니다. 변경한 경우 센서 이름을 `my_smoke_probe_1`에서 `your_name_probe_1`로 변경해야합니다.

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: thermoworks_smoke
    email: "your email here"
    password: !secret thermoworks_pass

input_number:
  smoke_probe_1_threshold:
    name: Smoke Probe 1 Threshold
    min: -40
    max: 500
    step: 0.5
    unit_of_measurement: '°F'
    icon: mdi:thermometer

automation:
  - alias: Alert when My Smoke Probe 1 is above threshold
    trigger:
      platform: template
      value_template: >-
        {% if (states("sensor.my_smoke_probe_1") | float) > (states("input_number.smoke_probe_1_threshold") | float) %}
          True
        {% else %}
          False
        {% endif %}
    action:
      - service: notify.all
        data:
          message: >
            {{- state_attr('sensor.my_smoke_probe_1','friendly_name') }} is above
            {{- ' '+states("input_number.smoke_probe_1_threshold") -}}
            {{- state_attr('sensor.my_smoke_probe_1','unit_of_measurement') }} at
            {{- ' '+states("sensor.my_smoke_probe_1") -}}
            {{- state_attr('sensor.my_smoke_probe_1','unit_of_measurement') }}
```
{% endraw %}
