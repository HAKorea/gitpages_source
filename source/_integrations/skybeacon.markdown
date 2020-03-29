---
title: 스카이비컨(Skybeacon)
description: Instructions on how to integrate MiFlora BLE plant sensor with Home Assistant.
ha_category:
  - DIY
ha_release: 0.37
ha_iot_class: Local Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/qHJz19Z1b7k" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`skybeacon` 센서 플랫폼은 온도/센서 모듈과 함께 제공되며 [CR2477](https://cnsky9.en.alibaba.com/)밧데리로 구동되는 [iBeacon](https://en.wikipedia.org/wiki/IBeacon)/eddystone 센서를 지원합니다.

## 설정

설치시 Skybeacon 센서를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: skybeacon
    mac: "xx:xx:xx:xx:xx:xx"
    monitored_conditions:
      - temperature
      - humidity
```

{% configuration %}
mac:
  description: "The MAC address of your sensor. You can find this be running `hcitool lescan` from command line."
  required: true
  type: string
name:
  description: The name of the Skybeacon sensor.
  required: false
  type: string
  default: Skybeacon
monitored_conditions:
  description: The parameters that should be monitored.
  required: false
  type: list
  keys:
    temperature:
      description: Temperature at the sensor's location.
    humidity:
      description: Humidity at the sensor's location.
{% endconfiguration %}
