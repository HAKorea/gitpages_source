---
title: DIY 온도조절기(OpenEnergyMonitor WiFi Thermostat)
description: Instructions on how to integrate an OpenEnergyMonitor thermostat with Home Assistant.
logo: oem.png
ha_category:
  - Climate
ha_release: 0.39
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/t3y08wBBB8c" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

이 플랫폼은 [OpenEnergyMonitor](https://shop.openenergymonitor.com/wifi-mqtt-relay-thermostat/)에서 판매하는 ESP8266 기반 "WiFi MQTT 릴레이/온도조절장치"를 지원합니다.

기본 [라이브러리](https://oemthermostat.readthedocs.io/)는 [원래 장치](https://harizanov.com/2014/12/wifi-iot-3-channel-relay-board-with-mqtt-and-http-api-using-esp8266/)의  단일 릴레이 변경만 지원합니다.

이 플랫폼은 "수동" 모드에서 온도 조절기의 설정치를 제어합니다.

설정하려면 `configuration.yaml` 파일에 다음 정보를 추가하십시오 :

```yaml
# Example configuration.yaml entry
climate oem:
  - platform: oem
    host: 192.168.0.100
```

{% configuration %}
host:
  description: The IP address or hostname of the thermostat.
  required: true
  type: string
port:
  description: The port for the web interface.
  required: false
  default: 80
  type: integer
name:
  description: The name to use for the frontend.
  required: false
  default: Thermostat
  type: string
username:
  description: Username for the web interface if set.
  required: inclusive
  type: string
password:
  description: Password for the web interface if set.
  required: inclusive
  type: string
{% endconfiguration %}
