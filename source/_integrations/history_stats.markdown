---
title: 히스토리 통계(History Stats) 
description: Instructions about how to integrate historical statistics into Home Assistant.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.39
ha_quality_scale: internal
---

`history_stats` 센서 플랫폼은 [history](/integrations/history/)의 데이터를 사용하여 다른 통합구성요소에 대한 빠른 통계를 제공합니다.

사용자 지정 기간 동안 통합구성요소가 특정 상태에 있었던 시간을 추적할 수 있습니다.

추적할 수 있는 예:

- 이번 주에 집에 있었던 시간
- 어제 조명이 켜진 시간
- 어제 조명이 켜진 시간

## 설정

히스토리 통계 센서를 사용하려면 `configuration.yaml`에 다음 행을 추가하십시오

{% raw %}
```yaml
# Example configuration.yaml entry
sensor:
  - platform: history_stats
    name: Lamp ON today
    entity_id: light.my_lamp
    state: 'on'
    type: time
    start: '{{ now().replace(hour=0).replace(minute=0).replace(second=0) }}'
    end: '{{ now() }}'
```
{% endraw %}

{% configuration %}
entity_id:
  description: 추적하려는 엔티티
  required: true
  type: string
state:
  description: 추적하려는 상태
  required: true
  type: string
name:
  description: 프런트 엔드에 표시되는 이름
  required: false
  default: unnamed statistics
  type: string
type:
  description: "센서의 종류: `time`, `ratio`, 혹은 `count`."
  required: false
  default: time
  type: string
start:
  description: 측정을 시작할 시기 (타임 스탬프 또는 날짜/시간)
  required: false
  type: template
end:
  description: 측정을 중지할 시기 (타임 스탬프 또는 날짜/시간)
  required: false
  type: template
duration:
  description: 측정 기간.
  required: false
  type: time
{% endconfiguration %}

<div class='note'>

  `start`,`end` 및 `duration`에서 **정확하게 두가지**를 제공해야 합니다.
<br/>
  `now ()` 또는 `as_timestamp ()`와 같은 [template extensions](/topics/templating/#home-assistant-template-extensions)를 사용하여 아래 예와 같이 동적 날짜를 처리할 수 ​​있습니다.

</div>

## 센서 타입

선택한 센서 유형에 따라 `history_stats` 통합구성요소에 다른 값이 표시될 수 있습니다. :

- **time**: 추적 시간인 기본값 (시간)
- **ratio**: 추적 시간을 기간의 길이로 나눈값 (백분율)
- **count**: 추적한 통합구성요소가 추적한 상태로 몇 번이나 변경되었는지

## Period (기간)

`history_stats` 통합구성요소는 정확한 시간 내에 측정을 실행합니다. 항상 다음 중 2가지를 제공해야합니다.
- 기간이 시작될 때 (`start` 변수)
- 기간이 끝나는 시점  (`end` 변수)
- 기간은 길이 (`duration` 변수)

`start` 및 `end` 변수는 날짜 시간 또는 타임 스탬프일 수 있으므로 원하는 기간을 대부분 설정할 수 있습니다.

### Duration (지속 기간)

Duration 변수는 고정된 기간에 사용됩니다. 아래에 표시된 것처럼 기간 동안 다른 문법 구문이 지원됩니다.

```yaml
# 6 hours
duration: 06:00
```

```yaml
# 1 minute, 30 seconds
duration: 00:01:30
```

```yaml
# 2 hours and 30 minutes
duration:
  # supports seconds, minutes, hours, days
  hours: 2
  minutes: 30
```

<div class='note'>

  duration이 `recorder` 구성 요소에 의해 저장된 기록일 수(`purge_keep_days`)를 초과하는 경우, History Stat 센서는 전체 duration을 보는데 필요한 모든 정보를 갖지 않습니다. 예를 들어, `purge_keep_days`가 7로 설정되면 duration이 30 일인 History Stat 센서는 최근 7 일의 History를 기반으로 한 값만 보고합니다.

</div>

### 예시

다음은 작업할 수 있는 period의 예와 `configuration.yaml`에 쓸 내용입니다.

**오늘**: 현재 날짜의 00:00에 시작하여 지금 끝납니다.

{% raw %}
```yaml
    start: '{{ now().replace(hour=0).replace(minute=0).replace(second=0) }}'
    end: '{{ now() }}'
```
{% endraw %}

**어제**: 오늘 00:00에 종료되며 24 시간 지속됩니다.

{% raw %}
```yaml
    end: '{{ now().replace(hour=0).replace(minute=0).replace(second=0) }}'
    duration:
      hours: 24
```
{% endraw %}

**오늘 아침 (오전 6시-오전 11시)**: 오늘 6 시에 시작하여 5 시간 지속됩니다.

{% raw %}
```yaml
    start: '{{ now().replace(hour=6).replace(minute=0).replace(second=0) }}'
    duration:
      hours: 5
```
{% endraw %}

**이번주**: 지난 월요일 00:00에 시작하여 지금 끝납니다.

여기서 지난 월요일은 *오늘* 현재 요일의 86400 배를 뺀 타임 스탬프입니다. (86400은 하루의 초 수, 월요일은 0, 일요일은 6).

{% raw %}
```yaml
    start: '{{ as_timestamp( now().replace(hour=0).replace(minute=0).replace(second=0) ) - now().weekday() * 86400 }}'
    end: '{{ now() }}'
```
{% endraw %}

**지난 30 일**: 오늘 00:00에 종료되며 30 일 지속됩니다.

{% raw %}
```yaml
    end: '{{ now().replace(hour=0).replace(minute=0).replace(second=0) }}'
    duration:
      days: 30
```
{% endraw %}

**모든 기록**은 타임 스탬프 = 0에서 시작하여 지금 끝납니다.

{% raw %}
```yaml
    start: '{{ 0 }}'
    end: '{{ now() }}'
```
{% endraw %}

<div class='note'>

  홈어시스턴트 UI의 `/developer-tools/template` 페이지에서 `start`, `end` 또는 `duration` 값이 올바른지 확인할 수 있습니다. period가 올바른지 확인하려면 구성 요소를 클릭하기만 하면 `from` 및 `to` 속성에 기간의 시작과 끝이 멋지게 형식화되어 보입니다.

</div>
