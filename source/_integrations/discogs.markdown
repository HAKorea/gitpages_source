---
title: 음반거래소(Discogs)
description: Instructions on how to set up Discogs sensors within Home Assistant.
ha_category:
  - Multimedia
ha_release: 0.61
logo: discogs.png
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@thibmaek'
---

`discogs` 플랫폼을 사용하면 [Discogs](https://www.discogs.com) 컬렉션의 현재 레코드 수를 볼 수 있습니다.

## 셋업

먼저, Discogs 계정에서 개인 액세스 토큰을 받아야합니다.
프로필의 [Developer settings](https://www.discogs.com/settings/developers)에서 토큰을 생성 할 수 있습니다.

## 설정

이 센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: discogs
    token: YOUR_TOKEN
```

모니터링되는 조건은 현재 컬렉션 및/또는 원하는 목록에 있는 레코드 수를 표시하는 센서 및 컬렉션에서 임의의 레코드를 선택하는 옵션을 만들 수 있습니다.

{% configuration %}
token:
  description: The Discogs API token to use as identification to get your collection.
  required: true
  type: string
name:
  description: Name to use in the frontend.
  required: false
  type: string
monitored_conditions:
  description: A list of sensor to include.
  required: false
  type: list
  keys:
    collection:
      description: Shows the amount of records in the user's collection.
    wantlist:
      description: Shows the amount of records in the user's wantlist.
    random_record:
      description: Proposes a random record from the collection to play.
{% endconfiguration %}
