---
title: 개인기상관측(BloomSky)
description: Instructions on how to integrate the BloomSky within Home Assistant.
logo: bloomsky.png
ha_category:
  - Environment
  - Binary Sensor
  - Camera
  - Sensor
ha_release: 0.14
ha_iot_class: Cloud Polling
---

`bloomsky` 통합구성요소를 통해 [BloomSky](https://www.bloomsky.com/) 기상 관측소에 액세스 할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다.

- [Binary Sensor](#binary-sensor)
- [Camera](#camera)
- [Sensor](#sensor)

## 셋업

[BloomSky 대시 보드](https://dashboard.bloomsky.com)에서 API 키를 얻습니다. 화면 왼쪽 하단에서 `developers`를 클릭하십시오.

## 설정

BloomSky 허브와 홈어시스턴트를 통합하려면 `configuration.yaml` 파일에 다음 섹션을 추가하십시오.

```yaml
# Example configuration.yaml entry
bloomsky:
  api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your BloomSky API key.
  required: true
  type: string
{% endconfiguration %}

## Binary Sensor

`bloomsky` 이진 센서 플랫폼을 사용하면 BloomSky 장치에서 데이터를 얻을 수 있습니다.

BloomSky 바이너리 센서가 홈어시스턴트와 작동하게 하려면 먼저 위의 지시 사항을 따르십시오.

### 설정

설비에서 BloomSky 바이너리 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: bloomsky
    monitored_conditions:
      - Night
      - Rain
```

{% configuration %}
monitored_conditions:
  description: "The sensors that you wish to monitor on all of your devices. Select from these options:"
  required: true
  type: list
  keys:
    night:
      description: Night
    rain:
      description: Rain
{% endconfiguration %}

## Camera

`bloomsky` 카메라 통합구성요소를 통해 [BloomSky](https://www.bloomsky.com) 기상 관측소에서 카메라로 생성된 현재 사진을 볼 수 있습니다. 이것은 [BloomSky sensor](#sensor)와 함께 작동할 수 있습니다.

### 설정

설치시이 카메라를 활성화하려면 API 키와 BloomSky 연동을 설정하고 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
camera:
  - platform: bloomsky
```

## Sensor

`bloomsky` 센서 연동을 통해 [BloomSky](https://www.bloomsky.com) 기상 관측소의 센서로 측정한 값을 볼 수 있습니다. 이것은 [BloomSky camera](#camera)와 함께 작동할 수 있습니다.

### 설정

설치시 이러한 센서를 활성화하려면 API 키와 BloomSky 연동을 설정하여 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  platform: bloomsky
  monitored_conditions:
    - Temperature
    - Humidity
    - Pressure
    - UVIndex
    - Luminance
    - Voltage
```

{% configuration %}
monitored_conditions:
  description: "The sensors that you wish to monitor on all of your devices. Select from these options:"
  required: true
  type: list
  keys:
    humidity:
      description: Humidity
    luminance:
      description: Luminance
    pressure:
      description: Pressure
    temperature:
      description: Temperature
    uvindex:
      description: UVIndex
    voltage:
      description: Voltage
{% endconfiguration %}

[BloomSky binary sensor](#binary-sensor) 구성 요소를 사용하여 더 많은 조건을 사용할 수 있습니다.