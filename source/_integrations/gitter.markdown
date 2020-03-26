---
title: 깃터(Gitter)
description: Instructions on how to integrate a Gitter room sensor with Home Assistant
logo: gitter.png
ha_category:
  - Sensor
ha_release: 0.47
ha_codeowners:
  - '@fabaff'
---

`gitter` 센서를 사용하면 읽지 않은 메시지가 있는지 [Gitter.im](https://gitter.im) 대화방을 모니터링할 수 있습니다.

## 설정

"Personal Access Token"을 검색하려면 [Gitter Developer Apps](https://developer.gitter.im/apps)를 방문하십시오.

설치에서 Gitter 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: gitter
    api_key: YOUR_API_TOKEN
```

{% configuration %}
api_key:
  description: Your Gitter.im API token.
  required: true
  type: string
room:
  description: Gitter room to monitor.
  required: false
  type: string
  default: home-assistant/home-assistant
{% endconfiguration %}
