---
title: 워크데이(Workday)
description: Steps to configure the binary workday sensor.
logo: home-assistant.png
ha_category:
  - Utility
ha_iot_class: Local Polling
ha_release: 0.41
ha_quality_scale: internal
ha_codeowners:
  - '@fabaff'
---

`workday` 이진 센서는 현재 일이 근무일인지 여부를 나타냅니다. 요일로 계산할 요일을 지정할 수 있으며 Python 모듈 [holidays](https://pypi.python.org/pypi/holidays)을 사용하여 지역별 공휴일에 대한 정보를 연동할 수 있습니다.

## 셋업

사용 가능한 지역에 대해서는 [country list](https://github.com/dr-prodigy/python-holidays#available-countries)을 확인하십시오.

## 설정

설치시 `workday` 센서를 활성화하려면 `configuration.yaml` 파일에 다음을 추가하십시오.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: workday
    country: DE
```

{% configuration %}
name:
  description: A name for this sensor.
  required: false
  type: string
  default: Workday Sensor
country:
  description: >
    Country code according to [holidays](https://pypi.org/project/holidays/) notation.
  required: true
  type: string
province:
  description: Province code according to [holidays](https://pypi.org/project/holidays/) notation.
  required: false
  type: string
workdays:
  description: List of workdays.
  required: false
  type: list
  default: "[mon, tue, wed, thu, fri]"
excludes:
  description: List of workday excludes.
  required: false
  type: list
  default: "[sat, sun, holiday]"
days_offset:
  description: Set days offset (e.g., -1 for yesterday, 1 for tomorrow).
  required: false
  type: integer
  default: 0
add_holidays:
  description: "Add custom holidays (such as company, personal holidays or vacations). Needs to formatted as `YYYY-MM-DD`."
  required: false
  type: list
{% endconfiguration %}

일은 다음과 같이 지정됩니다: `mon`,`tue`,`wed`,`thu`,`fri`,`sat`,`sun`.
키워드 `holiday`은 공휴일 모듈에 의해 식별된 공휴일에 사용됩니다.

<div class='note warning'>

노르웨이 (`NO`)에 센서를 사용하는 경우 `NO`를 따옴표로 묶거나 이름을 완전히 써야합니다.
그렇지 않으면 값은 `false`로 평가됩니다.
온타리오 (`ON`)가 있는 캐나다 (`CA`) 센서를 `province:`로 사용하는 경우 `ON`을 따옴표로 묶어야합니다.
그렇지 않으면 값이 `true`로 평가되고 (자세한 내용은 YAML 설명서를 확인하십시오) 센서가 작동하지 않습니다.

</div>

## 전체 예제

이 예는 토요일, 일요일 및 공휴일을 제외합니다. 두 개의 사용자 정의 휴일이 추가됩니다.

```yaml
# Example configuration.yaml entry
binary_sensor:
  - platform: workday
    country: DE
    workdays: [mon, wed, fri]
    excludes: [sat, sun, holiday]
    add_holidays: 
      - '2018-12-26'
      - '2018-12-31'
```

## 자동화 예제

자동화 사용법 예 :

```yaml
automation:
  alias: Turn on heater on workdays
  trigger:
    platform: time
    at: '08:00:00'
  condition:
    condition: state
    entity_id: 'binary_sensor.workday_sensor'
    state: 'on'
  action:
    service: switch.turn_on
    entity_id: switch.heater
```

<div class='note'>

[as explained here](/docs/configuration/devices/) 하나의 `automation:`항목만 가질 수 있습니다. 기존 자동화에 자동화를 추가하십시오.

</div>
