---
title: 일반 온도조절기
description: Turn Home Assistant into a thermostat
logo: home-assistant.png
ha_category:
  - Climate
ha_release: pre 0.7
ha_iot_class: Local Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/beSIUfOL7io" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`generic_thermostat` climate(냉난방) 플랫폼은 홈어시스턴트에서 구현되는 온도조절기입니다. 후드 아래의 히터 또는 에어컨에 연결된 센서와 스위치를 사용합니다. 히터 모드에있을 때 측정 온도가 목표 온도보다 낮으면 필요한 온도에 도달하면 히터가 켜지고 꺼집니다. 에어컨 모드에서 측정된 온도가 목표온도보다 높으면 필요한 온도에 도달하면 에어컨이 켜지고 꺼집니다. 하나의 Generic Thermostat 엔티티는 하나의 스위치만 제어 할 수 있습니다. 두 개의 스위치 (히터 용과 에어컨 용)를 활성화해야하는 경우 두 개의 일반 온도 조절기 엔터티가 필요합니다.

```yaml
# Example configuration.yaml entry
climate:
  - platform: generic_thermostat
    name: Study
    heater: switch.study_heater
    target_sensor: sensor.study_temperature
```

{% configuration %}
name:
  description: 온도 조절기의 이름.
  required: true
  default: Generic Thermostat
  type: string
heater:
  description: "히터스위치의 `entity_id`는 토글장치여야합니다. `ac_mode`가 `true`로 설정되면 에어컨 스위치가됩니다."
  required: true
  type: string
target_sensor:
  description: "온도센서의 `entity_id`의 `target_sensor.state` 상태는 반드시 온도여야합니다."
  required: true
  type: string
min_temp:
  description: 사용 가능한 최소 설정치를 설정.
  required: false
  default: 7
  type: float
max_temp:
  description: 사용 가능한 최대 설정치를 설정.
  required: false
  default: 35
  type: float
target_temp:
  description: 초기 목표 온도를 설정. 이 변수를 설정하지 않으면 시작시 목표 온도가 null로 설정됩니다. 버전 0.59부터는 사용 가능한 경우 다시 시작하기 전에 설정된 목표 온도를 유지합니다.
  required: false
  type: float
ac_mode:
  description: "*히터* 옵션에 지정된 스위치를 가열 장치 대신 냉각 장치로 처리하도록 설정"
  required: false
  type: boolean
  default: false
min_cycle_duration:
  description: "*히터* 옵션에 지정된 스위치가 꺼지거나 켜지기 전에 현재 상태에 있어야 하는 최소 시간을 설정."
  required: false
  type: [time, integer]
cold_tolerance:
  description: "*target_sensor* 옵션에 지정된 센서가 읽은 온도와 전원을 켜기 전에 변경해야하는 대상 온도 사이의 최소 차이를 설정하십시오. 예를 들어, 목표 온도가 25이고 허용오차가 0.5 인 경우 센서가 24.5와 같거나 낮아지면 히터가 시작됩니다. "
  required: false
  default: 0.3
  type: float
hot_tolerance:
  description: "*target_sensor*옵션에 지정된 센서가 읽은 온도와 꺼지기 전에 변경해야하는 목표 온도 사이의 최소 차이를 설정하십시오 . 예를 들어 목표 온도가 25이고 허용오차가 0.5이면 센서가 25.5 이상이되면 히터가 정지합니다. "
  required: false
  default: 0.3
  type: float
keep_alive:
  description: 연결 유지 간격을 설정하십시오. 설정된 경우 간격이 경과 할 때마다 히터 옵션에 지정된 스위치가 트리거됩니다. 리모컨에서 신호를 받지 못하면 히터 및 A/C 장치와 함께 사용하십시오. 상태가 사라질 수도 있는 스위치와 함께 사용하십시오. 연결 유지 호출(keep-alive call)은 현재 유효한 climate(냉난방기) 연동 상태 (켜기 또는 끄기)로 수행됩니다.
  required: false
  type: [time, integer]
initial_hvac_mode:
  description: "초기 HVAC 모드를 설정. 유효한 값은 `off`, `heat` 혹은 `cool` 값은 큰 따옴표로 묶어야합니다. 이 매개 변수를 설정하지 않으면 *keep_alive* 값 을 설정하는 것이 좋습니다 . 이는 *generic_thermostat* 와 *heater* 상태 간에 불일치를 맞추는 데 도움이됩니다."
  required: false
  type: string
away_temp:
  description: "`preset_mode: away`에 사용되는 온도를 설정하십시오. 이를 지정하지 않으면 사전 설정 모드 기능을 사용할 수 없습니다"
  required: false
  type: float
precision:
  description: "이 장치의 원하는 정밀도. 실제 온도 조절 장치의 정밀도와 일치시키는 데 사용할 수 있습니다. 지원되는 값은 `0.1`, `0.5` 그리고 `1.0`."
  required: false
  type: float
  default: "`0.5` for Celsius and `1.0` for Fahrenheit."
{% endconfiguration %}

`min_cycle_duration` 및 `keep_alive`의 시간은 "hh:mm:ss"로 설정하거나 다음 항목 중 하나 이상을 포함해야합니다.: `days:`, `hours:`, `minutes:`, `seconds:` or `milliseconds:`. 또는 시간을 초 단위로 나타내는 정수일 수 있습니다.

현재 `generic_thermostat` 냉난방(climate) 플랫폼은 'heat', 'cool' 및 'off' hvac 모드를 지원합니다. HVAC 모드를 'off'로 설정하면 `generic_thermostat`가 시작되지 않도록 할 수 있습니다.

사전 설정 모드를 변경하면 사전 설정 모드가 다시 none으로 설정되면 목표 온도를 강제로 변경하여 복원됩니다.

## 전체 설정 사례 

```yaml
climate:
  - platform: generic_thermostat
    name: Study
    heater: switch.study_heater
    target_sensor: sensor.study_temperature
    min_temp: 15
    max_temp: 21
    ac_mode: false
    target_temp: 17
    cold_tolerance: 0.3
    hot_tolerance: 0
    min_cycle_duration:
      seconds: 5
    keep_alive:
      minutes: 3
    initial_hvac_mode: "off"
    away_temp: 16
    precision: 0.1
```
