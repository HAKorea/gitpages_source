---
title: HERE 이동 시간
description: Instructions on how to add HERE travel time to Home Assistant.
logo: HERE_logo.svg
ha_category:
  - Transport
  - Sensor
ha_iot_class: Cloud Polling
ha_release: '0.100'
ha_codeowners:
  - '@eifinger'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/fSkMLiTlQWc" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`here_travel_time` 센서는 [HERE Routing API](https://developer.here.com/documentation/routing/topics/introduction.html)에서 이동 시간을 제공합니다.

## 셋업

[here](https://developer.here.com/documentation/routing/topics/introduction.html?create=Freemium-Basic&keepState=true&step=account) 지침에 따라 API 키 (REST & XYZ HUB API/CLI)를 등록해야합니다. 

HERE는 한 달에 250,000 건의 무료 거래가 포함된 프리미엄 플랜을 제공합니다. 라우팅 API의 경우 하나의 트랜잭션은 하나의 요청과 하나의 시작점 (멀티 stop 없음)과 같습니다. 자세한 내용은 [여기](https://developer.here.com/faqs#payment-subscription)를 참조하십시오.

해당 월의 무료 거래 한도를 초과하면 기본적으로 여기에서 계정이 비활성화됩니다. 
[여기](https://developer.here.com/faqs)에 설명된대로 결제 세부 정보를 추가하여 계정을 다시 활성화할 수 있습니다

### app_code에서 api_key로 마이그레이션

HERE의 인증 메커니즘이 변경되었습니다. 더이상 `app_id`와 `app_code`를 사용할 수 없습니다. 현재 필요한 `api_key`를 검색하려면 기존 사용자가 [migration guide](https://developer.here.com/documentation/authentication/dev_guide/topics/api-key-credentials.html)를 따라야합니다.

## 설정

센서를 활성화하려면 `configuration.yaml` 파일에 다음 라인을 추가하십시오 :

```yaml
# Example entry for configuration.yaml
sensor:
  - platform: here_travel_time
    api_key: "YOUR_API_KEY"
    origin_latitude: "51.222975"
    origin_longitude: "9.267577"
    destination_latitude: "51.257430"
    destination_longitude: "9.335892"
```

{% configuration %}
api_key:
  description: "애플리케이션의 API 키 (위의 지침에 따라 키를 얻습니다)."
  required: true
  type: string
origin_latitude:
  description: "이동 거리와 시간을 계산하기 위한 시작 위도입니다. origin_longitude와 함께 사용해야합니다. `origin_entity_id`와 함께 사용할 수 없습니다."
  required: exclusive
  type: float
origin_longitude:
  description: "이동 거리와 시간을 계산하기 위한 시작 경도. origin_latitude와 함께 사용해야합니다. `origin_entity_id`와 함께 사용할 수 없습니다."
  required: exclusive
  type: float
destination_latitude:
  description: "이동 거리와 시간 계산을 위한 최종 위도. destination_longitude와 함께 사용해야합니다. `destination_entity_id`와 함께 사용할 수 없습니다."
  required: exclusive
  type: float
destination_longitude:
  description: "이동 거리와 시간 계산을 위한 최종 경도. destination_latitude와 함께 사용해야합니다. `destination_entity_id`와 함께 사용할 수 없습니다."
  required: exclusive
  type: float
origin_entity_id:
  description: "이동 거리와 시간을 계산하기 위한 시작점을 보유한 entity_id. `origin_latitude`/`origin_longitude`와 함께 사용할 수 없습니다."
  required: exclusive
  type: string
destination_entity_id:
  description: "이동 거리와 시간을 계산하기 위한 최종 지점을 보유한 entity_id. `destination_latitude`/`destination_longitude`와 함께 사용할 수 없습니다"
  required: exclusive
  type: string
name:
  description: 센서에 표시할 이름입니다. 기본값은 "HERE Travel Time" 입니다.
  required: false
  type: string
  default: "HERE Travel Time"
mode:
  description: "`bicycle`, `car`, `pedestrian`, `publicTransport`, `publicTransportTimeTable` 혹은 `truck` 중에서 선택할 수 있습니다. 기본값은 `car`입니다. 대중 교통의 경우 `publicTransportTimeTable`이 권장됩니다. 일반 모드 [여기참조](https://developer.here.com/documentation/routing/topics/transport-modes.html)와 공개 모드 [여기참조](https://developer.here.com/documentation/routing/topics/public-transport-routing.html)에 대한 자세한 정보를 찾을 수 있습니다."
  required: false
  type: string
  default: "car"
route_mode:
  description: "`fastest` 또는 `shortest` 중에서 선택할 수 있습니다. 이는 경로가 현재 교통 정보에 따라 가장 짧고 완전히 무시되는 트래픽과 속도 제한인지 혹은 가장 빠른 경로인지를 결정합니다. 기본값은 `fastest`입니다"
  required: false
  type: string
  default: "fastest"
traffic_mode:
  description: "`true` 또는 `false` 중에서 선택할 수 있습니다. 
현재 교통 상황을 고려할지 여부를 결정하십시오. 기본값은 `false`입니다 "
  required: false
  type: boolean
  default: false
unit_system:
  description: "`metric` 혹은 `imperial` 중에서 선택할 수 있습니다 "
  required: false
  default: Defaults to `metric` or `imperial` based on the Home Assistant configuration.
  type: string
scan_interval:
  description: "센서의 업데이트 간격을 초 단위로 정의합니다. 기본값은 300 (5 분)입니다."
  required: false
  type: integer
  default: 300
{% endconfiguration %}

## 동적 설정 (Dynamic Configuration)

`device_tracker`, `zone`, `sensor`, `person` 유형의 엔티티를 추적하도록 추적을 설정할 수 있습니다. 엔티티가 출발지 혹은 목적지에 배치되면 플랫폼이 업데이트될 때 5 분마다 해당 엔티티의 최신 위치를 사용합니다.

```yaml
# Example entry for configuration.yaml
sensor:
  # Tracking entity to entity
  - platform: here_travel_time
    api_key: "YOUR_API_KEY"
    name: Phone To Home
    origin_entity_id: device_tracker.mobile_phone
    destination_entity_id: zone.home
  # Full config
  - platform: here_travel_time
    api_key: "YOUR_API_KEY"
    name: Work to Home By Bike
    origin_entity_id: zone.work
    destination_latitude: 59.2842
    destination_longitude: 59.2642
    mode: bicycle
    route_mode: fastest
    traffic_mode: false
    unit_system: imperial
    scan_interval: 2678400 # 1 month
    

```

## 엔터티 추적

- **device_tracker**
  - 상태가 영역(zone)인 경우 영역 위치가 사용됩니다
  - 상태가 영역이 아닌 경우 경도와 위도 속성을 찾습니다.
- **zone**
  - 경도와 위도 속성을 사용합니다
- **sensor**
  - 상태가 영역인 경우 영역 위치를 사용합니다
  - 다른 모든 상태는 HERE API로 직접 전달됩니다
    - 여기에는 *설정 변수* 에 나열된 모든 유효한 위치가 포함됩니다

## 자동화를 사용한 주문형 센서 업데이트

`homeassistant.update_entity` 서비스를 사용하여 주문형 센서를 업데이트할 수도 있습니다. 예를 들어, 평일 아침 2 분마다 `sensor.morning_commute`를 업데이트하려는 경우 다음 자동화를 사용할 수 있습니다.

```yaml
automation:
- id: update_morning_commute_sensor
  alias: "Commute - Update morning commute sensor"
  initial_state: 'on'
  trigger:
    - platform: time_pattern
      minutes: '/2'
  condition:
    - condition: time
      after: '08:00:00'
      before: '11:00:00'
    - condition: time
      weekday:
        - mon
        - tue
        - wed
        - thu
        - fri
  action:
    - service: homeassistant.update_entity
      entity_id: sensor.morning_commute
```
