---
title: 세계이산화탄소측정(CO2 Signal)
description: Instructions on how to use CO2Signal data within Home Assistant
logo: co2signal.png
ha_category:
  - Environment
ha_release: 0.87
ha_iot_class: Cloud Polling
---

<iframe width="690" height="437" src="https://www.youtube.com/embed/S5wHTIZ8vEk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>

`co2signal` 센서 플랫폼은 [CO2Signal](https://www.co2signal.com/) API에 특정 지역의 CO2 강도를 쿼리합니다. 위도/경도 또는 국가 코드를 통해 데이터를 수집할 수 있습니다. 이 API는 <https://www.electricitymap.org>와 동일한 데이터를 사용합니다. 전 세계의 모든 국가/지역이 지원되는 것은 아니므로 이 웹사이트를 참조하여 로컬 가용성을 확인하십시오.

이 플랫폼에는 [여기](https://www.co2signal.com/)에서 얻을 수 있는 CO2Signal API 키가 필요합니다. 이 API 키는 개인용이며 데이터가 상업적으로 사용될 때 다른 옵션을 써야합니다.

현재 무료 CO2Signal API는 한계 탄소 강도가 아닌 국가의 평균 탄소 강도 만 지원합니다.

<div class='note warning'>
"무료" API 키는 제한된 수의 호출로 제한됩니다. 요청이 너무 많으면 데이터가 손실 될 수 있습니다.
</div>

## 설정

이 플랫폼을 설정하려면 [API 키](https://www.co2signal.com/)를 가져 와서 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
sensor:
  - platform: co2signal
    token: YOUR_CO2SIGNAL_API_KEY
```

기본적으로 센서는 홈어시스턴트 경도 및 위도를 사용합니다. 이를 덮어쓰는 보다 자세한 설정은 아래에서 확인할 수 있습니다.

{% configuration %}
token:
  description: Your CO2Signal API key.
  required: true
  type: string
latitude:
  description: The latitude of the location to monitor.
  required: false
  type: string
  default: "The latitude defined under the `homeassistant` key in `configuration.yaml`."
longitude:
  description: The longitude of the location to monitor.
  required: false
  type: string
  default: "The longitude defined under the `homeassistant` key in `configuration.yaml`."
country_code:
  description: The country code or region code.
  required: false
  type: string
{% endconfiguration %}

플랫폼을 활성화하고 특정 위도/경도를 통해 데이터를 수집하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
sensor:
  - platform: co2signal
    token: YOUR_CO2SIGNAL_API_KEY
    latitude: YOUR_LATITUDE
    longitude: YOUR_LONGITUDE
```

국가 코드를 사용하여 유사한 결과를 얻을 수 있습니다. 이 경우 `configuration.yaml` 파일에서 다음 줄을 사용하십시오.

```yaml
sensor:
  - platform: co2signal
    token: YOUR_CO2SIGNAL_API_KEY
    country_code: YOUR_COUNTRY_CODE
```

## 설정 사례

사용자 지정 위도 및 경도를 사용한 설정 :

```yaml
sensor:
  - platform: co2signal
    token: YOUR_CO2SIGNAL_API_KEY
    latitude: 55.4
    longitude: 5.5
```

국가 코드를 사용한 설정 :

```yaml
sensor:
  - platform: co2signal
    token: YOUR_CO2SIGNAL_API_KEY
    country_code: BE
```

## Sensor 타입들

연동된 플랫폼은 설정된 각 위치에 대해 하나의 센서를 만듭니다.