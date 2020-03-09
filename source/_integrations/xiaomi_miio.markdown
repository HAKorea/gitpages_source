---
title: 샤오미 miio
description: Instructions how to integrate your Xiaomi Mi WiFi Repeater 2 within Home Assistant.
logo: xiaomi.png
ha_category:
  - Presence Detection
ha_iot_class: Local Polling
ha_release: 0.67
ha_codeowners:
  - '@rytilahti'
  - '@syssi'
---

`xiaomi_miio` 장치 추적기 플랫폼은 Xiaomi Mi WiFi Repeater 2를 관찰하고 관련된 모든 WiFi 클라이언트를 보고합니다.

API 토큰을 얻으려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token)의 지침을 따르십시오.

Xiaomi Mi WiFi Repeater 장치 추적기를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
device_tracker:
  - platform: xiaomi_miio
    host: 192.168.130.73
    token: YOUR_TOKEN
```

{% configuration %}
host:
  description: The IP address of your miio device.
  required: true
  type: string
token:
  description: The API token of your miio device.
  required: true
  type: string
{% endconfiguration %}
