---
title: 템플릿 경보 판넬(Template Alarm Control Panel)
description: "Instructions on how to integrate Template Alarm Control Panels into Home Assistant."
ha_category: 
  - Alarm
ha_release: 0.105
ha_iot_class: "Local Push"
logo: home-assistant.png
ha_qa_scale: internal
---

`template` 통합구성요소는 통합구성요소들을 결합하거나 사전 처리 로직을 동작에 추가하는 경보 제어판을 만듭니다.

기존 연동들을 보다 간단한 연동으로 그룹화하거나 홈어시스턴트가 액세스할 때 실행할 로직을 추가하는 등, 이 통합구성요소를 사용하는 몇 가지 강력한 방법이 있습니다.

예를 들어 실제 알람 패널을 Google Home, Alexa 또는 Homekit에 노출하고 싶지만 - 집에 아무도 없을 때 disarm되어서 제한이 생길 경우 템플릿을 사용하여 가능하게 할 수 있습니다.

다른 사용 사례는 다양한 "armed", "disarmed" 상태 그리고 액션을 나타나게 하기 위해 일련의 센서와 서비스를 그룹화 할 수 있습니다.

이를 통해 GUI를 단순화하고 자동화를보다 쉽게 ​​작성할 수 있습니다.

optimistic mode에서, 경보 제어판은 모든 명령 후 즉시 상태를 변경합니다. 그렇지 않으면 경보 제어판이 템플릿에서 상태 확인을 기다립니다. 제대로 작동하지 않으면 활성화하십시오.

## 설정

설치에서 템플릿 알람 제어판을 활성화하려면 `configuration.yaml` 파일에 다음을 추가 하십시오.

{% raw %}

```yaml
# Example configuration.yaml entry
alarm_control_panel:
  - platform: template
    name: Safe Alarm Panel
    value_template: "{{ states('alarm_control_panel.real_alarm') }}"
    arm_away:
      service: alarm_control_panel.alarm_arm_away
      data:
        entity_id: alarm_control_panel.real_alarm
        code: !secret alarm_code
    arm_home:
      service: alarm_control_panel.alarm_arm_home
      data:
        entity_id: alarm_control_panel.real_alarm
        code: !secret alarm_code
    disarm:
      - condition: state
        entity_id: device_tracker.paulus
        state: 'home'
      - service: alarm_control_panel.alarm_arm_home
        data:
          entity_id: alarm_control_panel.real_alarm
          code: !secret alarm_code
```

{% endraw %}

{% configuration %}
  name:
    description: Name to use in the frontend.
    required: false
    type: string
    default: Template Alarm Control Panel
  value_template:
    description: "Defines a template to set the state of the alarm panel. Only the states `armed_away`, `armed_home`, `armed_night`, `disarmed`, `triggered` and `unavailable` are used."
    required: false
    type: template
  disarm:
    description: Defines an action to run when the alarm is disarmed.
    required: false
    type: action
  arm_away:
    description: Defines an action to run when the alarm is armed to away mode.
    required: false
    type: action
  arm_home:
    description: Defines an action to run when the alarm is armed to home mode.
    required: false
    type: action
  arm_night:
    description: Defines an action to run when the alarm is armed to night mode.
    required: false
    type: action
{% endconfiguration %}

## 고려 사항

로드하는 데 추가 시간이 걸리는 연동 상태를 사용하는 경우 시작하는 동안 템플릿 경보 제어판이 `unknown` 상태가 될 수 있습니다. 그러면 통합이 로드를 완료 할 때까지 로그 파일에 오류 메시지가 나타납니다. 템플릿에서 `is_state ()`함수를 사용하면 이런 상황을 피할 수 있습니다.

예를 들어, {% raw %}`{{ states.switch.source.state == 'on' }}`{% endraw %} 를 쓰면 `true`/`false`과 `unknown`을 반환하지만, 절대 `unknown`을 반환하지 않는 다음 방법을 사용하십시오. : {% raw %}`{{ is_state('switch.source', 'on') }}`{% endraw %}