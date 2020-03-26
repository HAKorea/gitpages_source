---
title: 문자입력(Input Text)
description: Instructions on how to integrate the Input Text integration into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.53
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`input_text` 통합구성요소를 통해 사용자는 프론트 엔드를 통해 제어할 수 있고 자동화 조건 내에서 사용할 수있는 값을 정의할 수 있습니다. 텍스트 상자에 저장된 값을 변경하면 상태 이벤트가 생성됩니다. 이러한 상태 이벤트는 `automation` 트리거로도 사용할 수 있습니다. 암호 모드(가려진 텍스트)로 설정할 수도 있습니다.

```yaml
# Example configuration.yaml entries
input_text:
  text1:
    name: Text 1
    initial: Some Text
  text2:
    name: Text 2
    min: 8
    max: 40
  text3:
    name: Text 3
    pattern: '[a-fA-F0-9]*'
  text4:
    name: Text 4
    mode: password
```

{% configuration %}
  input_text:
    description: 별칭 입력. 여러 항목이 허용됩니다.
    required: true
    type: map
    keys:
      name:
        description: 텍스트 입력의 이름.
        required: false
        type: string
      min:
        description: 텍스트 값의 최소 길이.
        required: false
        type: integer
        default: 0
      max:
        description: 텍스트 값의 최대 길이입니다. 255는 엔터티 상태에서 허용되는 최대 문자 수입니다.
        required: false
        type: integer
        default: 100
      initial:
        description: 홈어시스턴트 시작시 초기값.
        required: false
        type: string
      icon:
        description: 프런트 엔드에서 입력 요소 앞에 표시되는 아이콘.
        required: false
        type: icon
      pattern:
        description: 클라이언트 측 검증을 위한 정규식 패턴.
        required: false
        type: string
        default: empty
      mode:
        description: "보통 `text` 또는 `password`를 지정할 수 있습니다. password 유형의 요소는 사용자가 안전하게 값을 입력할 수 있는 방법을 제공합니다."
        required: false
        type: string
        default: text
{% endconfiguration %}

### 서비스

이 통합구성요소는 `input_text` 상태를 수정하는 서비스와 Home Assistant 자체를 다시 시작하지 않고 `input_text` 설정을 다시로드하는 서비스를 제공합니다.

| Service | Data | Description |
| ------- | ---- | ----------- |
| `set_value` | `value`<br>`entity_id(s)` | 특정 `input_text` 엔티티의 값을 설정.
| `reload` | | `input_text` 설정 리로드 |

### 상태 복원

`initial`에 유효한 값을 설정하면 이 통합구성요소는 상태가 해당값으로 설정된 상태에서 시작됩니다. 그렇지 않으면, 홈어시스턴트 중지 이전의 상태를 복원합니다.

### 씬(Scenes)

[Scene](/integrations/scene/)에서 input_text의 상태를 설정하려면 :

```yaml
# Example configuration.yaml entry
scene:
  - name: Example1
    entities:
      input_text.example: Hello!
```

## 자동화 사례

다음은 자동화 작업에서 `input_text`를 사용하는 예입니다.

{% raw %}
```yaml
# Example configuration.yaml entry using 'input_text' in an action in an automation
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
input_text:
  bedroom:
    name: Brightness

automation:
  - alias: Bedroom Light - Custom
    trigger:
      platform: state
      entity_id: input_select.scene_bedroom
    action:
      - service: input_text.set_value
        # Again, note the use of 'data_template:' rather than the normal 'data:' if you weren't using an input variable.
        data_template:
          entity_id: input_text.bedroom
          value: "{{ states('input_select.scene_bedroom') }}"
```
{% endraw %}
