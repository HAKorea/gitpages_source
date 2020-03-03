---
title: 글로벌 재난 경보 및 조정 시스템 (GDACS)
description: Instructions on how to integrate the Global Disaster Alert and Coordination System (GDACS) feed into Home Assistant.
logo: gdacs.jpg
ha_category:
  - Geolocation
ha_iot_class: Cloud Polling
ha_release: 0.106
ha_config_flow: true
ha_quality_scale: platinum
ha_codeowners:
  - '@exxamalte'
---

`gdacs` 통합구성요소를 통해 [GDACS](https://www.gdacs.org/)에서 제공하는 GeoRSS 피드를 전세계 주요 가뭄, 지진, 홍수, 열대 저기압, 쓰나미 및 화산 활동에 대한 정보와 함께 사용할 수 있습니다. 
피드에서 알림을 검색하고 홈어시스턴트 위치까지 거리별로 필터링된 알림 정보를 표시합니다.

피드에서 업데이트 할 때마다 엔티티가 생성되고, 업데이트 및 자동 제거됩니다.
각 엔티티는 위도 및 경도를 정의하며 기본맵에 자동으로 표시되거나 소스 `gdacs` 를 정의하여 맵 카드에 표시됩니다.
거리는 각 엔티티의 상태로 사용 가능하며 홈어시스턴트에서 설정된 단위 (킬로미터 또는 마일)로 변환됩니다.

<p class='img'>
  <img src='/images/screenshots/gdacs-alerts-feed-map.png' />
</p>

데이터는 5 분마다 업데이트됩니다.

<div class='note'>

이 통합구성요소에 사용된 자료는 [GDACS (Global Disaster Alert and Coordination System)](https://www.gdacs.org/)에서 제공합니다. - 유엔과 유럽 연합 집행위원회 간의 협력 체제 -  [Creative Commons Attribution 4.0 International (CC BY 4.0) license](http://creativecommons.org/licenses/by/4.0/)에 따라.
홈어시스턴트에서 자료를 제공할 목적으로만 수정되었습니다. 자세한 내용은 [creator's disclaimer and terms of use notice](https://www.gdacs.org/About/termofuse.aspx)를 참조하십시오.

</div>

## 설정

GDACS 피드를 통합하려면 GUI의 "Integrations" 기능을 사용하거나 Configurations - Integrations에서 찾거나 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
gdacs:
```

{% configuration %}
categories:
  description: 포함 할 경고의 범주입니다. 유효한 카테고리는 '가뭄', '지진', '홍수', '열대 사이클론', '해일', '화산폭발'입니다.
  required: false
  type: list
radius:
  description: 모니터링 할 위치 주변의 반경입니다. 기본값은 500km 또는 mi입니다 (`configuration.yaml`에 정의 된 단위 시스템에 따라 다름).
  required: false
  type: float
  default: 500.0
latitude:
  description: 경고가 고려되는 좌표의 위도.
  required: false
  type: float
  default: Latitude defined in your configuration.
longitude:
  description: 경고가 고려되는 좌표의 경도
  required: false
  type: float
  default: Longitude defined in your configuration.
{% endconfiguration %}

## 상태 속성

표준 엔티티 외에 각 엔티티에 대해 다음 상태 속성을 사용할 수 있습니다.

| Attribute        | Description |
|------------------|-------------|
| latitude         | 경고 위치의 위도. |
| longitude        | 경고 위치의 경도. |
| source           | `gdacs` to be used in conjunction with `geo_location` automation trigger. |
| external_id      | 피드에서 경고를 식별하는 데 사용되는 외부 ID |
| title            | 이 항목의 제목. |
| description      | 이 항목에 대한 설명. |
| event type       | 이 경고에 대한 이벤트 유형 (가뭄, 지진, 홍수, 열대 사이클론, 쓰나미, 화산). |
| alert level      | 경고 수준 (빨간색, 주황색, 녹색). |
| country          | 경고가 적용되는 국가 |
| duration in week | 전체 주 단위의 경고 기간 (1 주 이상인 경우에만 표시). |
| from date        | 이 경고가 시작된 날짜 및 시간. |
| to date          | 이 경고가 종료된 날짜 및 시간 (또는 현재 진행중인 경우). |
| population       | 노출된 인구. |
| severity         | 경고의 심각도. |
| vulnerability    | 취약점 점수 (텍스트 또는 숫자). |

일부 속성 값은 컨텍스트에 따라 다르며 다른 이벤트 유형간에 비교할 수 없을수 도 있습니다.

## Sensor

이 연동은 본 통합구성요소에서 현재 관리되는 엔티티 수를 표시하는 센서를 자동으로 작성합니다. 또한 센서에는 피드에서 검색된 데이터의 현재성을 나타내는 유용한 속성이 있습니다. 

<p class='img'>
  <img src='/images/screenshots/gdacs-alerts-sensor.png' />
</p>

| Attribute              | Description |
|------------------------|-------------|
| status                 | 피드에서 마지막 업데이트 상태 ( "OK" 또는 "ERROR").  |
| last update            | 피드에서 마지막 업데이트의 타임 스탬프  |
| last update successful | 피드에서 마지막으로 성공한 업데이트의 타임 스탬프  |
| last timestamp         | 피드에서 최근 항목의 타임 스탬프.  |
| created                | 마지막 업데이트 중에 작성된 엔티티 수 (선택 사항).  |
| updated                | 마지막 업데이트 중 업데이트 된 엔터티 수 (선택 사항).  |
| removed                | 마지막 업데이트 중에 제거 된 엔티티 수 (선택 사항).  |

## 전체 설정

```yaml
# Example configuration.yaml entry
gdacs:
  categories:
    - Drought
    - Earthquake
  radius: 1000
  latitude: -41.2
  longitude: 174.7
```
