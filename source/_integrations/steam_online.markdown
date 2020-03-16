---
title: 스팀(Steam)
description: Instructions on how to set up Steam sensors in Home Assistant.
logo: steam.png
ha_category:
  - Social
ha_iot_class: Cloud Polling
ha_release: 0.14
---

`steam`센서 플랫폼을 사용하면 [Steam](https://steamcommunity.com) 계정의 온라인 상태를 추적할 수 있습니다.

## 셋업

플랫폼을 사용하려면 [free API key](https://steamcommunity.com/dev/apikey)가 필요합니다.

사용자 정의 URL이 없는 프로파일에서 계정의 64 비트 SteamID를 찾으려면 프로파일 페이지의 URL을 확인할 수 있습니다. 끝에 있는 긴 문자열은 64 비트 SteamID입니다. 프로필에 사용자 지정 URL이 있으면 URL을 [STEAMID I/O](https://steamid.io/)에 복사하여 64 비트 SteamID를 찾아야합니다.

## 설정

설치에서 Steam을 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: steam_online
    api_key: YOUR_API_KEY
    accounts:
      - account1
      - account2
```

{% configuration %}
api_key:
  required: true
  description: Your API key from [https://steamcommunity.com/dev/apikey](https://steamcommunity.com/dev/apikey).
  type: string
accounts:
  required: true
  description: List of accounts.
  type: map
  keys:
    account_id:
      required: true
      description: The 64-bit SteamID.
      type: string
{% endconfiguration %}

## 사례 

예를 들어 계정을 그룹에 추가하려면 다음을 사용해야합니다.

```yaml
# Example configuration.yaml entry
group:
  steam:
    name: Steam
    entities:
      - sensor.steam_account1
      - sensor.steam_account2
```
