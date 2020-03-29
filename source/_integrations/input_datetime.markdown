---
title: 시간입력(Input Datetime)
description: Instructions on how to integrate the Input Datetime integration into Home Assistant.
logo: home-assistant.png
ha_category:
  - Automation
ha_release: 0.55
ha_quality_scale: internal
ha_codeowners:
  - '@home-assistant/core'
---

`input_datetime` 통합구성요소를 통해 사용자는 날짜 및 시간 값을 정의할 수 있습니다
프론트 엔드를 통해 제어할 수 있으며 자동화 및 템플릿 내에서 사용할 수 있습니다.

3 개의 날짜/시간 입력을 추가하려면 하나는 날짜, 시간이 있고 다른 하나는 날짜 혹은 시간을 각각 입력 받으려면 `configuration.yaml`에 다음 줄을 추가하십시오.

```yaml
# Example configuration.yaml entry
input_datetime:
  both_date_and_time:
    name: Input with both date and time
    has_date: true
    has_time: true
  only_date:
    name: Input with only date
    has_date: true
    has_time: false
  only_time:
    name: Input with only time
    has_date: false
    has_time: true
```

{% configuration %}
  input_datetime:
    description: datetime 입력의 별칭. 여러 항목이 허용됩니다.
    required: true
    type: map
    keys:
      name:
        description: datetime 입력의 이름.
        required: false
        type: string
      has_time:
        description: 입력에 시간이 필요한 경우 'true'로 설정하십시오. 하나 이상의 `has_time` 또는 `has_date`가 정의되어 있어야합니다.
        required: false
        type: boolean
        default: false
      has_date:
        description: 입력에 날짜가 필요한 경우 'true'로 설정하십시오. 하나 이상의 `has_time` 또는 `has_date`가 정의되어 있어야합니다.
        required: false
        type: boolean
        default: false
      icon:
        description: 프론트 엔드에서 입력 요소 앞에 표시되는 아이콘.
        required: false
        type: icon
      initial:
        description: 입력의 초기값을 `has_time` 및 `has_date`에 맞춰 설정하십시오.
        required: false
        type: [datetime, time, date]
        default: 1970-01-01 00:00 | 00:00 | 1970-01-01
{% endconfiguration %}

### 속성 (Attributes) 

datetime 입력 enttity의 상태는 자동화 및 템플릿에 유용한 여러 속성을 내보냅니다.

| Attribute | Description |
| ----- | ----- |
| `has_time` | `true` 해당 entity에 시간이 있을 경우.
| `has_date` | `true` 해당 entity에 날짜가 있을 경우.
| `year`<br>`month`<br>`day` | 날짜의 연, 월, 일.<br>(`has_date: true` 로 설정시 활용 가능)
| `timestamp` | 입력에 소요된 시간을 나타내는 타임 스탬프입니다.<br>(`has_date: true`로 설정시 활용 가능)

### 상태 복원 (Restore State)

`initial`에 유효한 값을 설정하면 이 연동은 상태가 해당 값으로 설정된 상태에서 시작됩니다. 그렇지 않으면, 홈어시스턴트 중지 이전의 상태를 복원합니다. 

### 서비스 (Services)

사용가능한 서비스: `input_datetime.set_datetime`, `input_datetime.reload`.

Service data attribute | Format String | Description
-|-|-
`date` | `%Y-%m-%d` | 날짜를 동적으로 설정하는데 사용할 수 있습니다.
`time` | `%H:%M:%S` | 시간을 동적으로 설정하는데 사용할 수 있습니다.
`datetime` | `%Y-%m-%d %H:%M:%S` | 날짜와 시간을 모두 동적으로 설정하는데 사용할 수 있습니다.

같은 호출(call)에서 날짜와 시간을 모두 설정하려면 `date`와 `time`을 함께 사용하거나 `datetime`을 단독으로 사용하십시오.

`input_dateteime.reload` 서비스를 통해 홈어시스턴트 자체를 다시 시작하지 않고도 `input_datetime`의 설정을 다시로드 할 수 있습니다.

## 자동화 예시 (Automation Examples)

다음은 `input_datetime`을 자동화에서 트리거로 사용하는 예입니다. ([time sensor](/integrations/time_date)가 설정에서 꼭 필요하게 될 것입니다.)

{% raw %}
```yaml
# Example configuration.yaml entry
# Turns on bedroom light at the time specified.
automation:
  trigger:
    platform: template
    value_template: "{{ states('sensor.time') == (state_attr('input_datetime.bedroom_alarm_clock_time', 'timestamp') | int | timestamp_custom('%H:%M', True)) }}"
  action:
    service: light.turn_on
    entity_id: light.bedroom
```
{% endraw %}

`input_datetime`을 동적으로 설정하기 위해 `input_datetime.set_datetime`를 호출할 수 있습니다. 호출이 성공하려면 `date`,`time`의 값이 특정 형식이어야합니다. (위의 서비스 설명을 참조하십시오.)
만일 `datetime` 객체가 있다면 `strftime` 메소드를 사용할 수 있습니다. 혹은 타임 스탬프가 있다면 `timestamp_custom` 필터를 사용할 수 있습니다. 자동화 규칙에서 다음 예제를 사용할 수 있습니다.

{% raw %}
```yaml
# Example configuration.yaml entry
# Sets input_datetime to '05:30' when an input_boolean is turned on.
automation:
  trigger:
    platform: state
    entity_id: input_boolean.example
    to: 'on'
  action:
  - service: input_datetime.set_datetime
    entity_id: input_datetime.bedroom_alarm_clock_time
    data:
      time: '05:30:00'
  - service: input_datetime.set_datetime
    entity_id: input_datetime.another_time
    data_template:
      time: "{{ now().strftime('%H:%M:%S') }}"
  - service: input_datetime.set_datetime
    entity_id: input_datetime.another_date
    data_template:
      date: "{{ as_timestamp(now())|timestamp_custom('%Y-%m-%d') }}"
  - service: input_datetime.set_datetime
    entity_id: input_datetime.date_and_time
    data_template:
      datetime: "{{ now().strftime('%Y-%m-%d %H:%M:%S') }}"
  - service: input_datetime.set_datetime
    data_template:
      entity_id: input_datetime.date_and_time
      date: >
        {{ now().timestamp() | timestamp_custom("%Y-%m-%d", true) }}
      time: >
        {{ now().timestamp() | timestamp_custom("%H:%M:%S", true) }}
```
{% endraw %}
