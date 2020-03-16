---
title: 지도 RSS(GeoRSS)
description: Instructions on how to set up GeoRSS sensors within Home Assistant.
logo: rss.png
ha_category:
  - Sensor
ha_iot_class: Cloud Polling
ha_release: 0.55
ha_codeowners:
  - '@exxamalte'
---

`geo_rss_events` 센서는 GeoRSS 피드에서 이벤트를 검색하고 홈어시스턴트까지의 거리에 따라 필터링 되고 범주별로 그룹화된 해당 이벤트 정보를 표시합니다.

이 센서는 집 근처에서 이벤트가 예기치 않게 발생하는 경우 특히 유용하지만 GeoRSS 피드에는 관련없는 항목을 나타내는 많은 이벤트가 포함되어 있습니다. 전형적인 예는 산불 경보 또는 지진입니다.

<p class='img'>
  <img src='{{site_root}}/images/screenshots/geo-rss-incidents-group-screenshot.png' />
</p>

거리를 비교하기위한 기준점은 기본적으로 기본 설정에서 `latitude`와 `longitude`로 정의됩니다.

*georss.org* 형식 또는 *WGS84 위도/경도*에서 위치를 `point` 또는 `polygon`으로 정의하는 피드 항목만 다룹니다. 

The data is updated every 5 minutes.
데이터는 5 분마다 업데이트됩니다.

## 설정

GeoRSS 이벤트 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오. NSW Rural Fire Service에서 발생하는 산불 사고를 보여주는 설정 예입니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: geo_rss_events
    name: NSW Fire Service
    url: https://www.rfs.nsw.gov.au/feeds/majorIncidents.xml
    unit_of_measurement: 'Incidents'
    categories:
      - 'Emergency Warning'
      - 'Watch and Act'
      - 'Advice'
```

{% configuration %}
url:
  description: GeoRSS 피드의 전체 URL
  required: true
  type: string
name:
  description: 엔티티 ID 생성에 사용된 센서 이름
  required: false
  type: string
  default: Event Service
latitude:
  description: 이벤트를 확인하고자하는 좌표의 위도.
  required: false
  type: string
  default: Latitude defined in your `configuration.yaml`
longitude:
  description: 이벤트를 확인하고자하는 좌표의 경도.
  required: false
  type: string
  default: Longitude defined in your `configuration.yaml`
radius:
  description: 이벤트를 확인하고자 하는 홈어시스턴트 좌표 주위의 거리 (킬로미터).
  required: false
  type: string
  default: 20km
categories:
  description: GeoRSS 피드에 있는 이벤트 카테고리 이름 목록. 정의된 각 범주에 대해 별도의 센서가 생성됩니다.
  required: false
  type: list
  default: Default is to join events from all categories into an 'Any' category. 
unit_of_measurement:
  description: GeoRSS 피드에서 발견 된 이벤트 유형.
  required: false
  type: string
  default: Events
{% endconfiguration %}

## 피드 사례들

**Bush Fire Alerts**

```yaml
sensor:
  - platform: geo_rss_events
    name: Qld Fire and Emergency Services
    url: https://www.qfes.qld.gov.au/data/alerts/bushfireAlert.xml
    unit_of_measurement: 'Alerts'
  - platform: geo_rss_events
    name: Tas Fire Service
    url: http://www.fire.tas.gov.au/Show?pageId=colBushfireSummariesRss
    unit_of_measurement: 'Alerts'
  - platform: geo_rss_events
    name: WA Department of Fire and Emergency Services
    url: https://www.emergency.wa.gov.au/data/incident_FCAD.rss
  - platform: geo_rss_events
    name: ACT Emergency Services Agency
    url: https://www.esa.act.gov.au/feeds/currentincidents.xml
```


**Earthquake Alerts**

```yaml
sensor:
  - platform: geo_rss_events
    name: USGS All Earthquakes
    url: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.atom
    categories:
      - 'Past Hour'
      - 'Past Day'
  - platform: geo_rss_events
    name: BGS Worlwide Earthquakes
    url: https://www.bgs.ac.uk/feeds/worldSeismology.xml
    categories:
      - 'EQMH'
  - platform: geo_rss_events
    name: Recent significant earthquake reports (Canada)
    url: http://www.earthquakescanada.nrcan.gc.ca/index-en.php?tpl_region=canada&tpl_output=rss
    categories:
      - 'Earthquake Report'
```
