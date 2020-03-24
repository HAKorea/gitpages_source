---
title: 지열히트펌프(WaterFurnace)
description: Instructions on how to integrate WaterFurnace Geothermal System into Home Assistant.
logo: waterfurnace.png
ha_category:
  - Sensor
ha_release: 0.62
ha_iot_class: Cloud Polling
---

<div class='videoWrapper'>
<iframe width="690" height="437" src="https://www.youtube.com/embed/sbiq_yd-znM" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`waterfurnace` 통합구성요소는 WaterFurnace Symphony 웹 사이트의 WebSocket과 통신하여 시스템의 많은 센서를 보여줍니다. 공식 API는 아니지만 Symphony 웹 사이트가 기반으로하는 것과 동일한 백엔드이며 안정적이어야합니다.

제공되는 센서는 다음과 같습니다. :

- Thermostat Setpoint
- Thermostat Current Temp
- Leaving Air Temp
- Entering Water Loop Temp
- Current Humidity
- Current Humidity Setpoint
- Total system power (in Watts)
- Furnace Mode
- Compressor Power
- Fan Power
- Aux Power
- Loop Pump Power
- Compressor Speed
- Fan Speed

## 설정

설비에서 Waterfurnace를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
waterfurnace:
  username: YOUR_USERNAME
  password: YOUR_PASSWORD
```

{% configuration %}
username:
  description: The email address for your Symphony WaterFurnace account
  required: true
  type: string
password:
  description: The password for your Symphony WaterFurnace account
  required: true
  type: string
{% endconfiguration %}

## 제한 사항

이 모듈에서 사용하는 WebSocket 인터페이스에는 서버 측이 연결을 종료하지 못하도록 하기 위해 활성 폴링이 필요합니다. 기본적으로이 폴링은 10 초마다 발생합니다. 모든 센서는 폴링주기마다 업데이트됩니다.

온도 조절기와 통신하는 동안 지열 시스템은 장애가 발생하지 않고 집이 일정한 온도로 유지될 때 가장 효율적으로 작동합니다. 성능을 이해하기 위해 시스템에서 데이터를 수집하는 것이 유용하지만 완전한 Climate 인터페이스는 구현되지 않습니다.