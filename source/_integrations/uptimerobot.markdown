---
title: 업타임로봇(Uptime Robot)
description: Instructions on how to set up Uptime Robot within Home Assistant.
logo: uptimerobot.png
ha_category:
  - System Monitor
ha_release: 0.72
ha_iot_class: Cloud Polling
ha_codeowners:
  - '@ludeeus'
---

`uptimerobot` 바이너리 센서 플랫폼을 사용하면 [Uptime Robot](https://uptimerobot.com)의 계정에서 모든 모니터의 상태를 확인할 수 있습니다

## 설정

센서를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: uptimerobot
    api_key: YOUR_API_KEY
```

{% configuration %}
api_key:
  description: Your Uptime Robot API key.
  required: true
  type: string
{% endconfiguration %}

모든 데이터는 [Uptime Robot](https://uptimerobot.com)에서 가져옵니다.

API 키를 얻으려면 Uptime Robot 웹 사이트의 [My Settings](https://uptimerobot.com/dashboard#mySettings)로 이동하십시오. 맨 아래에는 "Main API Key"가 있습니다.