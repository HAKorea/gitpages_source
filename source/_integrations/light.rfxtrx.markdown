---
title: "RFXtrx Light"
description: "Instructions on how to integrate RFXtrx lights into Home Assistant."
logo: rfxtrx.png
ha_category:
  - Light
ha_release: 0.7.5
ha_iot_class: Assumed State
---

`rfxtrx` 플랫폼은 433.92 MHz의 주파수 범위에서 통신하는 조명을 지원합니다.

먼저 [rfxtrx hub](/integrations/rfxtrx/)를 설정해야합니다.

조명을 찾는 가장 쉬운 방법은 이것을 `configuration.yaml`에 추가하는 것입니다.

```yaml
light:
  - platform: rfxtrx
    automatic_add: true
```

홈어시스턴트를 시작하고 웹 사이트로 이동하십시오. 리모컨을 누르면 장치가 추가되어야합니다.

<p class='img'>
<img src='/images/integrations/rfxtrx/switch.png' />
</p>

여기서 이름은 `0b11000102ef9f210010f70`이며 프런트 엔드에서 작동하는지 확인할 수 있습니다. 그런 다음 설정을 다음과 같이 업데이트해야합니다.

```yaml
light:
  platform: rfxtrx
  devices:
    0b11000102ef9f210010f70:
      name: device_name
```

설정 사례 : 

```yaml
# Example configuration.yaml entry
light:
  platform: rfxtrx
  devices:
    0b11000f10e9e5660b010f70:
      name: Light1
    0b1100100f29e5660c010f70:
      name: Light_TV
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
  description: To enable the automatic addition of new lights.
  required: false
  default: false
  type: boolean
signal_repetitions:
  description: Because the RFXtrx device sends its actions via radio and from most receivers it's impossible to know if the signal was received or not. Therefore you can configure the switch to try to send each signal repeatedly.
  required: false
  type: integer
{% endconfiguration %}

<div class='note warning'>
device ID가 숫자로만 구성되어 있으면 따옴표로 묶어야합니다.
device ID는 숫자로 해석되므로 YAML의 알려진 제한 사항입니다.
</div>
