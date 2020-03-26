---
title: 숫자입력(Input Number)
description: Instructions on how to integrate the Input Number integration into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.55
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`input_number` 통합구성요소를 통해 사용자는 프론트 엔드를 통해 제어할 수 있고 자동화 조건 내에서 사용할 수 있는 값을 정의할 수 있습니다. 프런트 엔드에는 슬라이더 또는 숫자 입력 상자가 표시될 수 있습니다. 슬라이더 또는 숫자 입력 상자를 변경하면 상태 이벤트가 생성됩니다. 이러한 상태 이벤트는 `자동화` 트리거로도 사용할 수 있습니다.

설치시 input number를 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오 :

```yaml
# Example configuration.yaml entry
input_number:
  slider1:
    name: Slider
    initial: 30
    min: -20
    max: 35
    step: 1
  box1:
    name: Numeric Input Box
    initial: 30
    min: -20
    max: 35
    step: 1
    mode: box
```

{% configuration %}
  input_number:
    description: 입력 별칭. 여러 항목이 허용됩니다.
    required: true
    type: map
    keys:
      min:
        description: 최소값.
        required: true
        type: float
      max:
        description: 최대값.
        required: true
        type: float
      name:
        description: 친숙한 입력 이름.
        required: false
        type: string
      initial:
        description: 홈어시스턴트 시작시 초기 값.
        required: false
        type: float
        default: 종료시의 값
      step:
        description: 슬라이더의 단계값. 최소값은 `0.001`.
        required: false
        type: float
        default: 1
      mode:
        description: 장치모드를 `box` 혹은 `slider` 로 특정 가능.
        required: false
        type: string
        default: slider
      unit_of_measurement:
        description: 슬라이더 값이 표현되는 측정 단위.
        required: false
        type: string
      icon:
        description: 프런트 엔드에서 입력 요소 앞에 표시되는 아이콘입니다.
        required: false
        type: icon
{% endconfiguration %}

### Services

이 연동은 홈어시스턴트 자체를 다시 시작하지 않고 `input_number`의 상태를 수정하기 위해 다음 서비스같이 리로드(reload)할 수 있게 해줍니다. 

| Service | Data | Description |
| ------- | ---- | ----------- |
| `decrement` | `entity_id(s)`<br>`area_id(s)` | 특정 `input_number` 엔티티의 값을 `step` 만큼 줄입니다.
| `increment` | `entity_id(s)`<br>`area_id(s)` | 특정 `input_number` 엔티티의 값을 `step` 만큼 늘립니다.
| `reload` | | `input_number` 설정 리로드(reload) |
| `set_value` | `value`<br>`entity_id(s)`<br>`area_id(s)` | 특정 `input_number` 엔티티의 값을 설정. 

### 상태 복원 (Restore State)

`initial`에 유효한 값을 설정하면 이 연동은 상태가 해당 값으로 설정된 상태에서 시작됩니다. 그렇지 않으면, 홈어시스턴트 중지 이전의 상태를 복원합니다.

### 씬 (Scenes)

[Scene](/integrations/scene/)에서 input_number의 값을 설정 :

```yaml
# Example configuration.yaml entry
scene:
  - name: Example Scene
    entities:
      input_number.example_number: 13
```

## 자동화 샘플 (Automation Examples)

다음은 자동화에서 트리거로 사용되는 `input_number`의 예입니다.

{% raw %}
```yaml
# Example configuration.yaml entry using 'input_number' as a trigger in an automation
input_number:
  bedroom_brightness:
    name: Brightness
    initial: 254
    min: 0
    max: 254
    step: 1
automation:
  - alias: Bedroom Light - Adjust Brightness
    trigger:
      platform: state
      entity_id: input_number.bedroom_brightness
    action:
      - service: light.turn_on
        # Note the use of 'data_template:' below rather than the normal 'data:' if you weren't using an input variable
        data_template:
          entity_id: light.bedroom
          brightness: "{{ trigger.to_state.state | int }}"
```
{% endraw %}

`input_number`를 사용하는 또 다른 코드 예제로, 이번에는 자동화 작업에서 사용됩니다.

{% raw %}
```yaml
# Example configuration.yaml entry using 'input_number' in an action in an automation
input_select:
  scene_bedroom:
    name: Scene
    options:
      - Select
      - Concentrate
      - Energize
      - Reading
      - Relax
      - 'OFF'
    initial: 'Select'
input_number:
  bedroom_brightness:
    name: Brightness
    initial: 254
    min: 0
    max: 254
    step: 1
automation:
  - alias: Bedroom Light - Custom
    trigger:
      platform: state
      entity_id: input_select.scene_bedroom
      to: CUSTOM
    action:
      - service: light.turn_on
        # Again, note the use of 'data_template:' rather than the normal 'data:' if you weren't using an input variable.
        data_template:
          entity_id: light.bedroom
          brightness: "{{ states('input_number.bedroom_brightness') | int }}"
```
{% endraw %}

`input_number`가 양방향 방식으로 사용되며, 자동화에서 MQTT action에 의해 설정되고 제어되는 예입니다.

{% raw %}
```yaml
# Example configuration.yaml entry using 'input_number' in an action in an automation
input_number:
  target_temp:
    name: Target Heater Temperature Slider
    min: 1
    max: 30
    step: 1
    unit_of_measurement: step  
    icon: mdi:target

# This automation script runs when a value is received via MQTT on retained topic: setTemperature
# It sets the value slider on the GUI. This slides also had its own automation when the value is changed.
automation:
  - alias: Set temp slider
    trigger:
      platform: mqtt
      topic: 'setTemperature'
    action:
      service: input_number.set_value
      data_template:
        entity_id: input_number.target_temp
        value: "{{ trigger.payload }}"

# This second automation script runs when the target temperature slider is moved.
# It publishes its value to the same MQTT topic it is also subscribed to.
  - alias: Temp slider moved
    trigger:
      platform: state
      entity_id: input_number.target_temp
    action:
      service: mqtt.publish
      data_template:
        topic: 'setTemperature'
        retain: true
        payload: "{{ states('input_number.target_temp') | int }}"
```
{% endraw %}

다음 `input_number`은 자동화에서 지연으로 사용되는 예입니다.

{% raw %}
```yaml
# Example configuration.yaml entry using 'input_number' as a delay in an automation
input_number:
  minutes:
    name: minutes
    icon: mdi:clock-start
    initial: 3
    min: 0
    max: 6
    step: 1
    
  seconds:
    name: seconds
    icon: mdi:clock-start
    initial: 30
    min: 0
    max: 60
    step: 10
    
automation:
 - alias: turn something off after x time after turning it on
   trigger:
     platform: state
     entity_id: switch.something
     to: 'on'
   action:
     - delay: '00:{{ states('input_number.minutes') | int }}:{{ states('input_number.seconds') | int }}'
     - service: switch.turn_off
       entity_id: switch.something
```
{% endraw %}
