---
title: 핏비트(Fitbit)
description: Instructions on how to integrate Fitbit devices within Home Assistant.
logo: fitbit.png
ha_category:
  - Health
ha_iot_class: Cloud Polling
ha_release: 0.19
ha_codeowners:
  - '@robbiet480'
---

Fitbit 센서를 사용하면 [Fitbit](https://fitbit.com/)에서 홈어시스턴트로 데이터를 노출 할 수 있습니다.

`configuration.yaml` 파일에 다음을 추가하여 센서를 활성화하십시오.

```yaml
# Example configuration.yaml entry
sensor:
  - platform: fitbit
    clock_format: 12H
    monitored_resources:
      - "body/weight"
```

이 작업이 완료되면 Home Assistant를 다시 시작하십시오. 프론트 엔드로 이동하십시오. Fitbit 설정을 위한 새로운 항목이 표시됩니다. 지시 사항에 따라 설정 프로세스를 완료하십시오.

Fitbit은 시간당 150 개의 매우 낮은 속도 제한을 가지고 있습니다. 시계는 시간의 _top_ 에서 재설정됩니다 (60 분이 걸리지 않음). 한계를 극복 할 방법이 없습니다. 속도 제한으로 인해 센서는 30 분마다 업데이트됩니다. Home Assistant를 다시 시작하여 업데이트를 수동으로 트리거 할 수 있습니다. `monitored_resources`의 모든 항목에 대해 1 개의 요청이 사용된다는 것을 기억하십시오. 

센서가 사용할 단위 시스템은 Fitbit 프로필에서 설정한 국가를 기반으로합니다.

{% configuration %}
monitored_resources:
  description: 모니터링 할 리소스.
  required: false
  default: "`activities/steps`"
  type: list
clock_format:
  description: "`sleep/startTime` 리소스에 사용할 형식입니다. `12H` 또는`24H`를 허용합니다."
  required: false
  default: "`24H`"
  type: string
unit_system:
  description: 측정에 사용할 단위 시스템. `default`, `metric`, `en_US` 또는 `en_GB`를 허용합니다.
  required: false
  default: "`default`"
  type: string
{% endconfiguration %}

다음은 `monitored_resources`에 추가 할 수있는 리소스 목록입니다. 모든 리소스에 대해 하나의 센서가 노출됩니다.

```text
activities/activityCalories
activities/calories
activities/caloriesBMR
activities/distance
activities/elevation
activities/floors
activities/heart
activities/minutesFairlyActive
activities/minutesLightlyActive
activities/minutesSedentary
activities/minutesVeryActive
activities/steps
activities/tracker/activityCalories
activities/tracker/calories
activities/tracker/distance
activities/tracker/elevation
activities/tracker/floors
activities/tracker/minutesFairlyActive
activities/tracker/minutesLightlyActive
activities/tracker/minutesSedentary
activities/tracker/minutesVeryActive
activities/tracker/steps
body/bmi
body/fat
body/weight
devices/battery
sleep/awakeningsCount
sleep/efficiency
sleep/minutesAfterWakeup
sleep/minutesAsleep
sleep/minutesAwake
sleep/minutesToFallAsleep
sleep/startTime
sleep/timeInBed
```
