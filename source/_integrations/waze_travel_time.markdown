---
title: 웨이즈 트레블 타임(Waze Travel Time)
description: Instructions on how to add Waze travel time to Home Assistant.
logo: waze.png
ha_category:
  - Transport
ha_iot_class: Cloud Polling
ha_release: 0.67
---

<div class='videoWrapper'>
<iframe width="690" height="388" src="https://www.youtube.com/embed/DdMmEbKp4_o" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`waze_travel_time` 센서는 [Waze](https://www.waze.com/)에서 이동 시간을 제공합니다.

단위 시스템은 기본적으로 미터법으로 설정되어 있습니다.

## 설정

설치시 이 센서를 사용하려면 다음 `sensor`섹션을 configuration.yaml 파일에 추가하십시오.

```yaml
# Example entry for configuration.yaml
sensor:
  - platform: waze_travel_time
    origin: Montréal, QC
    destination: Québec, QC
    region: 'US'
```

{% configuration %}
origin:
  description: Enter the starting address or the GPS coordinates of the location (GPS coordinates has to be separated by a comma). You can also enter an entity id which provides this information in its state, an entity id with latitude and longitude attributes, or zone friendly name.
  required: true
  type: string
destination:
  description: Enter the destination address or the GPS coordinates of the location (GPS coordinates has to be separated by a comma). You can also enter an entity id which provides this information in its state, an entity id with latitude and longitude attributes, or zone friendly name.
  required: true
  type: string
region:
  description: Choose one of the available regions from 'AU', 'EU', 'US', 'NA' (equivalent to 'US') or 'IL'.
  required: true
  type: string
name:
  description: A name to display on the sensor.
  required: false
  default: "Waze Travel Time"
  type: string
incl_filter:
  description: A substring that has to be present in the description of the selected route (a simple case-insensitive matching).
  required: false
  type: string
excl_filter:
  description: A substring that has to be NOT present in the description of the selected route (a simple case-insensitive matching).
  required: false
  type: string
realtime:
  description: If this is set to false, Waze returns the time estimate, not including current conditions, but rather the average travel time for the current time of day. The parameter defaults to true, meaning Waze will return real-time travel time.
  required: false
  type: boolean
  default: true
units:
  description: "Set the unit of measurement for the sensor in metric or imperial, otherwise the default unit of measurement is the same as the unit set in `unit_system:`."
  required: false
  type: string
vehicle_type:
  description: "Set the vehicle type for the sensor: car, taxi, or motorcycle, otherwise the default is car."
  required: false
  type: string
avoid_ferries:
  description: "If this is set to true, Waze will avoid ferries on your route."
  required: false
  type: boolean
  default: false
avoid_toll_roads:
  description: "If this is set to true, Waze will avoid toll roads on your route."
  required: false
  type: boolean
  default: false
avoid_subscription_roads:
  description: "If this is set to true, Waze will avoid roads needing a vignette / subscription on your route."
  required: false
  type: boolean
  default: false
{% endconfiguration %}

`avoid_toll_roads`, `avoid_subscription_roads`, `avoid_ferries` 옵션을 사용할 때 유효한 vignette/subscription을 가정할 경우 Waze가 유료도로나 페리(배)를 통해 경로를 안내하는 경우가 있습니다. 기본 동작은 Waze가 subscription 옵션으로 도로를 안내하는 것입니다. 가장 좋은 방법은 `avoid_toll_roads`와 `avoid_subscription_roads` 혹은 `avoid_ferries`를 설정하고 원하는 결과를 얻기 위해 실험하는 것입니다.

## 동적 목적지를 사용하는 예

유연한 옵션을 사용하여 센서값을 `destination`로 설정하면 필요에 따라 여러 선택적 위치까지의 이동 시간을 계산하는 단일 Waze 연동을 설정할 수 있습니다.

다음 예에서 `Input Select`은 `device_tracker.myphone` 위치에서 Waze 경로 계산 목적지를 수정하는데 사용되는 주소로 변환됩니다. (Waze 데이터 페치 간격으로 인해 값이 업데이트되는데 몇 분이 걸립니다.)

{% raw %}
```yaml
input_select:
  destination:
    name: destination
    options:
      - Home
      - Work
      - Parents

sensor:
  - platform: template
    sensors:
       dest_address:
         value_template: >-
            {%- if is_state("input_select.destination", "Home")  -%}
              725 5th Ave, New York, NY 10022, USA
            {%- elif is_state("input_select.destination", "Work")  -%}
              767 5th Ave, New York, NY 10153, USA
            {%- elif is_state("input_select.destination", "Parents")  -%}
              178 Broadway, Brooklyn, NY 11211, USA
            {%- else -%}
              Unknown
            {%- endif %}
    
  # Tracking entity to entity
  - platform: waze_travel_time
    name: "Me to destination"
    origin: device_tracker.myphone
    destination: sensor.dest_address
    region: 'US'

  # Tracking entity to zone friendly name
  - platform: waze_travel_time
    name: Home To Eddie's House
    origin: zone.home
    destination: Eddies House    # Friendly name of a zone
    region: 'US'

  # Tracking entity in imperial unit
  - platform: waze_travel_time
    origin: person.paulus
    destination: "725 5th Ave, New York, NY 10022, USA"
    region: 'US'
    units: imperial    # 'metric' for Metric, 'imperial' for Imperial
    vehicle_type: motorcycle  # vehicle type used for routing
  
  # Avoiding toll, subscription
  - platform: waze_travel_time
    name: Westerscheldetunnel
    origin: 51.330436, 3.802043
    destination: 51.445677, 3.749929
    region: 'EU'
    avoid_toll_roads: true
    avoid_subscription_roads: true  
```
{% endraw %}

## iFrame에서 라이브 맵 사용

Lovelace [iframe](/lovelace/iframe/)에서 [Waze's live map](https://developers.google.com/waze/iframe/)을 사용하려면 라이브 맵 URL 자체가 아닌 [https://embed.waze.com/iframe](https://embed.waze.com/iframe)를 사용하십시오.