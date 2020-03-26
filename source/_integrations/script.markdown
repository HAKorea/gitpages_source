---
title: 스크립트(Scripts)
description: Instructions on how to setup scripts within Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.7
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

<div class='videoWrapper'>
<iframe width="776" height="437" src="https://www.youtube.com/embed/sVqyDtEjudk?start=903" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
</div>

`script` 통합구성요소는 사용자가 액션(action)의 시퀀스(sequence)가 홈어시스턴트에 의해 실행되도록 지정할 수 있습니다. 스크립트를 켤 때 실행됩니다. 스크립트 통합구성요소는 각 스크립트에 대한 엔티티를 작성하고 서비스를 통해 제어할 수 있도록합니다.

## 설정 

일련의 액션(action)은 [홈어시스턴트 Script 문법](/getting-started/scripts/)을 사용하여 지정됩니다 .

```yaml
# Example configuration.yaml entry
script:
  message_temperature:
    sequence:
      # This is Home Assistant Script Syntax
      - service: notify.notify
        data_template:
          message: Current temperature is {% raw %}{{ states('sensor.temperature') }}{% endraw %}
```

<div class='note'>

스크립트 이름(예: 위의 예에서 `message_temperature`)은 대문자나 대시(`-`)문자를 포함할 수 없습니다. 가독성을 높이기 위해 단어를 구분하는 기본 방법은 밑줄 (`_`) 문자를 사용하는 것입니다.

</div>

{% configuration %}
alias:
  description: 스크립트의 이름.
  required: false
  type: string
description:
  description: 개발자 도구의 서비스탭에 표시될 스크립트에 대한 설명.
  required: false
  default: ''
  type: string
fields:
  description: 스크립트가 사용하는 매개 변수에 대한 정보. 아래의 [Passing variables to scripts](#passing-variables-to-scripts) 섹션을 참조하십시오.
  required: false
  default: {}
  type: map
  keys:
    PARAMETER_NAME:
      description: 이 스크립트에서 사용하는 매개 변수.
      type: map
      keys:
        description:
          description: PARAMETER_NAME에 대한 설명.
          type: string
        example:
          description: PARAMETER_NAME의 예제 값.
          type: string
sequence:
  description: 스크립트에서 수행할 일련의 액션.
  required: true
  type: list
{% endconfiguration %}

### 전체 설정

{% raw %}

```yaml
script: 
  wakeup:
    alias: Wake Up
    description: 'Turns on the bedroom lights and then the living room lights after a delay'
    fields:
      minutes:
        description: 'The amount of time to wait before turning on the living room lights'
        example: 1
    sequence:
      # This is Home Assistant Script Syntax
      - event: LOGBOOK_ENTRY
        event_data:
          name: Paulus
          message: is waking up
          entity_id: device_tracker.paulus
          domain: light
      - alias: Bedroom lights on
        service: light.turn_on
        data:
          entity_id: group.bedroom
          brightness: 100
      - delay:
          # supports seconds, milliseconds, minutes, hours
          minutes: {{ minutes }}
      - alias: Living room lights on
        service: light.turn_on
        data:
          entity_id: group.living_room
```

{% endraw %}

### 변수를 스크립트에 전달 (Passing variables to scripts)

서비스의 일부로 변수를 스크립트로 전달하여 해당 스크립트의 템플릿 내에서 변수를 사용할 수 있습니다.

이를 구현하는 두 가지 방법이 있습니다. 한 가지 방법은 일반 `script.turn_on` 서비스를 사용하는 것입니다 . 이 서비스를 통해 스크립트에 변수를 전달하려면 원하는 변수를 사용하여, 변수를 호출하십시오.

```yaml
# Example configuration.yaml entry
automation:
  trigger:
    platform: state
    entity_id: light.bedroom
    from: 'off'
    to: 'on'
  action:
    service: script.turn_on
    entity_id: script.notify_pushover
    data:
      variables:
        title: 'State change'
        message: 'The light is on!'
```

다른 방법은 스크립트를 서비스로 직접 호출하는 것입니다. 이 경우 모든 서비스 데이터를 변수로 사용할 수 있습니다. 위의 스크립트에 이 방법을 적용하면 다음과 같습니다.

```yaml
# Example configuration.yaml entry
automation:
  trigger:
    platform: state
    entity_id: light.bedroom
    from: 'off'
    to: 'on'
  action:
    service: script.notify_pushover
    data:
      title: 'State change'
      message: 'The light is on!'
```

스크립트에서 변수를 사용하려면 `data_template`을 사용해야합니다. : 

```yaml
# Example configuration.yaml entry
script:
  notify_pushover:
    description: 'Send a pushover notification'
    fields:
      title:
        description: 'The title of the notification'
        example: 'State change'
      message:
        description: 'The message content'
        example: 'The light is on!'
    sequence:
      - condition: state
        entity_id: switch.pushover_notifications
        state: 'on'
      - service: notify.pushover
        data_template:
          title: "{% raw %}{{ title }}{% endraw %}"
          message: "{% raw %}{{ message }}{% endraw %}"
```

### 개요에서 (In the Overview)

장치에 `delay:` 또는 `wait:` 문이 없는 경우 개요 패널(Overview Panel)의 스크립트는 **EXECUTE** 단추와 함께 표시되며 토글스위치 중 하나가 있으면 토글스위치로 표시됩니다.

실행중인 스크립트를 중지할 수 있습니다.