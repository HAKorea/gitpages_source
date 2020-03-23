---
title: "RFXtrx Cover"
description: "Instructions on how to integrate RFXtrx covers into Home Assistant."
logo: rfxtrx.png
ha_category:
  - Cover
ha_release: 0.27
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/37P9VTqE9Qk" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`rfxtrx` 플랫폼은 433.92 MHz의 주파수 범위에서 통신하는 Siemens/LightwaveRF 및 RFY 롤러 셔터를 지원합니다.

먼저 [rfxtrx hub](/integrations/rfxtrx/)를 설정해야합니다.

### 설정

##### Siemens/LightwaveRF

롤러 셔터를 찾는 가장 쉬운 방법은 이것을 `configuration.yaml`에 추가하는 것입니다.

```yaml
cover:
  - platform: rfxtrx
    automatic_add: true
```

홈어시스턴트를 시작하고 웹 사이트로 이동하십시오 (예: `http://localhost:8123`). 리모컨을 누르면 장치가 추가되어야합니다.

추가되면 ID(예: `0b11000102ef9f210010f70`)가 표시되고 프런트 엔드에서 작동하는지 확인할 수 있습니다. 그런 다음 설정을 다음과 같이 업데이트해야합니다. : 

```yaml
cover:
  - platform: rfxtrx
    devices:
      0b11000102ef9f210010f70:
        name: device_name
```

##### RFY

RFY 지원항목에는 [RFXtrx433e](http://www.rfxcom.com/RFXtrx433E-USB-43392MHz-Transceiver/en)가 필요하지만 RFY 프로토콜 수신은 지원하지 않습니다. - 이러한 장치는 자동으로 추가할 수 없습니다. 대신 [rfxmngr](http://www.rfxcom.com/downloads.htm) 도구에서 장치를 설정하십시오. 할당된 ID 및 Unit Code를 기록한 후 다음 ID가 `071a0000[id][unit_code]`인 설정에 장치를 추가하십시오. 예를 들어, id가 `0a``00``01`이고 Unit Code가 `01`인 경우, rfxmngr에서 id/code를 단일 숫자로 설정하면 정규화된 id는 `071a00000a000101`입니다. 예를들어 id: `1``02``04`, unit code: `1`이면 전에 `0`을 추가해야하므로 `102031`은 `071a000001020301`이 됩니다.

##### Common

설정 사례 : 

```yaml
# Example configuration.yaml entry
cover:
  - platform: rfxtrx
    automatic_add: false
    signal_repetitions: 2
    devices:
      0b1100ce3213c7f210010f70: # Siemens/LightwaveRF
        name: Bedroom Shutter
      071a00000a000101: # RFY
        name: Bathroom Shutter
```

{% configuration %}
devices:
  description: A list of devices.
  required: false
  type: list
  keys:
    name:
      description: Override the name to use in the frontend.
      required: true
      type: string
    fire_event:
      description: Fires an event even if the state is the same as before. Can be used for automations.
      required: false
      default: false
      type: boolean
automatic_add:
  description: To enable the automatic addition of new covers (Siemens/LightwaveRF only).
  required: false
  default: false
  type: boolean
signal_repetitions:
  description: Because the rxftrx device sends its actions via radio and from most receivers it's impossible to know if the signal was received or not. Therefore you can configure the roller shutter to try to send each signal repeatedly.
  required: false
  type: integer
{% endconfiguration %}

<div class='note warning'>
device ID가 숫자로만 구성되어 있으면 따옴표로 묶어야합니다.
device ID는 숫자로 해석되므로 YAML의 알려진 제한 사항입니다.
</div>
