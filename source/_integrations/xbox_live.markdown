---
title: Xbox 라이브
description: Instructions on how to set up Xbox Live sensors in Home Assistant.
logo: xbox-live.png
ha_category:
  - Social
ha_iot_class: Cloud Polling
ha_release: 0.28
ha_codeowners:
  - '@MartinHjelmare'
---

Xbox Live 통합구성요소는 [Xbox](https://xbox.com/) 프로필을 추적 할 수 있습니다.

이 센서를 사용하려면 [XboxAPI.com](https://xboxapi.com/) 의 무료 API 키가 필요합니다 . 해당 사이트에서 Xbox 계정을 연결하십시오.

설정에서는 프로파일의 고유 식별자인 XUID를 지정해야합니다. [XboxAPI.com](https://xboxapi.com/)에서 자신의 프로필 페이지를 보거나 대화형 문서(interactive documentation)를 사용하여 게이머 태그(gamertags)를 검색하여 확인할 수 있습니다. 센서 이름은 XUID와 연결된 게이머 태그로 기본 설정됩니다.

설치에서 Xbox Live 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오. :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: xbox_live
    api_key: YOUR_API_KEY
    xuid:
      - account1
      - account2
```

{% configuration %}
api_key:
  description: "[XboxAPI.com](https://xboxapi.com/)에서 받은 API 키."
  required: true
  type: string
xuid:
  description: 추적할 프로파일 XUID의 배열
  required: true
  type: list
{% endconfiguration %}
