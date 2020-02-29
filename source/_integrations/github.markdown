---
title: 깃허브
description: How to integrate the GitHub sensor into Home Assistant.
logo: github.png
ha_category:
  - Sensor
ha_release: 0.88
ha_iot_class: Cloud Polling
---

GitHub 센서는 [GitHub](https://github.com/)의 데이터를 연동하여 선호하는 저장소(repository)를 모니터링합니다

## 셋업

이 센서를 설정하려면 [personal access token](https://github.com/settings/tokens)이 필요합니다. 센서가 작동하려면 `repo` 범위를 확인해야합니다.

## 설정

이 플랫폼을 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: github
    access_token: !secret github_access_token
    repositories:
      - path: 'home-assistant/home-assistant'
```

{% configuration %}
access_token:
  description: GitHub 액세스 토큰
  required: true
  type: string
url:
  description: GitHub Enterprise 서버를 사용하는 경우 여기에 URL을 추가하십시오. 예를 들면, `https://mygithubserver.com`
  required: false
  type: string
repositories:
  description: 저장소 경로 목록 및 이름
  required: true
  type: list
  keys:
    path:
      description: 저장소 경로.  홈어시스턴트의 경우 `home-assistant/home-assistant`
      required: true
      type: string
    name:
      description: 센서 이름. 홈어시스턴트에서 센서에 사용자 지정 이름을 제공합니다. 지정되지 않은 경우 기본값은 GitHub의 저장소 이름입니다.
      required: false
      type: string
{% endconfiguration %}
