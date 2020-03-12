---
title: 구글 운송 피드 스펙 (GTFS)
description: Instructions on how to use public transit open data in Home Assistant.
logo: train.png
ha_category:
  - Transport
ha_iot_class: Local Polling
ha_release: 0.17
ha_codeowners:
  - '@robbiet480'
---

`gtfs` 센서는 다음 출발 시간과 대중 교통 정류장/정류장의 관련 데이터를 제공합니다. 데이터는 선택한 대중 교통 기관에서 제공하며 일반적으로 GTFS라고 알려진 [General Transit Feed Specification](https://developers.google.com/transit/gtfs/)데이터 형식으로되어 있습니다.

인터넷을 검색하면 찾을 수있는 유효한 GTFS 데이터 세트를 찾아야합니다. 대부분의 대중 교통 기관은 GTFS를 이용할 수 있으며 Google은 대중 교통 기관이 Google지도에 표시하려는 경우 데이터를 제공하도록 요구합니다. [TransitFeeds](https://transitfeeds.com/feeds)에서 데이터를 찾을 수도 있습니다.

다음은 몇 가지 예입니다.

- [Bay Area Rapid Transit (BART)](https://www.bart.gov/schedules/developers/gtfs) - 샌프란시스코 베이 지역 경전철 시스템.
- [Metropolitan Transit Authority of New York City (MTA)](http://web.mta.info/developers/) - 뉴욕시 대도시 지역의 지하철, 버스, LIRR 및 Metro-North에 대해 별도의 데이터 피드를 제공합니다.
- [Official Timetable Switzerland](https://opentransportdata.swiss/en/dataset/timetable-2019-gtfs) - 2019 년 스위스 공식 시간표 데이터

GTFS ZIP 파일을 다운로드하여 설정 디렉토리의 `gtfs` 폴더에 넣으십시오. 사용하기 쉽도록 파일 이름을 agency/data 소스 이름 (예 : `google_transit_20160328_v1.zip` 대신 `bart.zip`)으로 바꾸는 것이 좋습니다. `gtfs` 폴더에 폴더의 압축을 풀고 배치할 수도 있습니다.

데이터는 쿼리 가능한 형식으로 변환 되어 소스 데이터와 함께 SQLite3 데이터베이스로 저장됩니다. 센서는 시작할 때마다이 SQLite3 데이터가 있는지 확인하고 ZIP/폴더가 없으면 다시 가져옵니다.

데이터를 업데이트하려면 SQLite3 파일을 삭제하고 Home Assistant를 다시 시작하십시오.

stop ID를 찾으려면 ZIP file/unzipped 된 폴더에서 `stops.txt` 파일을 여십시오. ID의 형식은 모든 대중 교통 기관마다 다르지만 행에서 첫 번째 "column"(첫 번째 쉼표 앞의 문자열을 의미)이됩니다.

센서 속성에는 agency 정보, 출발지 및 목적지 정류장 정보, 출발지 및 목적지 정류장 시간 및 경로 정보와 같은 특정 여행에 대한 모든 관련 정보가 포함됩니다.

마일리지는 사용중인 환승 기관에 따라 다를 수 있습니다. 대부분의 대행사는 GTFS 형식을 존중하지만 일부는 열을 추가하거나 다른 데이터 형식을 사용하는 등 이상한 일을 합니다. 데이터 관련 문제가 있는 경우 GTFS 센서가 데이터를 파싱하는 데 사용하는 [PyGTFS](https://github.com/jarondl/pygtfs) 프로젝트에 보고하십시오.

**Please note** : 이는 _static_ 데이터 소스입니다. 현재 이 센서에서는 Python 3의 프로토콜 버퍼 형식 파싱과 관련된 문제로 인해 GTFS 실시간 지원이 없습니다. 이러한 문제가 해결되면 실시간 지원이 추가됩니다. 센서가 추가되면 지연 및 권고 사항을 확인하고 필요에 따라 센서에 보고합니다.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: gtfs
    origin: STOP_ID
    destination: STOP_ID
    data: DATA_SOURCE
```

{% configuration %}
origin:
  description: The stop ID of your origin station.
  required: true
  type: string
destination:
  description: The stop ID of your destination station.
  required: true
  type: string
data:
  description: The name of the ZIP file or folder containing the GTFS data. It must be located inside the `gtfs` folder of your configuration directory.
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  default: GTFS Sensor
  type: string
offset:
  description: A minimum delay to look for. If a departure is in less time than `offset`, it will be ignored.
  required: false
  default: 0
  type: [integer, time]
include_tomorrow:
  description: Also search through tomorrow's schedule if no more departures are set for today.
  required: false
  default: false
  type: boolean
{% endconfiguration %}
