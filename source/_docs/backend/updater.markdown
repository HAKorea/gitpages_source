---
title: "Updater"
description: "Details what the updater integration is reporting about your Home Assistant instance."
redirect_from: /details/updater/
---

0.31부터 [updater component](/integrations/updater/)는 Home Assistant 인스턴스에 대한 선택적 보고서를 보냅니다.

통합 정보를 포함하도록 [opt-in](https://ko.wikipedia.org/wiki/%EC%98%B5%ED%8A%B8%EC%9D%B8)한다면, `include_used_components`를 설정에 추가 하십시오. 이를 통해 홈 어시스턴트 개발자는 가장 인기있는 구성 요소에 대한 개발 노력에 집중할 수 있습니다.

```yaml
updater:
  include_used_components: true
```

더 나은 장기간의 지원 및 기능 개발을 제공하기 위해 사용자기반 정보를 보다 잘 이해하기 위한 정보 만 수집합니다.

| Name                  | Description                                | Example                            | Data Source    |
|-----------------------|--------------------------------------------|------------------------------------|----------------|
| `arch`                | CPU Architecture                           | `x86_64`                           | Local Instance |
| `distribution`        | Linux Distribution name (only Linux)       | `Ubuntu`                           | Local Instance |
| `docker`              | True if running inside Docker              | `false`                            | Local Instance |
| `first_seen_datetime` | First time instance ID was submitted       | `2016-10-22T19:56:03.542Z`         | Update Server  |
| `geo_city`            | GeoIP determined city                      | `Oakland`                          | Update Server  |
| `geo_country_code`    | GeoIP determined country code              | `US`                               | Update Server  |
| `geo_country_name`    | GeoIP determined country name              | `United States`                    | Update Server  |
| `geo_latitude`        | GeoIP determined latitude                  | `37.8047`                          | Update Server  |
| `geo_longitude`       | GeoIP determined longitude                 | `-122.2124`                        | Update Server  |
| `geo_metro_code`      | GeoIP determined metro code                | `807`                              | Update Server  |
| `geo_region_code`     | GeoIP determined region code               | `CA`                               | Update Server  |
| `geo_region_name`     | GeoIP determined region name               | `California`                       | Update Server  |
| `geo_time_zone`       | GeoIP determined time zone                 | `America/Los_Angeles`              | Update Server  |
| `geo_zip_code`        | GeoIP determined zip code                  | `94602`                            | Update Server  |
| `last_seen_datetime`  | Most recent time instance ID was submitted | `2016-10-22T19:56:03.542Z`         | Update Server  |
| `os_name`             | Operating system name                      | `Darwin`                           | Local Instance |
| `os_version`          | Operating system version                   | `10.12`                            | Local Instance |
| `python_version`      | Python version                             | `3.5.2`                            | Local Instance |
| `timezone`            | Timezone                                   | `America/Los_Angeles`              | Local Instance |
| `user_agent`          | User agent used to submit analytics        | `python-requests/2.11.1`           | Local Instance |
| `uuid`                | Unique identifier                          | `10321ee6094d4a2ebb5ed55c675d5f5e` | Local Instance |
| `version`             | Home Assistant version                     | `0.31.0`                           | Local Instance |
| `virtualenv`          | True if running inside virtualenv          | `true`                             | Local Instance |

위에서 수집 한 데이터 외에도 서버는 IP 주소를 사용하여 지리적 IP 주소 조회를 수행하여 주소가있는 일반적인 위치를 결정합니다. : __홈 어시스턴트 업데이터가 하지 않는 것: IP 주소를 데이터베이스에 저장하고 위치 정보를 노출하지도 않습니다 `configuration.yaml`.__

테스트 결과에 따르면 처음부터 정확하다고 가정하면 (지리적 IP 조회가 매우 적거나 누락 된 경우), IP 주소 위치에서 실제 IP 위치의 반경 5 마일 인 4 자리의 정확도가 나옵니다. 

서버는 또한 데이터에 두 개의 타임 스탬프를 추가합니다. :

- 인스턴스 UUID를 처음 본 날짜
- 마지막으로 본 인스턴스의 타임 스탬프

우리는 수집 된 개인 데이터를 공개적으로 공개하지 않습니다. 그러나 사용자 기반에 대한 집계 통계를 게시 할 수 있습니다 (예 : 모든 사용자의 70 %가 Linux를 사용함). 우리는 홈어시스턴트 개발 이외의 목적으로 이 정보를 절대 판매하거나 공개하지 않습니다.