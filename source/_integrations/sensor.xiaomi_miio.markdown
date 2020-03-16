---
title: "샤오미 Air Quality Index Monitor"
description: "Instructions how to integrate your Xiaomi Mi Air Quality Index Monitor within Home Assistant."
logo: xiaomi.png
ha_category:
  - Health
ha_iot_class: Local Polling
ha_release: 0.66
---

`xiaomi_miio` 센서 플랫폼은 Xiaomi Mi Air Quality Monitor (PM2.5)를 관찰하고 대기질 지수를보고합니다.

현재 지원되는 기능은 다음과 같습니다. : 

- Air Quality Index (AQI)
- Attributes
  - power
  - charging
  - battery
  - time_stat

API 토큰을 얻으려면 [Retrieving the Access Token](/integrations/vacuum.xiaomi_miio/#retrieving-the-access-token)의 지침을 따르십시오.

## 설정

Xiaomi Mi Air Quality Monitor를 설치에 추가하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: xiaomi_miio
    host: IP_ADDRESS
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
name:
  description: The name of your miio device.
  required: false
  type: string
  default: Xiaomi Miio Sensor
{% endconfiguration %}
