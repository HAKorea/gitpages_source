---
title: "Command Line 커버(Cover)"
description: "How to control a cover with the command line."
logo: command_line.png
ha_category:
  - Cover
ha_release: 0.14
ha_iot_class: Local Polling
---

`command_line` 은 플랫폼이 위, 아래, 멈출 때 특정 명령을 내리는 플랫폼입니다. Command Line에서 제어할 수있는 모든 유형의 Cover를 Home Assistant에 통합 할 수 있습니다.

설치에서 Command Line Cover를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
cover:
  - platform: command_line
    covers:
      garage_door:
        command_open: move_command up garage
        command_close: move_command down garage
        command_stop: move_command stop garage
```

{% configuration %}
covers:
  description: The array that contains all command line covers.
  required: true
  type: list
  keys:
    identifier:
      description: Name of the command line cover as slug. Multiple entries are possible.
      required: true
      type: list
      keys:
        command_open:
          description: The command to open the cover.
          required: true
          default: true
          type: string
        command_close:
          description: The action to close the cover.
          required: true
          default: true
          type: string
        command_stop:
          description: The action to stop the cover.
          required: true
          default: true
          type: string
        command_state:
          description: If given, this will act as a sensor that runs in the background and updates the state of the cover. If the command returns a `0` the indicates the cover is fully closed, whereas a 100 indicates the cover is fully open.
          required: false
          type: string
        value_template:
          description: if specified, `command_state` will ignore the result code of the command but the template evaluating will indicate the position of the cover. For example, if your `command_state` returns a string "open", using `value_template` as in the example config above will allow you to translate that into the valid state `100`.
          required: false
          default: "'{% raw %}{{ value }}{% endraw%}'"
          type: template
        friendly_name:
          description: The name used to display the cover in the frontend.
          required: false
          type: string
{% endconfiguration %}

## 사례

이 섹션에는이 센서를 사용하는 방법에 대한 실제 예가 나와 있습니다.

### 전체 설정

```yaml
# Example configuration.yaml entry
cover:
  - platform: command_line
    covers:
      garage_door:
        command_open: move_command up garage
        command_close: move_command down garage
        command_stop: move_command stop garage
        command_state: state_command garage
        value_template: {% raw %}>
          {% if value == 'open' %}
          100
          {% elif value == 'closed' %}
          0
          {% endif %}
          {% endraw %}
```
