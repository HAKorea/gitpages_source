---
title: "RFXtrx Switch"
description: "Instructions on how to integrate RFXtrx switches into Home Assistant."
logo: rfxtrx.png
ha_category:
  - Switch
ha_release: 0.7.5
---

`rfxtrx` 플랫폼은 433.92 MHz의 주파수 범위에서 통신하는 스위치를 지원합니다.

## 설정

먼저 [rfxtrx hub](/integrations/rfxtrx/)를 설정해야합니다.
스위치를 찾는 가장 쉬운 방법은 이것을 `configuration.yaml`에 추가하는 것입니다.

```yaml
# Example configuration.yaml entry
switch:
  platform: rfxtrx
  automatic_add: true
```

홈어시스턴트를 시작하고 웹 사이트로 이동하십시오.
리모컨을 누르면 장치가 추가되어야합니다.

<p class='img'>
<img src='/images/integrations/rfxtrx/switch.png' />
</p>

여기서 이름은 `0b11000102ef9f210010f70`이며 프런트 엔드에서 작동하는지 확인할 수 있습니다.
그런 다음 설정을 다음과 같이 업데이트해야합니다.

```yaml
# Example configuration.yaml entry
switch:
  platform: rfxtrx
  devices:
    0b11000102ef9f210010f70:
      name: device_name
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
      description: Fires an event even if the state is the same as before, for example, a doorbell switch. Can also be used for automations.
      required: false
      default: false
      type: boolean
automatic_add:
  description: To enable the automatic addition of new switches.
  required: false
  default: false
  type: boolean
signal_repetitions:
  description: Because the RFXtrx device sends its actions via radio and from most receivers, it's impossible to know if the signal was received or not. Therefore you can configure the switch to try to send each signal repeatedly.
  required: false
  type: integer
{% endconfiguration %}

<div class='note warning'>

이 통합구성요소 및 [rfxtrx 이진 센서](/integrations/binary_sensor.rfxtrx/)는 `automatic_add` 설정 매개 변수를 `true`로 설정할 때 서로의 장치를 가져갈 수 있습니다. 설치에 추가할 장치가 있는 경우에만 `automatic_add`를 설정하고 그렇지 않으면 `false`로 두십시오.

</div>

<div class='note warning'>
device ID가 숫자로만 구성되어 있으면 따옴표로 묶어야합니다.
device ID는 숫자로 해석되므로 YAML의 알려진 제한 사항입니다.
</div>

코드 생성 :

스위치 코드(switch code)를 생성해야하는 경우 템플릿을 사용할 수 있습니다 (COCO 스위치의 경우 유용합니다.).

- Go to home-assistant-IP:8123/dev-template
- Use this code to generate a code:

```yaml
{% raw %}0b11000{{ range(100,700) | random | int }}bc0cfe0{{ range(0,10) | random | int }}010f70{% endraw %}
```

- 이 코드를 사용하여 설정에 새 스위치를 추가하십시오.
- 홈어시스턴트를 시작하고 웹 사이트로 이동하십시오.
- 스위치에서 학습 모드를 활성화합니다 (예: 학습 버튼을 누르거나 벽면 콘센트에 연결)
- 홈어시스턴트 인터페이스에서 새 스위치 토글

## 사례

3 개의 장치를 사용한 기본 설정 :

```yaml
# Example configuration.yaml entry
switch:
  platform: rfxtrx
  automatic_add: false
  signal_repetitions: 2
  devices:
    0b1100ce3213c7f210010f70:
      name: Movement1
    0b11000a02ef2gf210010f50:
      name: Movement2
    0b1111e003af16aa10000060:
      name: Door
      fire_event: true
```

초인종을 눌렀을 때의 hallway에 조명을 켜십시오. (햇빛이 비칠 때) :

```yaml
# Example configuration.yaml entry
switch:
  platform: rfxtrx
  automatic_add: false
  devices:
    0710014c440f0160:
      name: Hall
    "0710010244080780":
      name: Door
      fire_event: true

automation:
  - alias: Switch the light on when doorbell rings if the sun is below the horizon and the light was off
    trigger:
      platform: event
      event_type: button_pressed
      event_data: {"entity_id": "switch.door"}
    condition:
      condition: and
      conditions:
        - condition: state
          entity_id: sun.sun
          state: "below_horizon"
        - condition: state
          entity_id: switch.hall
          state: 'off'
    action:
      - service: switch.turn_on
        entity_id: switch.hall
```

리모컨을 사용하여 장면을 활성화하십시오 (event_data 사용) : 

```yaml
# Example configuration.yaml entry
switch:
  platform: rfxtrx
  automatic_add: false
  devices:
    0b1100ce3213c7f210010f70:
      name: Light1
    0b11000a02ef2gf210010f50:
      name: Light2
    0b1111e003af16aa10000060:
      name: Keychain remote
      fire_event: true
scene:
  name: Livingroom
  entities:
    switch.light1: on
    switch.light2: on

automation:
  - alias: Use remote to enable scene
    trigger:
      platform: event
      event_type: button_pressed
      event_data: {"state": "on", "entity_id": "switch.keychain_remote"}
    action:
      service: scene.turn_on
      entity_id: scene.livingroom
```
