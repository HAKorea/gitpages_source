---
title: 산업용IOT(VersaSense)
description: Integrate your VersaSense MicroPnP devices.
date: 2019-11-19 14:00
logo: versasense.png
ha_release: 0.103
ha_category:
  - Hub
  - Sensor
  - Switch
ha_iot_class: Local Polling
ha_codeowners:
  - '@flamm3blemuff1n'
---

`VersaSense` 통합구성요소는 VersaSense Edge Gateway를 지원합니다. 게이트웨이는 메시 네트워크에서 허브와 주변 장치(센서 및 액추에이터)를 제어할 수 있습니다.

## 설정

```yaml
# Example configuration.yaml entry
versasense:
  host: GATEWAY_URI
```

{% configuration %}
host:
  description: "The IP address or hostname of the VersaSense gateway. Including *protocol* and *port*, e.g., https://gateway.versasense.com:8889"
  required: true
  type: string
{% endconfiguration %}

## 지원되는 하드웨어

소프트웨어 버전 >= 1.0.2.10 인 모든 Versasense 게이트웨이

다음 주변 장치 및 장치로 테스트되었습니다.

- S03 S04: Temperature and Humidity sensor
- S06: Barometric Pressure sensor
- S10: Light sensor
- S17: Object detection sensor
- S19: Buzzer actuator
- Pxx: SmartMesh IP Hub
- M01: SmartMesh Edge Gateway
