---
title: "리모컨으로 조명을 어둡게 혹은 밝게"
description: "The scripts and automations to allow you to use a remote to dim and brighten a light"
ha_category: Automation Examples
---

여기에는 빛조절이 가능한 조명의 버튼을 누르고있을 때(push) 한 장면(scene)을 보내거나 놓을 때(release) 다른 장면을 보내는 Z-Wave 리모컨이 필요합니다. 이렇게하면 스크립트 (다음에 나오는)가 중지되어 종료되지 않는 스크립트의 위험을 피할 수 있습니다.

다음 자동화에서 `zwave.YOUR_REMOTE`를 컨트롤러의 실제 자신의 엔티티 ID로 바꾸십시오. 컨트롤러의 경우 위로 버튼을 눌렀을 때 scene ID 13이 전송, 놓으면 15입니다. 마찬가지로, 다운 버튼을 눌렀을 scene 14, 해제 할 때 16. 리모컨에서 전송된 scene ID가 다른 경우도 사용할 수 있습니다.

```yaml
automation: 

  - alias: 'Make the lights go bright'
    initial_state: 'on'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          scene_id: 13
          entity_id: zwave.YOUR_REMOTE
    action:
      - service: script.turn_on
        data:
          entity_id: script.light_bright

  - alias: 'Stop the bright just there'
    initial_state: 'on'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          scene_id: 15
          entity_id: zwave.YOUR_REMOTE
    action:
      - service: script.turn_off
        data:
          entity_id: script.light_bright
      - service: script.turn_off
        data:
          entity_id: script.light_bright_pause

  - alias: 'Make the lights go dim'
    initial_state: 'on'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          scene_id: 14
          entity_id: zwave.YOUR_REMOTE
    action:
      - service: script.turn_on
        data:
          entity_id: script.light_dim

  - alias: 'Stop the dim just there'
    initial_state: 'on'
    trigger:
      - platform: event
        event_type: zwave.scene_activated
        event_data:
          scene_id: 16
          entity_id: zwave.YOUR_REMOTE
    action:
      - service: script.turn_off
        data:
          entity_id: script.light_dim
      - service: script.turn_off
        data:
          entity_id: script.light_dim_pause
```

아래 스크립트의 변경 속도를 제어하는 ​​두 가지 변수가 있습니다. 첫 번째는 `step`이며 작은 step들은 부드러운 전환을 만듭니다. 두 번째는 지연이며 지연이 클수록 전환 속도가 느려집니다.

유연성을 허용하기 위해 step에 [Input Number](/integrations/input_number/)가 사용됩니다 (이를 작성할 때 지연이 밀리초를 사용하는 경우 지연을 템플릿화 할 수 없음). 최소 및 최대 밝기를 설정하는데 두 개의 추가[Input Numbers](/integrations/input_number/)가 사용되므로 이를 쉽게 조정(또는 자동화를 통해 관리)할 수 있습니다.

```yaml
input_number:
  light_step:
    name: 'Step the lights this much'
    initial: 20
    min: 1
    max: 64
    step: 1

  light_minimum:
    name: 'No dimmer than this'
    initial: 5
    min: 1
    max: 255
    step: 1
    
  light_maximum:
    name: 'No brighter than this'
    initial: 255
    min: 50
    max: 255
    step: 1
```

이제 스크립트입니다. 두 쌍의 스크립트가 있습니다. 첫 번째 단계는 빛을 최대로 밝게하고 두 번째 단계는 지연을 제공합니다. 둘 다 중지 될 때까지 서로 호출합니다. 두 번째 쌍인 디밍에서도 동일하게 적용됩니다.

```yaml
# Replace YOURLIGHT with the actual light entity
script:
    light_bright:
      sequence:
        - service: light.turn_on
          data_template:
            entity_id: light.YOUR_LIGHT
            brightness: >-
              {% raw %}{% set current = state_attr('light.YOUR_LIGHT', 'brightness')|default(0)|int %}
              {% set step = states('input_number.light_step')|int %}
              {% set next = current + step %}
              {% if next > states('input_number.light_maximum')|int %}
                {% set next = states('input_number.light_maximum')|int %}
              {% endif %}
              {{ next }}{% endraw %}

        - service_template: >
            {% raw %}{% if state_attr('light.YOUR_LIGHT', 'brightness')|default(0)|int < states('input_number.light_maximum')|int %}
              script.turn_on
            {% else %}
              script.turn_off
            {% endif %}{% endraw %}
          data:
            entity_id: script.light_bright_pause
        
    light_bright_pause:
      sequence:
        - delay:
            milliseconds: 1
        - service: script.turn_on
          data:
            entity_id: script.light_bright

    light_dim:
      sequence:
        - service: light.turn_on
          data_template:
            entity_id: light.YOUR_LIGHT
            brightness: >-
              {% raw %}{% set current = state_attr('light.YOUR_LIGHT', 'brightness')|default(0)|int %}
              {% set step = states('input_number.light_step')|int %}
              {% set next = current - step %}
              {% if next < states('input_number.light_minimum')|int %}
                {% set next = states('input_number.light_minimum')|int %}
              {% endif %}
              {{ next }}{% endraw %}

        - service_template: >
            {% raw %}{% if state_attr('light.YOUR_LIGHT', 'brightness')|default(0)|int > states('input_number.light_minimum')|int %}
              script.turn_on
            {% else %}
              script.turn_off
            {% endif %}{% endraw %}
          data:
            entity_id: script.light_dim_pause
        
    light_dim_pause:
      sequence:
        - delay:
            milliseconds: 1
        - service: script.turn_on
          data:
            entity_id: script.light_dim
```
