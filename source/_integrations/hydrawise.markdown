---
title: 헌터 하이드라와이즈(Hunter Hydrawise)
description: Instructions on how to integrate your Hunter Hydrawise Wi-Fi irrigation control system within Home Assistant.
logo: hydrawise_logo.png
ha_category:
  - Irrigation
  - Binary Sensor
  - Sensor
  - Switch
ha_release: 0.71
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/z2UtOoHIzoM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`hydrawise` 통합구성요소를 통해 [Hunter Hydrawise](https://hydrawise.com) Wi-Fi 관개 컨트롤러 시스템을 Home Assistant에 연동할 수 있습니다.

현재 홈어시스턴트에는 다음과 같은 장치 유형이 지원됩니다. : 

- [Binary Sensor](#binary-sensor)
- [Sensor](#sensor)
- [Switch](#switch)

## 설정

이를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
hydrawise:
  access_token: YOUR_API_KEY
```

{% configuration %}
access_token:
  description: The API KEY assigned to your Hydrawise account.
  required: true
  type: string
scan_interval:
  description: The time interval, in seconds, to poll the Hydrawise cloud.
  required: false
  type: integer
  default: 30
{% endconfiguration %}

API 액세스 토큰을 [Hydrawise account](https://app.hydrawise.com/config/login)에 로그인하고 계정 설정의 'My Account Details'섹션에서 'Generate API Key'을 클릭하십시오. 설정 파일에 해당 키를 `API_KEY`로 입력하십시오.

## Binary Sensor

hydrawise 컴포넌트를 활성화 한 후 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: hydrawise
```

{% configuration %}
monitored_conditions:
  description: The binary sensors that should be displayed on the frontend.
  required: false
  type: list
  default: All binary sensors are enabled.
  keys:
    is_watering:
      description: The binary sensor is `on` when the zone is actively watering.
    rain_sensor:
      description: Is `on` when the rain_sensor (if installed on the controller) is active (wet).
    status:
      description: This will indicate `on` when there is a connection to the Hydrawise cloud. It is not an indication of whether the irrigation controller hardware is online.
{% endconfiguration %}

## Sensor

hydrawise 컴포넌트를 활성화 한 후 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: hydrawise
```

{% configuration %}
monitored_conditions:
  description: The sensors that should be displayed on the frontend.
  required: false
  type: list
  default: All sensors are enabled.
  keys:
    watering_time:
      description: The amount of time left if the zone is actively watering. Otherwise the time is 0.
    next_cycle:
      description: The day and time when the next scheduled automatic watering cycle will start. If the zone is suspended then the value will be `NS` to indicate Not Scheduled.
  {% endconfiguration %}

## Switch

`hydrawise` 컴포넌트를 활성화 한 후 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: hydrawise
```

{% configuration %}
watering_minutes:
  description: When manual watering is enabled this will determine the length of time in minutes that the irrigation zone will run. The allowed values are 5, 10, 15, 30, 45, or 60.
  required: false
  type: integer
  default: 15
monitored_conditions:
  description: Selects the set of switches that should be enabled on the frontend. Also sets the length of time a zone will run under manual control.
  required: false
  type: list
  default: All switches are enabled.
  keys:
    auto_watering:
      description: Enables the Smart Watering features for this zone.
    manual_watering:
      description: Enables the manual watering control for this zone.
{% endconfiguration %}

### Switch Operation

`auto_watering`이 `on`인 경우 관개 구역은 Hydrawise [mobile or web app](https://www.hydrawise.com)을 통해 설정된 Smart Watering 일정을 따릅니다. `auto_watering` 스위치가 `off`이면 해당 구역의 Smart Watering 일정이 1 년 동안 일시 중지됩니다.

`manual_watering`이 `on`인 경우 구역(zone)은 `watering_minutes`에 설정된 시간 동안 실행됩니다.

```yaml
# An example that enables all the switches, and sets the manual watering time to 20 minutes.
switch:
  - platform: hydrawise
    watering_minutes: 20
```

```yaml
# An example that enables only the manual control switches.
switch:
  - platform: hydrawise
    monitored_conditions: manual_watering
```
