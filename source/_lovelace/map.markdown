---
title: "Map 카드"
sidebar_label: Map
description: "A card that allows you to display entities on a map"
---

지도(Map)에 엔티티를 표시할 수 있는 카드입니다.

<p class='img'>
<img src='/images/lovelace/lovelace_map_card.png' alt='Screenshot of the map card'>
지도 카드의 스크린 샷. 
</p>

{% configuration %}
type:
  required: true
  description: map
  type: string
entities:
  required: true
  description: 엔터티 ID 목록. 해당 목록 혹은 `geo_location_sources` 설정 옵션 중 하나는 필요합니다. 
  type: list
geo_location_sources:
  required: true
  description: 지리적 위치 소스 목록. 해당 소스가 있는 모든 현재 엔티티가 맵에 표시됩니다. 유효한 소스는 [Geolocation](/integrations/geo_location/) 플랫폼을 참조하십시오. 사용 가능한 모든 소스를 사용하려면 `all`로 설정하십시오. `geo_location_sources` 혹은 `entities`의 설정 옵션 중 하나는 필요로 합니다.
  type: list
title:
  required: false
  description: 카드 제목.
  type: string
aspect_ratio:
  required: false
  description: "이미지의 높이를 너비의 비율로 강제로 만듭니다. 다음같은 값 입력 가능: `16x9`, `16:9`, `1.78`."
  type: string
default_zoom:
  required: false
  description: "지도의 기본 확대/축소 레벨."
  type: integer
  default: 14 (or whatever zoom level is required to fit all visible markers)
dark_mode:
  required: false
  description: 지도에 어두운 테마를 사용하도록 설정.
  type: boolean
  default: false
{% endconfiguration %}

<div class='note'>
  위도와 경도 속성이 있는 엔티티만 맵에 표시됩니다.
<div class="note">

`default_zoom` 값은 지도창에서 보이는 모든 엔티티 마커(표시)를 맞춘 후 현재 확대/축소 수준보다 높게 설정된 경우 나타나지 않습니다. 다시 말해, 이는 오직 기본적으로 지도를 _상세표현_ 하는데 사용됩니다.
  
</div>

## 사례

```yaml
type: map
aspect_ratio: 16:9
default_zoom: 8
entities:
  - device_tracker.demo_paulus
  - zone.home
```

```yaml
type: map
geo_location_sources:
  - nsw_rural_fire_service_feed
entities:
  - zone.home
```
