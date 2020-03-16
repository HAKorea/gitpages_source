---
title: 세계해변서핑정보(Magicseaweed)
description: How to integrate Magicseaweed within Home Assistant.
logo: magicseaweed.png
ha_category:
  - Sensor
ha_release: 0.75
ha_iot_class: Cloud Polling
---

`magicseaweed` 플랫폼은 [Magicseaweed Forecast API](https://magicseaweed.com/developer/forecast-api)를 선택한 서핑 지점의 서핑 예측 데이터 소스로 사용합니다.

## 셋업

무료이지만 [registration](https://magicseaweed.com/developer/sign-up)이 필요한 API 키가 필요합니다. Magicseaweed는 무료 사용자를 위해 API 사용자를 한 곳으로 제한하고 있습니다.

## 설정

Magicseaweed 예측을 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: magicseaweed
    api_key: YOUR_API_KEY
    spot_id: 1092
    monitored_conditions:
      - max_breaking_swell
```

{% configuration %}
api_key:
  description: 서비스에 액세스하기위한 API 키.
  required: true
  type: string
name:
  description: 현장 센서의 별창.
  required: false
  default: MSW.
  type: string
hours:
  description: 데이터를 받으려는 시간 목록.
  required: false
  default: Defaults to current forecast.
  type: list
  keys:
    3AM:
      description: 오전 3시 예보 표시.
    6AM:
      description: 오전 6시 예보 표시.
    9AM:
      description: 오전 9시 예보 표시.
    12PM:
      description: 오후 12시 예측 표시.
    3PM:
      description: 오후 3시 예측 표시.
    6PM:
      description: 오후 6시 예측 표시.
    9PM:
      description: 오후 9시 예측 표시.
    12AM:
      description: 오전 12시 예측 표시.
spot_id:
  description: 서핑 장소의 ID. [Magicseaweed](https://magicseaweed.com/developer/forecast-api)에서 사용 가능한 스팟 ID를 얻기위한 세부 사항
  required: true
  type: string
monitored_conditions:
  description: 표시할 데이터 유형.
  required: true
  type: list
  keys:
    swell_forecast:
      description: 현재 요약 상태를 기준으로한 예측 요약 목록.
    min_breaking_swell:
      description: 세부적인 예측 속성 목록이 있는 상태에서 최소 파도 높이입니다.
    max_breaking_swell:
      description: 세부적인 예측 속성 목록이 있는 상태에서 최대 파도 높이입니다.
units:
  description: 단위 시스템을 지정. `uk`, `eu` 혹은 `us`.
  required: false
  default: Default to `uk` or `us` based on the temperature preference in Home Assistant.
  type: string
{% endconfiguration %}

API에 대한 자세한 내용은 [Magicseaweed documentation](https://magicseaweed.com/developer/forecast-api)를 참조하십시오 .