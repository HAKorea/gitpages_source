---
title: 생체리듬조명(Flux)
description: Instructions on how to have switches call command line commands.
ha_category:
  - Automation
ha_release: 0.21
logo: home-assistant.png
ha_quality_scale: internal
---

`flux` 스위치 플랫폼은 일주기 리듬(circadian rhythm)을 사용하여 컴퓨터에서 플럭스가 작동하는 방식과 유사한 조명 온도를 변경합니다. 낮에는 밝아지고 밤에는 점차적으로 빨강/주황색으로 희미 해집니다. `flux` 스위치는 시작 후 마지막 상태를 복원합니다.

이 통합구성요소는은 시간에 따라 조명을 업데이트합니다. 플럭스 구성에 켜져 있고 나열된 조명에만 영향을 미칩니다.

낮에는 (`start time`과 `sunset time` 사이), `start_colortemp`에서`sunset_colortemp`까지 조명이 희미 해집니다. 일몰 후 (`sunset_time`과`stop_time` 사이에), 조명은 `sunset_colortemp`에서 `stop_colortemp`로 희미(fade)해집니다. `stop_time`이후에도 표시등이 여전히 켜져 있으면 표시등이 꺼질 때까지 표시등이 `stop_colortemp`로 계속 변경됩니다. 페이드 효과는 조명을 주기적으로 업데이트하여 생성됩니다.

색 온도는 켈빈으로 지정되며 허용되는 값은 1000 ~ 40000 켈빈입니다. 값이 낮을수록 더 빨갛게 보이고 값이 높을수록 더 희게 보입니다. 

가변 간격으로 업데이트하려면 스위치를 끄고 조명을 업데이트 할 때마다 서비스  `switch.<name>_update`를 호출하는 자동화 규칙을 사용할 수 있습니다. 여기서 `<name>`은 스위치 설정의 `<name>` 속성과 같습니다. 

설치후 Flux 스위치를 사용하려면 `configuration.yaml` 파일에 다음을 추가하십시오 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: flux
    lights:
      - light.desk
      - light.lamp
```

{% configuration %}
lights:
  description: 조명 엔티티의 배열 목록.
  required: true
  type: list
name:
  description: 스위치를 표시 할 때 사용할 이름.
  required: false
  default: Flux
  type: string
start_time:
  description: 시작 시간.
  required: false
  type: time
stop_time:
  description: 중지 시간.
  required: false
  type: time
start_colortemp:
  description: 시작시 색 온도.
  required: false
  default: 4000
  type: integer
sunset_colortemp:
  description: 일몰시 색온도를 설정.
  required: false
  default: 3000
  type: integer
stop_colortemp:
  description: 마지막 색 온도.
  required: false
  default: 1900
  type: integer
brightness:
  description: 조명의 밝기.
  required: false
  type: integer
disable_brightness_adjust:
  description: true이면 색온도 외에 밝기가 조정되지 않습니다..
  required: false
  type: boolean
  default: false
mode:
  description: 색 온도가 조명으로 전달되는 방법을 선택. 유효한 값은 `xy`, `mired`,`rgb`.
  required: false
  default: xy
  type: string
transition:
  description: 조명 변경에 대한 전환 시간(초) (높은 값은 일부 조명 모델에서 지원되지 않을 수 있음).
  required: false
  default: 30
  type: integer
interval:
  description: 조명을 업데이트해야하는 빈도(초).
  required: false
  default: 30
  type: integer
{% endconfiguration %}

완전한 사례 :

```yaml
# Example configuration.yaml entry
switch:
  - platform: flux
    lights:
      - light.desk
      - light.lamp
    name: Fluxer
    start_time: '7:00'
    stop_time: '23:00'
    start_colortemp: 4000
    sunset_colortemp: 3000
    stop_colortemp: 1900
    brightness: 200
    disable_brightness_adjust: true
    mode: xy
    transition: 30
    interval: 60
```
