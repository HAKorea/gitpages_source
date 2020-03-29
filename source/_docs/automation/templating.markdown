---
title: "Automation Templating"
description: "Advanced automation documentation using templating."
redirect_from: /getting-started/automation-templating/
---

홈어시스턴트 0.19에는 변수의 스크립트 처리 그리고 자동화라는 새로운 강력한 기능이 도입되었습니다. 이를 통해 트리거 정보를 기반으로 조건과 액션을 조정할 수 있습니다.

트리거 데이터는 [template](/docs/configuration/templating/) 렌더링 중에 `trigger`변수로 사용할 수 있습니다.


{% raw %}
```yaml
# Example configuration.yaml entries
automation:
  trigger:
    platform: state
    entity_id: device_tracker.paulus
  action:
    service: notify.notify
    data_template:
      message: >
        Paulus just changed from {{ trigger.from_state.state }}
        to {{ trigger.to_state.state }}

automation 2:
  trigger:
    platform: mqtt
    topic: /notify/+
  action:
    service_template: >
      notify.{{ trigger.topic.split('/')[-1] }}
    data_template:
      message: '{{ trigger.payload }}'
      
automation 3:
  trigger:
    # Multiple Entities for which you want to perform the same action.
    - platform: state
      entity_id:
        - light.bedroom_closet
      to: 'on'
      # Trigger when someone leaves the closet light on for 10 minutes.
      for: '00:10:00'
    - platform: state
      entity_id:
        - light.kiddos_closet
      to: 'on'
      for: '00:10:00'
    - platform: state
      entity_id:
        - light.linen_closet
      to: 'on'
      for: '00:10:00'
  action:
    - service: light.turn_off
      data_template:
        # Whichever entity triggers the automation we want to turn off THAT entity, not the others.
        entity_id: "{{ trigger.entity_id }}"
```
{% endraw %}

## 중요한 템플릿 규칙

자동화 템플릿을 작성할 때 기억해야할 몇가지 중요한 규칙이 있습니다. :

1. 서비스 호출의 `data` 섹션에서 템플릿을 사용할 때는 `data`대신 `data_template`을 사용해야합니다.
2. 서비스 호출의 `service` 섹션에서 템플릿을 사용할 때는 `service`대신 `service_template`을 사용해야합니다.
3. 작은 따옴표 (`"`) 또는 작은 따옴표 (`'`)로 한 줄로 **묶어야합니다**. 
4. `if ... is not none` 또는 [`default` filter](http://jinja.pocoo.org/docs/dev/templates/#default) 또는 둘 다를 사용하여 정의되지 않은 변수를 준비하는 것이 좋습니다.
5. 숫자를 비교할 때 각각의 [filter](http://jinja.pocoo.org/docs/dev/templates/#list-of-builtin-filters)를 사용하여 숫자를 [`float`](http://jinja.pocoo.org/docs/dev/templates/#float) 또는 [`int`](http://jinja.pocoo.org/docs/dev/templates/#int)로 변환하는 것이 좋습니다. 
6. [`float`](http://jinja.pocoo.org/docs/dev/templates/#float)과 [`int`](http://jinja.pocoo.org/docs/dev/templates/#int) 필터는 변환에 실패하면 기본 폴백(fallback)값을 허용하지만, 정의되지 않은 변수를 잡아내는 기능은 제공하지 않습니다. 

이 간단한 규칙을 기억하면 자동화 템플릿을 사용할 때 많은 고민과 시간을 절약 할 수 있습니다.

`data`와 `data_template`을 동시에 사용할 수 있지만 `data_template`은 양쪽에서 제공되는 속성값을 덮어 쓰기합니다. 

## 트리거 상태 객체 (Trigger State Object)

트리거 entity의 [state object](/docs/configuration/state_object/)에 액세스하는 방법을 아는 것이 가장 일반적인 질문 중 하나 일 수 있습니다. [`state`](#state), [`numeric_state`](#numeric_state), [`template`](#template) 트리거를 위한 ​​몇 가지 방법이 있습니다.

* `trigger.from_state` 는 entity의 **previous** [state object](/docs/configuration/state_object/)를 반환합니다. 
* `trigger.to_state` 는 **new** [state object](/docs/configuration/state_object/)를 반환합니다. 
* `states[trigger.to_state.domain][trigger.to_state.object_id]`는 **current** entity의 [state object](/docs/configuration/state_object/)를 반환합니다. 

## 사용가능한 트리거 데이터

다음 표는 플랫폼별로 사용가능한 트리거 데이터를 보여줍니다.


### event

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `event`.
| `trigger.event` | Event object that matched.
| `trigger.event.data` | Optional data

### mqtt

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `mqtt`.
| `trigger.topic` | Topic that received payload.
| `trigger.payload` | Payload.
| `trigger.payload_json` | Dictonary of the JSON parsed payload.
| `trigger.qos` | QOS of payload.

### numeric_state

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `numeric_state`
| `trigger.entity_id` | Entity ID that we observe.
| `trigger.below` | The below threshold, if any.
| `trigger.above` | The above threshold, if any.
| `trigger.from_state` | The previous [state object] of the entity.
| `trigger.to_state` | The new [state object] that triggered trigger.
| `trigger.for` | Timedelta object how long state has met above/below criteria, if any.

### state

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `state`
| `trigger.entity_id` | Entity ID that we observe.
| `trigger.from_state` | The previous [state object] of the entity.
| `trigger.to_state` | The new [state object] that triggered trigger.
| `trigger.for` | Timedelta object how long state has been to state, if any.

### sun

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `sun`
| `trigger.event` | The event that just happened: `sunset` or `sunrise`.
| `trigger.offset` | Timedelta object with offset to the event, if any.

### template

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `template`
| `trigger.entity_id` | Entity ID that caused change.
| `trigger.from_state` | Previous [state object] of entity that caused change.
| `trigger.to_state` | New [state object] of entity that caused template to change.
| `trigger.for` | Timedelta object how long state has been to state, if any.

### time

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `time`
| `trigger.now` | DateTime object that triggered the time trigger.

### time pattern

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `time_pattern`
| `trigger.now` | DateTime object that triggered the time_pattern trigger.

### webhook

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `webhook`
| `trigger.webhook_id` | The webhook ID that was triggered.
| `trigger.json` | The JSON data of the request (if it had a JSON content type).
| `trigger.data` | The form data of the request (if it had a form data content type).

### zone

| Template variable | Data |
| ---- | ---- |
| `trigger.platform` | Hardcoded: `zone`
| `trigger.entity_id` | Entity ID that we are observing.
| `trigger.from_state` | Previous [state object] of the entity.
| `trigger.to_state` | New [state object] of the entity.
| `trigger.zone` | State object of zone
| `trigger.event` | Event that trigger observed: `enter` or `leave`.

[state object]: /docs/configuration/state_object/
