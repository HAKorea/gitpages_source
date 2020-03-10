---
title: 글로벌공유자전거(CityBikes)
description: Instructions on how to integrate data from the CityBikes API into Home Assistant.
logo: citybikes.png
ha_category:
  - Transport
ha_release: 0.49
---

`citybikes` 센서 플랫폼은 선택한 지역의 자전거 공유 스테이션에서 자전거가 사용가능한지 모니터링합니다. 이 데이터는 전세계 자전거 공유 시스템을 지원하는 [CityBikes](https://citybik.es/#about)에서 제공합니다.

## 설정

To enable it, add the following lines to your `configuration.yaml`:
이를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry (using radius)
sensor:
  - platform: citybikes
```

{% configuration %}
name:
  description: The base name of this group of monitored stations. The entity ID of every monitored station in this group will be prefixed with this base name, in addition to the network ID.
  required: false
  type: string
network:
  description: The name of the bike sharing system to poll.
  required: false
  default: Defaults to the system that operates in the monitored location.
  type: string
latitude:
  description: Latitude of the location, around which bike stations are monitored.
  required: false
  default: Defaults to the latitude in your `configuration.yaml` file.
  type: string
longitude:
  description: Longitude of the location, around which bike stations are monitored.
  required: false
  default: Defaults to the longitude in your `configuration.yaml` file.
  type: string
radius:
  description: The radius (in meters or feet, depending on the Home Assistant configuration) around the monitored location. Only stations closer than this distance will be monitored.
  required: false
  type: integer
stations:
  description: A list of specific stations to monitor. The list should contain station `ID`s or `UID`s, which can be obtained from the CityBikes API.
  required: false
  type: list
{% endconfiguration %}


## 사례

추가 설정 샘플 :

```yaml
# Example configuration.yaml entry (using a list of stations)
sensor:
  - platform: citybikes
    name: Work Stations
    stations:
      - 123
      - 145
      - 436
```
