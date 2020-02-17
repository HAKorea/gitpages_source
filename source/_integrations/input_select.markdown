---
title: Input Select
description: Instructions on how to integrate the Input Select integration into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.13
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`input_select` 통합구성요소를 통해 사용자는 프론트 엔드를 통해 선택할 수 있고 자동화 조건 내에서 사용할 수 있는 값 목록을 정의할 수 있습니다. 사용자가 새 항목을 선택하면 상태 전이(transition) 이벤트가 생성됩니다. 이 상태 이벤트는 `자동화` 트리거에서 사용할 수 있습니다.

설치시 이 플랫폼을 활성화하려면 `configuration.yaml`에 다음 줄을 추가하십시오. :

```yaml
# Example configuration.yaml entry
input_select:
  who_cooks:
    name: Who cooks today
    options:
      - Paulus
      - Anne Therese
    initial: Anne Therese
    icon: mdi:panda
  living_room_preset:
    options:
      - Visitors
      - Visitors with kids
      - Home Alone
```

{% configuration %}
  input_select:
    description: 입력 별칭. 여러 항목이 허용됩니다.
    required: true
    type: map
    keys:
      options:
        description: 선택할 수있는 옵션 목록.
        required: true
        type: list
      name:
        description: 친숙한 입력 이름.
        required: false
        type: string
      initial:
        description: 홈 어시스턴트 시작시 초기값.
        required: false
        type: map
        default: 옵션의 첫 번째 요소
      icon:
        description: 프런트 엔드에서 입력 요소 앞에 표시되는 아이콘입니다.
        required: false
        type: icon
{% endconfiguration %}

<div class='note'>

YAML은 [booleans](https://yaml.org/type/bool.html)을 동등한 것으로 정의하기 때문에 인용 부호로 정의되지 않는 한 옵션 이름으로 사용 된 'On', 'Yes', 'Y', 'Off', 'No'또는 'N'(대소 문자에 관계없이)의 변형은 True 및 False로 대체됩니다. 

</div>

### 상태 복원 (Restore State)

'초기'에 유효한 값을 설정하면 이 연동은 상태가 해당 값으로 설정된 상태에서 시작됩니다. 그렇지 않으면, 홈 어시스턴트 중지 이전의 상태를 복원합니다.

### 서비스 (Services)

이 통합은`input_select`의 상태를 수정하는 세가지 서비스를 제공합니다.

| Service | Data | Description |
| ------- | ---- | ----------- |
| `select_option` | `option` | 특정 옵션을 선택하는 데 사용 가능
| `set_options` | `options`<br>`entity_id(s)` | 특정 `input_select` entity 에 대한 옵션을 설정
| `select_previous` | | 이전 옵션을 선택.
| `select_next` | | 다음 옵션을 선택.
| `reload` | | `input_select` 설정 리로드(reload) |

### Scenes

[Scene] (/ integrations / scene /)에서 대상 옵션을 지정하는 것은 간단합니다 : 

```yaml
# Example configuration.yaml entry
scene:
  - name: Example1
    entities:
      input_select.who_cooks: Paulus
```

옵션 목록은 [Scene](/integrations/scene)에서도 설정할 수 있습니다. 이 경우 새 상태를 지정해야 합니다.

```yaml
# Example configuration.yaml entry
scene:
  - name: Example2
    entities:
      input_select.who_cooks:
        options:
          - Alice
          - Bob
          - Paulus
        state: Bob
```


## 자동화 사례 (Automation Examples)

다음 예제는 자동화에서 `input_select.select_option` 서비스의 사용법을 보여줍니다 : 

```yaml
# Example configuration.yaml entry
automation:
  - alias: example automation
    trigger:
      platform: event
      event_type: MY_CUSTOM_EVENT
    action:
      - service: input_select.select_option
        data:
          entity_id: input_select.who_cooks
          option: Paulus
```

`input_select` 옵션을 동적으로 설정하려면 `input_select.set_options`를 호출하면됩니다. 자동화 규칙에서 다음 예제를 사용할 수 있습니다.

```yaml
# Example configuration.yaml entry
automation:
  - alias: example automation
    trigger:
      platform: event
      event_type: MY_CUSTOM_EVENT
    action:
      - service: input_select.set_options
        data:
          entity_id: input_select.who_cooksi
          options: ["Item A", "Item B", "Item C"]
```

`input_select`가 자동화에서 MQTT action에 의해 설정되고 제어되는 양방향 방식으로 사용되는 예.

{% raw %}
```yaml
# Example configuration.yaml entry using 'input_select' in an action in an automation
   
# Define input_select
input_select:
  thermostat_mode:
    name: Thermostat Mode
    options:
      - "auto"
      - "off"
      - "cool"
      - "heat"
    icon: mdi:target

# Automation.     
 # This automation script runs when a value is received via MQTT on retained topic: thermostatMode
 # It sets the value selector on the GUI. This selector also had its own automation when the value is changed.
- alias: Set Thermostat Mode Selector
  trigger:
    platform: mqtt
    topic: "thermostatMode"
   # entity_id: input_select.thermostat_mode
  action:
     service: input_select.select_option
     data_template:
      entity_id: input_select.thermostat_mode
      option: "{{ trigger.payload }}"

 # This automation script runs when the thermostat mode selector is changed.
 # It publishes its value to the same MQTT topic it is also subscribed to.
- alias: Set Thermostat Mode
  trigger:
    platform: state
    entity_id: input_select.thermostat_mode
  action:
    service: mqtt.publish
    data_template:
      topic: "thermostatMode"
      retain: true
      payload: "{{ states('input_select.thermostat_mode') }}"
```
{% endraw %}
