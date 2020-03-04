---
title: 지오제이슨(GeoJSON)
description: Instructions on how to integrate GeoJSON feeds into Home Assistant.
logo: geo_location.png
ha_category:
  - Geolocation
ha_iot_class: Cloud Polling
ha_release: 0.79
---

`geo_json_events` 플랫폼을 사용하면 GeoJSON 피드를 연동할 수 있습니다. 피드에서 이벤트를 검색하고 홈어시스턴트 위치까지의 거리에 따라 필터링된 이벤트 정보를 표시합니다. 
GeoJSON 피드의 모든 항목은 일반적으로 지리 좌표가 있는 점 또는 다각형 인 `geometry`를 정의해야합니다. 또한 이 플랫폼은 항목의 `properties`에서 `title` 키를 찾아 엔터티 이름으로 사용합니다.

GeoJSON 피드에서 업데이트 할 때마다 엔티티가 자동으로 생성, 업데이트 및 제거됩니다. 각 엔티티는 위도와 경도를 정의하며지도에 자동으로 표시됩니다. 킬로미터 단위의 거리는 각 엔티티의 상태로 사용 가능합니다. 

데이터는 5 분마다 업데이트됩니다.

## 설정

GeoJSON 피드를 통합하려면 `configuration.yaml`에 다음 줄을 추가하십시오. [미국 지질 조사에서 제공 한 지진 데이터](https://earthquake.usgs.gov/earthquakes/feed/v1.0/geojson.php)를 보여주는 설정 예입니다.

```yaml
# Example configuration.yaml entry
geo_location:
  - platform: geo_json_events
    url: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson
```

{% configuration %}
url:
  description: GeoJSON 피드의 전체 URL.
  required: true
  type: string
radius:
  description: 이벤트를 확인하고자하는 홈어시스턴트 좌표 주위의 거리 (킬로미터).
  required: false
  type: float
  default: 20.0
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
{% endconfiguration %}

## 상태 속성 (State Attributes)

표준 엔티티 외에 각 엔티티에 대해 다음 상태 속성을 사용할 수 있습니다.

| Attribute   | Description |
|-------------|-------------|
| latitude    | 이벤트의 위도. |
| longitude   | 이벤트의 경도. |
| source      | `geo_json_events`는 `geo_location` 자동화 트리거와 함께 사용됩니다. |
| external_id | 피드에서 이벤트를 식별하기 위해 피드에 사용된 외부 ID입니다. |

## 고급 설정 사례

여러 GeoJSON 피드를 통합 할 때 다른 피드의 엔티티를 구별하는 것이 유용할 수 있습니다. 가장 쉬운 방법은 각 엔티티 ID에 정의된 값이 붙는 각 플랫폼에 대해 [`entity_namespace`](/docs/configuration/platform_options/#entity-namespace/)를 정의하는 것입니다.

```yaml
# Example configuration.yaml entry
geo_location:
  - platform: geo_json_events
    url: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/all_day.geojson
    radius: 250
    entity_namespace: 'usgs_earthquakes'
```
