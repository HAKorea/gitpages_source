---
title: 음악취향분석(Last.fm)
description: Instructions on how to integrate Last.fm sensors into Home Assistant.
logo: lastfm.png
ha_category:
  - Social
ha_iot_class: Cloud Polling
ha_release: '0.20'
---

`lastfm` 센서 플랫폼을 사용하면 사용자가 음악탐색을 시작할 때마다 자신의 재생 횟수, 마지막 노래 및 마지막 노래가 [Last.fm]에서 재생됩니다 (https://www.last.fm/).

## 셋업

API 키를 얻으려면 [API 계정](https://www.last.fm/api/account/create)을 만들어야합니다.

## 설정

설치시 Last.fm 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: lastfm
    api_key: YOUR_API_KEY
    users:
      - user1
      - user2
```

{% configuration %}
api_key:
  description: Last.fm API 키
  required: true
  type: string
users:
  description: 사용자 목록.
  required: true
  type: list
  keys:
    username:
      description: 모니터링 할 사용자의 사용자 이름
{% endconfiguration %}
