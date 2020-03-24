---
title: 에어비쥬얼(AirVisual)
description: Instructions on how to use AirVisual data within Home Assistant
logo: airvisual.jpg
ha_category:
  - Health
ha_release: 0.53
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@bachya'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/5wMMUuBUJlk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>


`airvisual` 센서 플랫폼은 대기질 데이터에 대한 [AirVisual](https://airvisual.com/) API를 쿼리합니다. 위도/경도 또는 도시/주/국가를 통해 데이터를 수집 할 수 있습니다. 결과 정보는 대기질 지수(AQI), 인간 친화적 대기질 레벨 및 해당 지역의 주요 오염 물질에 대한 센서를 생성합니다. [U.S. and Chinese air quality standards](https://www.clm.com/publication.cfm?ID=366) 둘 중 하나에 맞는 센서를 만들 수 있습니다.

이 플랫폼에는 AirVisual API 키가 필요합니다. [here](https://airvisual.com/api) 참조. 플랫폼은 "Community" 패키지를 사용하여 설계되었습니다. "Startup " 및 "Enterprise" 패키지 키는 계속 작동하지만 실제 결과는 다를 수 있습니다 (또는 전혀 작동하지 않을 수 있음).

Community API 키는 12 개월 동안 유효하며 이후 만료됩니다. 그런 다음 Airvisual 웹 사이트로 돌아가서 이전 키를 삭제하고 동일한 단계에 따라 새 키를 생성 한 다음 새 키로 설정을 업데이트해야 합니다.

<div class='note warning'>

"커뮤니티"API 키는 한 달에 10,000 건으로 제한됩니다. 버퍼를 남기기 위해 `airvisual` 플랫폼은 기본적으로 10 분(600 초)마다 API를 쿼리합니다. (`scan_interval 키`)를 통해 이를 너무 낮은 값으로 수정하면 API 키가 비활성화 될 수 있습니다.

</div>

## 설정

플랫폼을 활성화하고 위도/경도를 통해 데이터를 수집하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오.

```yaml
sensor:
  - platform: airvisual
    api_key: YOUR_AIRVISUAL_API_KEY
```

{% configuration %}
api_key:
  description: AirVisual API 키.
  required: true
  type: string
monitored_conditions:
  description: "사용할 대기질 표준 (`us`: 미국, `cn`: 중국)."
  required: true
  type: list
  default: ['us', 'cn']
show_on_map:
  description: "지정된 위치에서 지도에 마커를 표시할지 여부."
  required: false
  type: boolean
  default: true
scan_interval:
  description: "새 데이터에 대해 AirVisual을 폴링해야 하는 속도 (초)"
  required: false
  type: integer
  default: 600
latitude:
  description: 모니터링 할 위치의 위도.
  required: false
  type: string
  default: "The latitude defined under the `homeassistant` key in `configuration.yaml`."
longitude:
  description: 모니터링 할 위치의 경도.
  required: false
  type: string
  default: "The longitude defined under the `homeassistant` key in `configuration.yaml`."
city:
  description: 모니터링 할 도시.
  required: false
  type: string
state:
  description: 도시가 속한 주(state).
  required: false
  type: string
country:
  description: 주(state)가 속한 국가.
  required: false
  type: string
{% endconfiguration %}

## 설정 사례

사용자 지정 위도 및 경도를 사용한 설정 :

```yaml
sensor:
  - platform: airvisual
    api_key: YOUR_AIRVISUAL_API_KEY
    monitored_conditions:
      - cn
    show_on_map: false
    scan_interval: 300
    latitude: 42.81212
    longitude: 108.12422
```

도시, 주 및 국가를 사용하여 설정 :

```yaml
sensor:
  - platform: airvisual
    api_key: YOUR_AIRVISUAL_API_KEY
    monitored_conditions:
      - us
    show_on_map: false
    scan_interval: 300
    city: Los Angeles
    state: California
    country: USA
```

## 도시/주/국가 결정 

특정 위치에 대한 적절한 값을 쉽게 결정하려면 [AirVisual 지역 디렉토리](https://airvisual.com/world)를 사용하십시오. 원하는 특정 도시를 탐색 한 후 `country > state/region > city` 형식의 이동 경로 제목을 기록해 두십시오. 이 정보를 사용하여 `configuration.yaml`을 작성하십시오.

예를 들어 브라질의 상파울루에는 `Brazil > Sao Paulo > Sao Paulo` 라는 이동 경로 제목이 표시됩니다. 따라서 올바른 설정은 다음과 같습니다.

```yaml
sensor:
  - platform: airvisual
    api_key: abc123
    monitored_conditions:
      - us
      - cn
    city: sao-paulo
    state: sao-paulo
    country: brazil
```

## Sensor 타입

설정이 완료되면, 플랫폼은 설정된 각 대기질 표준에 대해 3 개의 센서를 만듭니다. :

### 대기질 지수 

- **Description:** 이 센서는 공기의 전체 "health"에 대한 지표인 수치 대기질 지수(AQI)를 표시합니다.
- **Example Sensor Name:** `sensor.chinese_air_quality_index`
- **Example Sensor Value:** `32`
- **Explanation:**

AQI | Status | Description
------- | :----------------: | ----------
0 - 50  | **Good** | 대기질은 만족스럽고 대기 오염은 거의 또는 전혀 위험하지 않습니다
51 - 100  | **Moderate** | 대기질은 적당합니다. 그러나 일부 오염 물질의 경우 대기 오염에 비정상적으로 민감한 소수의 사람들에게 건강에 대한 우려가 약간 있을 수 있습니다
101 - 150 | **Unhealthy for Sensitive Groups** | 민감한 그룹의 구성원은 건강에 영향을 줄 수 있습니다. 일반 대중은 영향을 받지 않을 것입니다
151 - 200 | **Unhealthy** | 모든 사람이 건강에 영향을 미칠 수 있습니다. 민감한 그룹의 구성원은 더 심각한 건강 영향을 경험할 수 있습니다. 
201 - 300 | **Very unhealthy** | 응급 상황에 대한 건강 경고. 전체 인구가 영향을 받을 가능성이 더 큽니다. 
301+ | **Hazardous** | 건강 경고 : 모든 사람이 보다 심각한 건강 영향을 경험할 수 있습니다. 

### 대기 오염 수준

- **Description:** 이 센서는 현재 AQI에 대한 관련 `Status` (위 표에서)를 표시합니다.
- **Sample Sensor Name:** `sensor.us_air_pollution_level`
- **Example Sensor Value:** `Moderate`

### Main Pollutant

- **Description:** 이 센서는 현재 값이 가장 높은 오염 물질을 표시합니다.
- **Sample Sensor Name:** `sensor.us_main_pollutant`
- **Example Sensor Value:** `PM2.5`
- **Explanation:**

Pollutant | Symbol | More Info
------- | :----------------: | ----------
미세먼지 (<= 2.5 μm) | PM2.5 | [EPA: Particulate Matter (PM) Pollution ](https://www.epa.gov/pm-pollution)
미세먼지 (<= 10 μm) | PM10 | [EPA: Particulate Matter (PM) Pollution ](https://www.epa.gov/pm-pollution)
오존 | O | [EPA: Ozone Pollution](https://www.epa.gov/ozone-pollution)
이산화황 | SO2 | [EPA: Sulfur Dioxide (SO2) Pollution](https://www.epa.gov/so2-pollution)
일산화탄소 | CO | [EPA: Carbon Monoxide (CO) Pollution in Outdoor Air](https://www.epa.gov/co-pollution)
