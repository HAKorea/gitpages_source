---
title: 레딧(Reddit)
description: How to integrate the Reddit sensor into Home Assistant.
logo: reddit.png
ha_category:
  - Sensor
ha_release: 0.89
ha_iot_class: Cloud Polling
---

Reddit 센서는 [Reddit](https://reddit.com/)의 데이터를 연동하여 선호하는 하위 레딧을 모니터링합니다.

## 셋업

이 센서를 설정하려면 연결할 사용자 계정에 대해 `client_id` 및 `client_secret`을 생성해야합니다. [this Wiki page](https://github.com/reddit-archive/reddit/wiki/OAuth2-Quick-Start-Example)의 첫 단계를 따르십시오.

<div class='note'>
이 통합구성요소는 Reddit의 2 단계 인증을 지원하지 않습니다. Reddit 계정에 2 단계 인증을 사용하는 경우 Home Assistant에서 사용할 2 단계 인증없이 별도의 Reddit 계정을 작성하십시오.
</div>

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: reddit
    username: !secret reddit_username
    password: !secret reddit_password
    client_id: !secret reddit_client_id
    client_secret: !secret reddit_client_secret
    subreddits:
      - news
      - worldnews
```

{% configuration %}
username:
  description: Your Reddit account username.
  required: true
  type: string
password:
  description: Your Reddit account password.
  required: true
  type: string
client_id:
  description: Your Reddit account client ID.
  required: true
  type: string
client_secret:
  description: Your Reddit account client secret
  required: true
  type: string
subreddits:
  description: List of subreddits you want to get data on.
  required: true
  type: list
sort_by:
  description: "Sort reddit posts by `new`, `top`, `controversial` and `hot`."
  required: false
  type: string
  default: hot
{% endconfiguration %}
