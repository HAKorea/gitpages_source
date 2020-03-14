---
title: 세계자외선오존데이터(Openuv)
description: Instructions on how to integrate OpenUV within Home Assistant.
logo: openuv.jpg
ha_category:
  - Health
  - Binary Sensor
  - Sensor
ha_release: 0.76
ha_iot_class: Cloud Polling
ha_config_flow: true
ha_codeowners:
  - '@bachya'
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/_5uLx83s10w?list=PLWlpiQXaMerTyzl_Pe1PEloZTj9MoU5cl" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`openuv` 통합구성요소는 [openuv.io](https://www.openuv.io/)의 UV 및 오존 데이터를 표시합니다.

## API 키 만들기

API 키 만들기,
[simply log in to the OpenUV website](https://www.openuv.io/auth/google).

<div class='note warning'>

2019 년 2 월 1 일부터 "Limited" 플랜 (기본적으로 새로운 사용자에게 제공되는 플랜)은 하루에 50 건의 API 요청으로 제한됩니다. API 계획과 지역마다 요구 사항이 다르기 때문에 `openuv` 구성 요소는 API가 처음 로드된 후 새 데이터를 자동으로 쿼리하지 않습니다. 새로운 데이터를 요청하기 위해 `update_data` 서비스가 사용될 수 있습니다.

</div>

<div class='note warning'>

`update_data` 서비스를 사용할 때마다 모니터링 되는 조건이 설정되는 것에 따라 1 또는 2 개의 API 호출이 소비됩니다.

OpenUV 통합구성요소가 홈어시스턴트 UI를 통해 ( `설정 >> 통합구성요소` 패널을 통해) 설정된 경우 각 서비스 호출은 일일 할당량에서 2 개의 API 호출을 소비합니다.

`configuration.yaml`을 통해 OpenUV 연동이 설정된 경우, `monitored_conditions`에 `uv_protection_window`와 다른 조건이 모두 포함되어 있으면 서비스 호출에서 2 개의 API 호출이 소비됩니다. 다른 시나리오는 1 회의 API 호출만 소비합니다.

`update_data` 서비스를 호출할 때 이러한 스펙을 이해해야합니다.

</div>

## 설정

OpenUV에서 데이터를 검색하려면 `configuration.yaml`에 다음 파일을 추가하십시오. :

```yaml
openuv:
  api_key: YOUR_OPENUV_API_KEY
```

{% configuration %}
api_key:
  description: The OpenUV API key.
  required: true
  type: string
binary_sensors:
  description: The binary sensor-related configuration options.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The conditions to create sensors from.
      required: false
      type: list
      default: all
      keys:
        uv_protection_window:
          description: Displays if UV protection (sunscreen, etc.) is recommended at the current date and time.
sensors:
  description: The sensor-related configuration options.
  required: false
  type: map
  keys:
    monitored_conditions:
      description: The conditions to create sensors from.
      required: false
      type: list
      default: all
      keys:
        current_ozone_level:
          description: The current ozone level in du (Dobson Units).
        current_uv_index:
          description: The current UV index.
        current_uv_level:
          description: "The level of current UV index, which is calculated based on [UV Index Levels & Colors](https://www.openuv.io/kb/uv-index-levels-colors)."
        max_uv_index:
          description: The maximum UV index that will be encountered that day (at solar noon).
        safe_exposure_time_type_1:
          description: The approximate exposure time for skin type I.
        safe_exposure_time_type_2:
          description: The approximate exposure time for skin type II.
        safe_exposure_time_type_3:
          description: The approximate exposure time for skin type III.
        safe_exposure_time_type_4:
          description: The approximate exposure time for skin type IV.
        safe_exposure_time_type_5:
          description: The approximate exposure time for skin type V.
        safe_exposure_time_type_6:
          description: The approximate exposure time for skin type VI.
{% endconfiguration %}

burning/tanning을 시작하기 전에 [Fitzpatrick scale](https://en.wikipedia.org/wiki/Fitzpatrick_scale)에 근거해서 특정 피부 타입에 따라 태양에 노출될 수 있는 대략적인 시간 (분) 나타납니다. 

## 전체 설정 사례

추가 기능을 설정하려면 다음과 같이 `configuration.yaml` 파일의 `openuv` 섹션에 있는 `binary_sensor` 및/또는 `sensor` 키 아래에 설정 옵션을 추가하십시오.

```yaml
openuv:
  api_key: YOUR_OPENUV_API_KEY
  binary_sensors:
    monitored_conditions:
      - uv_protection_window
  sensors:
    monitored_conditions:
      - current_ozone_level
      - current_uv_index
      - current_uv_level
      - max_uv_index
      - safe_exposure_time_type_1
      - safe_exposure_time_type_2
      - safe_exposure_time_type_3
      - safe_exposure_time_type_4
      - safe_exposure_time_type_5
      - safe_exposure_time_type_6
```

<div class='note warning'>
위의 지침은 추정치를 구성하며 정보에 근거한 의사 결정을 돕기위한 것입니다. 숙련된 의료 전문가의 분석, 조언 또는 진단을 대체해서는 안됩니다.
</div>

## 서비스

### `openuv.update_data`

주문형 OpenUV 데이터 업데이트를 수행하십시오.

### `openuv.update_uv_index_data`

`uv_protection_window`가 아닌 현재 UV 인덱스를 포함한 OpenUV 센서 데이터의 주문형 업데이트를 수행하여 update_data에 대한 API 호출을 저장합니다.

### `openuv.update_protection_data`

센서 호출이 아닌 OpenUV `uv_protection_window` 데이터의 주문형 업데이트를 수행하여 API 호출을 저장하십시오.

## 업데이트되고 있는 데이터의 사례

30 분마다 데이터를 검색하고 여전히 많은 API 키 사용량을 남기는 한 가지 방법은 낮 동안만 데이터를 검색하는 것입니다.

```yaml
automation:
  - alias: Update OpenUV every 30 minutes during the daytime
    trigger:
      platform: time_pattern
      minutes: '/30'
    condition:
      condition: and
      conditions:
        - condition: sun
          after: sunrise
        - condition: sun
          before: sunset
    action:
      service: openuv.update_data
```

태양이 수평선 위로 10도 이상인 동안 20 분마다 센서만 업데이트하십시오.

```yaml
automation:
  - alias: Update OpenUV every 20 minutes while the sun is at least 10 degrees above the horizon
    trigger:
      platform: time_pattern
      minutes: '/20'
    condition:
      condition: numeric_state
      entity_id: sun.sun
      value_template: '{{ state.attributes.elevation }}'
      above: 10
    action:
      service: openuv.update_uv_index_data
```

하루에 한 번 protection window를 업데이트하십시오. : 
```yaml
automation:
  - alias: Update OpenUV protection window once a day
    trigger:
      platform: time
      at: "02:12:00"
    action:
      service: openuv.update_protection_data
```

또 다른 방법 (하루에 햇빛이 많은 장소 등에서 홈어시스턴트 위도와 경도 이외의 위치를 ​​모니터링 할 때 유용함)은 API를 덜 자주 쿼리하는 것입니다.

```yaml
automation:
  - alias: Update OpenUV every hour (24 of 50 calls per day)
    trigger:
      platform: time_pattern
      minutes: '/60'
    action:
      service: openuv.update_data
```
