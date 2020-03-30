---
title: "Script 문법"
description: "Documentation for the Home Assistant Script Syntax."
redirect_from: /getting-started/scripts/
---

스크립트는 홈어시스턴트가 실행할 일련의 액션(action)입니다. 스크립트는 독립형 [Script component]를 통해 엔티티로 사용할 수 있지만 [automations]과 [Alexa/Amazon Echo] 설정에 임베드될 수도 있습니다.

스크립트 문법 기본 구조는 액션이 포함 된 키/값 맵의 목록입니다. 스크립트에 액션이 하나만 있으면 줄 바꿈 목록을 생략할 수 있습니다.

```yaml
# Example script integration containing script syntax
script:
  example_script:
    sequence:
      # This is written using the Script Syntax
      - service: light.turn_on
        data:
          entity_id: light.ceiling
      - service: notify.notify
        data:
          message: 'Turned on the ceiling light!'
```

### 서비스 호출 (Service Call)

가장 중요한 것은 서비스를 호출하는 액션입니다. 이는 다양한 방법으로 수행할 수 있습니다. 다양한 가능성에 대해서는 [service calls page]를 살펴보십시오.

```yaml
- alias: Bedroom lights on
  service: light.turn_on
  data:
    entity_id: group.bedroom
    brightness: 100
```

#### 씬 활성화 (Activate a Scene)

스크립트는 또한 `scene.turn_on` 서비스를 호출하는 대신 씬(scene)을 활성화하기 위해 단축 구문을 사용할 수 있습니다.

```yaml
- scene: scene.morning_living_room
```

### 조건 테스트 (Test a Condition)

스크립트를 실행하는 동안 추가 실행을 중지하기위한 조건을 추가할 수 있습니다. 조건이 'true'를 반환하지 않으면 스크립트 실행이 중지됩니다. [conditions page]에는 여러 가지 조건이 문서화되어 있습니다.

```yaml
# If paulus is home, continue to execute the script below these lines
- condition: state
  entity_id: device_tracker.paulus
  state: 'home'
```

### 지연 (Delay)

지연은 스크립트를 일시적으로 일시 중단하고 나중에 시작하는 데 유용합니다. 아래와 같이 지연에 대해 다른 구문을 지원합니다.

```yaml
# Waits 1 hour
- delay: '01:00'
```

```yaml
# Waits 1 minute, 30 seconds
- delay: '00:01:30'
```

```yaml
# Waits 1 minute
- delay:
    # Supports milliseconds, seconds, minutes, hours, days
    minutes: 1
```

{% raw %}
```yaml
# Waits however many seconds input_number.second_delay is set to
- delay:
    # Supports milliseconds, seconds, minutes, hours, days
    seconds: "{{ states('input_number.second_delay') }}"
```
{% endraw %}

{% raw %}
```yaml
# Waits however many minutes input_number.minute_delay is set to
# Valid formats include HH:MM and HH:MM:SS
- delay: "{{ states('input_number.minute_delay') | multiply(60) | timestamp_custom('%H:%M:%S',False) }}"
```
{% endraw %}

### 대기 (Wait)

몇 가지 사항이 완료될 때까지 기다리십시오. 현재 `wait_template`이 조건이 `true`가 될 때까지 기다리는 것을 지원합니다. [Template-Trigger](/docs/automation/trigger/#template-trigger)도 참조하십시오. 조건이 충족되지 않으면 스크립트가 계속 실행되는 시간 초과를 설정할 수 있습니다. 타임 아웃은 `delay`와 같은 문법입니다.

{% raw %}
```yaml
# Wait until media player have stop the playing
- wait_template: "{{ is_state('media_player.floor', 'stop') }}"
```
{% endraw %}

{% raw %}
```yaml
# Wait for sensor to trigger or 1 minute before continuing to execute.
- wait_template: "{{ is_state('binary_sensor.entrance', 'on') }}"
  timeout: '00:01:00'
```
{% endraw %}

자동화 내에서 `wait_template`을 사용할 때 `trigger.entity_id`는 `state`, `numeric_state` 그리고 `template` 트리거에 대해 지원됩니다.

{% raw %}
```yaml
- wait_template: "{{ is_state(trigger.entity_id, 'on') }}"
```
{% endraw %}

더미 변수(dummy variables)를 사용하는 것도 가능합니다. 예를 들어, 스크립트에서 `wait_template`을 사용할 때.

{% raw %}
```yaml
# Service call, e.g., from an automation.
- service: script.do_something
  data_template:
    dummy: input_boolean.switch

# Inside the script
- wait_template: "{{ is_state(dummy, 'off') }}"
```
{% endraw %}

옵션으로 `continue_on_timeout`을 사용하여 타임 아웃 후에 스크립트가 중단되도록 할 수 도 있습니다.

{% raw %}
```yaml
# Wait until a valve is < 10 or abort after 1 minute.
- wait_template: "{{ state_attr('climate.kitchen', 'valve')|int < 10 }}"
  timeout: '00:01:00'
  continue_on_timeout: 'false'
```
{% endraw %}

`continue_on_timeout`이 없으면 스크립트는 항상 계속됩니다.

### 이벤트 발생 (Fire an Event)

이 액션은 이벤트를 발생시킬 수 있습니다. 많은 것들에 이벤트가 사용될 수 있습니다. 자동화를 트리거하거나 다른 연동에 문제가 있음을 나타낼 수 있습니다. 예를 들어 아래 예에서는 로그북에 항목을 만드는데 사용됩니다.

```yaml
- event: LOGBOOK_ENTRY
  event_data:
    name: Paulus
    message: is waking up
    entity_id: device_tracker.paulus
    domain: light
```

event_data_template을 사용하여 사용자 정의 데이터로 이벤트를 발생시킬 수도 있습니다. 이벤트 트리거를 기다리는 다른 스크립트로 데이터를 전달하는데 사용할 수 있습니다. 

{% raw %}
```yaml
- event: MY_EVENT
  event_data_template:
    name: myEvent
    customData: "{{ myCustomVariable }}"
```
{% endraw %}

### 사용자정의 이벤트 발생과 소비 (Raise and Consume Custom Events)

다음 자동화는 `entity_id`를 이벤트 데이터로 사용하여 `event_light_state_changed`라는 사용자 정의 이벤트를 발생시키는 방법을 보여줍니다. 액션 부분은 스크립트 또는 자동화 내부에 있을 수 있습니다.

{% raw %}
```yaml
- alias: Fire Event
  trigger:
    - platform: state
      entity_id: switch.kitchen
      to: 'on'
  action:
    - event: event_light_state_changed
      event_data:
        state: 'on'
```
{% endraw %}

다음 자동화는 사용자 정의 이벤트 `event_light_state_changed`를 캡처하고 이벤트 데이터로 전달된 해당 `entity_id`를 검색하는 방법을 보여줍니다.

{% raw %}
```yaml
- alias: Capture Event
  trigger:
    - platform: event
      event_type: event_light_state_changed
  action:
    - service: notify.notify
      data_template:
        message: "kitchen light is turned {{ trigger.event.data.state }}"
```
{% endraw %}

[Script component]: /integrations/script/
[automations]: /getting-started/automation-action/
[Alexa/Amazon Echo]: /integrations/alexa/
[service calls page]: /getting-started/scripts-service-calls/
[conditions page]: /getting-started/scripts-conditions/
