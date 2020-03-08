---
title: 구글 지도 이동 시간
description: Instructions on how to add Google Maps travel time to Home Assistant.
logo: google_maps.png
ha_category:
  - Transport
ha_iot_class: Cloud Polling
ha_release: 0.19
ha_codeowners:
  - '@robbiet480'
---

`google_travel_time` 센서는 [Google Distance Matrix API](https://developers.google.com/maps/documentation/distance-matrix/)에서 이동 시간을 제공합니다.

## 셋업

[여기](https://github.com/googlemaps/google-maps-services-python#api-keys) 지침에 따라 API 키를 등록해야합니다. Distance Matrix API만 켜면됩니다.

Google Maps API에 액세스하려면 [Google Now에 결제가 필요합니다](https://mapsplatform.googleblog.com/2018/05/introducing-google-maps-platform.html)를 활성화하고 유효한 신용 카드를 로드합니다. Distance Matrix API는 요청 1,000 건당 미화 10 달러로 청구되지만 월 200 달러(요청 2만 건당)의 크레딧이 적용됩니다. 기본적으로 센서는 5 분마다 이동 시간을 업데이트하여 하루에 약 288 개의 통화를합니다. 이 속도에서 2개 이상의 센서가 무료 크레딧 금액을 초과 할 가능성이 있습니다. 두 개 이상의 센서를 실행해야하는 경우 여유 크레딧 한도 내에 머무르거나 자동화를 사용하여 주문형 센서를 업데이트하려면 스캔 간격 을 5분 이상으로 변경하십시오. (아래 예 참조).

**무료 크레딧 금액을 초과하지 않도록** API에 대해 할당량을 설정할 수 있습니다. 'Elements per day'를 645 이하로 설정하십시오. 할당량을 구성하는 방법에 대한 자세한 내용은 [here](https://developers.google.com/maps/documentation/distance-matrix/usage-and-billing#set-caps)를 참조하십시오.

## 설정

센서를 활성화하려면 `configuration.yaml` 파일에 다음 라인을 추가하십시오 :

```yaml
# Example entry for configuration.yaml
sensor:
  - platform: google_travel_time
    api_key: XXXX_XXXXX_XXXXX
    origin: Trondheim, Norway
    destination: Paris, France
```

{% configuration %}
api_key:
  description: Your application's API key (get one by following the instructions above). This key identifies your application for purposes of quota management.
  required: true
  type: string
origin:
  description: "The starting point for calculating travel distance and time. You can supply one or more locations separated by the pipe character, in the form of an address, latitude/longitude coordinates, or a [Google place ID](https://developers.google.com/places/place-id). When specifying the location using a Google place ID, the ID must be prefixed with `place_id:`."
  required: true
  type: string
destination:
  description: One or more locations to use as the finishing point for calculating travel distance and time. The options for the destinations parameter are the same as for the origins parameter, described above.
  required: true
  type: string
name:
  description: A name to display on the sensor. The default is "Google Travel Time - [Travel Mode]" where [Travel Mode] is the mode set in options for the sensor (see option "mode" below).
  required: false
  type: string
travel_mode:
  description: "You can choose between: `driving`, `walking`, `bicycling` or `transit`. This method is now deprecated, use `mode` under `options`."
  required: false
  type: string
options:
  description: "A dictionary containing parameters to add to all requests to the Distance Matrix API. A full listing of available options can be found [here](https://developers.google.com/maps/documentation/distance-matrix/intro#RequestParameters)."
  required: false
  type: list
  keys:
    mode:
      description: The travel mode used to calculate the directions/time. Can be `driving`, `bicycling`, `transit` or `walking`.
      required: false
      default: driving
      type: string
    language:
      description: "You can choose from a lot of languages: `ar`, `bg`, `bn`, `ca`, `cs`, `da`, `de`, `el`, `en`, `es`, `eu`, `fa`, `fi`, `fr`, `gl`, `gu`, `hi`, `hr`, `hu`, `id`, `it`, `iw`, `ja`, `kn`, `ko`, `lt`, `lv`, `ml`, `mr`, `nl`, `no`, `pl`, `pt`, `pt-BR`, `pt-PT`, `ro`, `ru`, `sk`, `sl`, `sr`, `sv`, `ta`, `te`, `th`, `tl`, `tr`, `uk`, `vi`, `zh-CN` and `zh-TW`."
      required: false
      type: string
    departure_time:
      description: Can be `now`, a Unix timestamp, or a 24 hour time string like `08:00:00`. If you provide a time string, it will be combined with the current date to get travel time for that moment.
      required: exclusive
      type: [time, string]
    arrival_time:
      description: See notes above for `departure_time`. `arrival_time` cannot be `now`, only a Unix timestamp or time string. You can not provide both `departure_time` and `arrival_time`. If you do provide both, `arrival_time` will be removed from the request.
      required: exclusive
      type: [time, string]
    avoid:
      description: "Indicate what google should avoid when calculating the travel time, you can choose from: `tolls`, `highways`, `ferries`, `indoor`."
      required: false
      type: string
    transit_mode:
      description: "If you opted for `transit` at `travel_mode`, you can use this variable to specify which public transport you want to use: `bus`, `subway`, `train`, `tram` or `rail`."
    transit_routing_preference:
      description: "for the travel time calculation for public transport you can also specify the preference for: `less_walking` or `fewer_transfers`."
      required: false
      type: string
    units:
      description: "Set the unit for the sensor in metric or imperial, otherwise the default unit the same as the unit set in `unit_system:`."
      required: false
      type: string
{% endconfiguration %}

## 동적 설정

`device_tracker`, `zone`, `sensor` 및 `person` 유형의 엔티티를 추적하도록 추적을 설정할 수 있습니다. 엔티티가 출발지 또는 목적지에 배치되면 플랫폼이 업데이트 될 때 5 분마다 해당 엔티티의 최신 위치를 사용합니다.

```yaml
# Example entry for configuration.yaml
sensor:
  # Tracking entity to entity
  - platform: google_travel_time
    name: Phone To Home
    api_key: XXXX_XXXXX_XXXXX
    origin: device_tracker.mobile_phone
    destination: zone.home

  # Tracking entity to zone friendly name
  - platform: google_travel_time
    name: Home To Eddie's House
    api_key: XXXX_XXXXX_XXXXX
    origin: zone.home
    destination: Eddies House    # Friendly name of a zone

  # Tracking entity in imperial unit
  - platform: google_travel_time
    api_key: XXXX_XXXXX_XXXXX
    destination: zone.home
    options:
      units: imperial    # 'metric' for Metric, 'imperial' for Imperial
```

## Entity 추적

- **device_tracker**
  - 상태가 영역(zone) 인 경우 영역 위치가 사용됩니다
  - 상태가 영역이 아닌 경우 경도 및 위도 속성을 찾습니다.
- **zone**
  - 경도 및 위도 속성을 사용합니다
  - 속성에서 찾은 영역의 이름만으로도 참조 할 수 있습니다.
- **sensor**
  - 상태가 영역 또는 영역 이름 인 경우 영역 위치를 사용합니다
  - 다른 모든 상태는 Google API로 직접 전달됩니다.
    - 여기에는 *설성 변수*에 나열된 모든 유효한 위치가 포함됩니다

## 자동화를 사용하여 주문형 센서 업데이트

`homeassistant.update_entity` 서비스를 사용하여 주문형 센서를 업데이트 할 수도 있습니다. 예를 들어, 평일 아침 2 분마다 `sensor.morning_commute`를 업데이트하려는 경우 다음 자동화를 사용할 수 있습니다.

```yaml
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
