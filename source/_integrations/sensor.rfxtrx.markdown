---
title: "RFXtrx Sensor"
description: "Instructions on how to integrate RFXtrx sensors into Home Assistant."
logo: rfxtrx.png
ha_category:
  - Sensor
ha_iot_class: Local Polling
ha_release: 0.7
---

`rfxtrx` 플랫폼은 433.92 MHz의 주파수 범위에서 통신하는 센서를 지원합니다.

먼저 [rfxtrx hub](/integrations/rfxtrx/)를 설정해야합니다.
센서를 찾는 가장 쉬운 방법은 이를 `configuration.yaml`에 추가하는 것입니다.

```yaml
# Example configuration.yaml entry
sensor:
  platform: rfxtrx
  automatic_add: true
```

그런 다음 센서가 신호를 방출하면 자동으로 추가됩니다. : 

<p class='img'>
<img src='/images/integrations/rfxtrx/sensor.png' />
</p>

여기서 이름은 `0a52080000301004d240259` 또는 `0a52080000301004d240259_temperature`이며 프런트 엔드에서 작동하는지 확인할 수 있습니다. 그런 다음 설정을 다음과 같이(_temperature가 필요하지 않음)으로 업데이트해야합니다. : 

```yaml
# Example configuration.yaml entry
sensor:
  platform: rfxtrx
  devices:
    0a52080000301004d240259:
      name: device_name
```

하나의 센서에서 여러 데이터 유형을 표시하려는 경우 :

```yaml
# Example configuration.yaml entry
sensor:
  platform: rfxtrx
  devices:
    0a520802060100ff0e0269:
      name: Bath
      data_type:
       - Humidity
       - Temperature
```

이 data_type들만 유효합니다. : 

- *Temperature*, *Temperature2*
- *Humidity*
- *Humidity status*
- *Barometer*
- *Wind direction*
- *Wind average speed*
- *Wind gust*
- *Rain rate*
- *Rain total*
- *Sound*
- *Sensor Status*
- *Counter value*
- *UV*
- *Forecast*
- *Forecast numeric*
- *Chill*
- *Energy usage*
- *Total usage*
- *Voltage*
- *Current*
- *Battery numeric*
- *Rssi numeric*

설정 사례 : 

```yaml
# Example configuration.yaml entry
sensor:
  platform: rfxtrx
  automatic_add: true
  devices:
    0a52080705020095220269:
      name: Lving
      fire_event: true
    0a520802060100ff0e0269:
      name: Bath
      data_type:
       - Humidity
       - Temperature
```

{% configuration %}
devices:
  description: A list of devices.
  required: false
  type: list
  keys:
    name:
      description: Override the name to use in the frontend.
      required: false
      type: string
    fire_event:
      description: Fires an event even if the state is the same as before. Can be used for automations.
      required: false
      default: false
      type: boolean
    data_type:
      description: Which data type the sensor should show.
      required: false
      type: list
automatic_add:
  description: To enable the automatic addition of new lights.
  required: false
  default: false
  type: boolean
{% endconfiguration %}

<div class='note warning'>
device ID가 숫자로만 구성되어 있으면 따옴표로 묶어야합니다.
device ID는 숫자로 해석되므로 YAML의 알려진 제한 사항입니다.
</div>
