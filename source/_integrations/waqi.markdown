---
title: 세계 대기질 지수 (WAQI)
description: Instructions on how to setup World Air Quality Index sensor in Home Assistant.
logo: waqi.png
ha_category:
  - Health
ha_release: 0.34
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@andrey-git'
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/E2kfUJ6pkH4" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`waqi` 센서 플랫폼은 [World Air Quality Index](https://aqicn.org/city/beijing/) 서비스를 쿼리하여 특정 위치 세트에 대한 AQI 값을 확인합니다. 결과 색인은 센서 출력으로 홈어시스턴트에 추가됩니다. 

## 셋업

이 센서에는 API 토큰이 필요합니다. [AQICN API 토큰](https://aqicn.org/data-platform/token/#/)에서 받으십시오.

위치 필드는 위치를 검색합니다. 예를 들어 "brisbane" 또는 "Brisban"은 Brisbane, Australia 및 해당 지역의 모든 관련 스테이션을 찾습니다.

스테이션 필드의 형식은 웹 사이트의 형식입니다. 예를 들어 링크된 지역의 위치 문자열 "[South Brisbane, Australia](http://aqicn.org/city/australia/queensland/south-brisbane/)"을 제공합니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml` 파일에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: waqi
    token: AQICN_API_TOKEN
    locations:
      - beijing
```

{% configuration %}
token:
  description: AQICN 공개 API의 토큰.
  required: true
  type: string
locations:
  description: 대기질 데이터를 찾을 위치 이름 목록. 특정 위치에 여러 개의 등록된 스테이션이 있는 경우 모두 홈어시스턴트에 추가됩니다.
  required: true
  type: list
stations:
  description: 대기질 데이터를 찾을 스테이션 이름 목록. 스테이션은 위에 지정된 위치 내에 있어야합니다.
  required: false
  type: list
{% endconfiguration %}

보고된 값은 위치에 대한 전체 AQ 색인입니다. 색인값은 다음과 같이 해석 될 수 있습니다.


AQI | Status | Description
------- | :----------------: | ----------
0 - 50  | **Good** | 대기질은 만족스럽고 대기 오염은 거의 또는 전혀 위험하지 않습니다
51 - 100  | **Moderate** | 대기질이 어느정도 괜찮습니다. 그러나 일부 오염 물질의 경우 대기 오염에 비정상적으로 민감한 소수의 사람들에게 건강에 대한 우려가 약간 있을 수 있습니다
101 - 150 | **Unhealthy for Sensitive Groups** | 민감한 그룹의 구성원은 건강에 영향을 줄 수 있습니다. 일반 대중은 영향을 받지 않을 것입니다
151 - 200 | **Unhealthy** | 모든 사람이 건강에 영향을 미칠 수 있습니다. 민감한 그룹의 구성원은 더 심각한 건강 영향을 경험할 수 있습니다.
201 - 300 | **Very unhealthy** | 응급 상황에 대한 건강 경고. 전체 인구가 영향을받을 가능성이 더 급니다.
301+ | **Hazardous** | 건강 경고 : 모든 사람이 보다 심각한 건강의 악영향을 경험할 수 있습니다. 
