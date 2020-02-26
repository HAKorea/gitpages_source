---
title: "경보 패널 카드"
sidebar_label: Alarm Panel
description: "The Alarm Panel allows you to Arm and Disarm your Alarm Control Panel Integrations"
---

경보 패널을 사용하면 경보 제어판 통합구성요소를 설정 및 해제 할 수 있습니다.

<p class='img'>
<img src='/images/lovelace/lovelace_alarm_panel_card.gif' alt='Screenshot of the alarm panel card'>
경보 패널 카드의 스크린 샷.
</p>

```yaml
type: alarm-panel
entity: alarm_control_panel.alarm
```

{% configuration %}
type:
  required: true
  description: 경보 패널
  type: string
entity:
  required: true
  description: "`alarm_control_panel` 도메인의 엔티티 ID"
  type: string
name:
  required: false
  description: 친숙한 이름으로 덮어씁니다.
  type: string
  default: Current State of Alarm Entity
states:
  required: false
  description: 알람의 상태 제어
  type: list
  default: arm_home, arm_away
  keys:
    arm_home:
      description: Arm Home
    arm_away:
      description: Arm Away
    arm_night:
      description: Arm Night
    arm_custom_bypass:
      description: Arm Custom Bypass
theme:
  required: false
  description: "`themes.yaml`에서 어떤 테마도 활용 가능"
  type: string
{% endconfiguration %}

## 예시 

제목 예시 :

```yaml
- type: alarm-panel
  name: House Alarm
  entity: alarm_control_panel.alarm
```

<p class='img'>
<img src='/images/lovelace/lovelace_alarm_panel_title_card.gif' alt='Screenshot of the alarm panel card'>
경보 패널 카드의 스크린 샷.
</p>

상태 목록을 정의한 내용 :

```yaml
type: alarm-panel
name: House Alarm
entity: alarm_control_panel.alarm
states:
  - arm_home
  - arm_away
  - arm_night
  - armed_custom_bypass
```
