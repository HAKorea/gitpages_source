---
title: 오픈지능형계량기(Volkszaehler)
description: Instructions on how to integrate Volkszaehler sensors into Home Assistant.
logo: volkszaehler.png
ha_category:
  - System Monitor
ha_iot_class: Local Polling
ha_release: 0.78
---

`volkszaehler` 센서 플랫폼은 [Volkszaehler](https://wiki.volkszaehler.org/) API에서 제공하는 시스템 정보를 사용합니다.

## 설정

Volkszaehler 센서를 활성화하려면 `configuration.yaml`에 다음 라인을 추가하십시오 :

```yaml
# Example configuration.yaml entry
sensor:
  - platform: volkszaehler
    uuid: DEVICE_UUID
```

{% configuration %}
uuid:
  description: The UUID of the device to track.
  required: true
  type: string
host:
  description: The IP address of the host where Volkszaehler is running.
  required: false
  type: string
  default: localhost
port:
  description: The port where Volkszaehler is listening.
  required: false
  type: integer
  default: 80
name:
  description: The prefix for the sensors.
  required: false
  type: string
  default: Volkszaehler
monitored_conditions:
  description: Entries to monitor.
  required: false
  type: list
  default: average
  keys:
    average:
      description: The average power.
    consumption:
      description: The power consumption.
    max:
      description: The maximum power.
    min:
      description: The minimum power.
{% endconfiguration %}

## 전체 설정

```yaml
# Example configuration.yaml entry
sensor:
  - platform: volkszaehler
    host: demo.volkszaehler.org
    uuid: '57acbef0-88a9-11e4-934f-6b0f9ecd95a8'
    monitored_conditions:
      - average
      - consumption
      - min
      - max
```
