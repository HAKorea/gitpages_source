---
title: 잔디깎기기계(Worx Landroid)
description: Instructions on how to integrate Worx Landroid WG796E.1 or WG797E as sensors within Home Assistant.
logo: worx.png
ha_category:
  - DIY
ha_release: 0.54
ha_iot_class: Local Polling
---

`worxlandroid` 센서 플랫폼을 사용하면 현재 상태, 배터리 레벨 및 오류 상태 Worx Landroid WG796E.1 또는 WG797E를 얻을 수 있습니다.

Worx Landroid 모어를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  platform: worxlandroid
  host: 192.168.0.10
  pin: 1234
```

{% configuration %}
host:
  description: The IP address or host name of the mower.
  required: true
  type: string
pin:
  description: The pin code for the mower.
  required: true
  type: integer
allow_unreachable:
  description: This will allow the mower to be outside of wifi range without raising an error.
  required: false
  type: boolean
  default: true
{% endconfiguration %}
