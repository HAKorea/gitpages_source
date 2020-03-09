---
title: Ambient 기상 관측소 
description: How to integrate Ambient Weather station within Home Assistant.
logo: ambient_weather.png
ha_category:
  - Weather
ha_release: 0.85
ha_iot_class: Cloud Push
ha_config_flow: true
ha_codeowners:
  - '@bachya'
---

`Ambient Weather Station` 통합구성요소는 [Ambient Weather](https://ambientweather.net)에서 개인 기상 관측소를 통해 현지 날씨 정보를 검색합니다.

## 셋업

이 통합구성요소를 사용하려면 애플리케이션 키와 API 키가 모두 필요합니다. 두 가지를 모두 생성하려면 [your Ambient Weather dashboard](https://dashboard.ambientweather.net)의 프로파일 섹션을 사용하십시오.

## 설정

Ambient Weather PWS를 Home Assistant 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
ambient_station:
  api_key: YOUR_API_KEY
  app_key: YOUR_APPLICATION_KEY
```

{% configuration %}
api_key:
  description: The API key to access the service.
  required: true
  type: string
app_key:
  description: The Application key to access the service.
  required: true
  type: string
{% endconfiguration %}
