---
title: "온도조절기(Thermostat) 카드"
sidebar_label: Thermostat
description: "The thermostat card allows you to control a climate entity."
---

온도조절기(Thermostat) 카드는 Climate 개체를 제어합니다.

<p class='img'>
  <img src='/images/lovelace/lovelace_thermostat_card.gif' alt='Screenshot of the thermostat card'>
  온도조절기 카드의 스크린샷.
</p>

{% configuration %}
type:
  required: true
  description: 온도조절기
  type: string
entity:
  required: true
  description: "`climate` 도메인의 엔티티 ID"
  type: string
name:
  required: false
  description: 친숙한 이름을 덮어씁니다.
  type: string
  default: Name of Entity.
theme:
  required: false
  description: 내 테마로 설정 `themes.yaml`
  type: string
{% endconfiguration %}

## 예시

```yaml
type: thermostat
entity: climate.nest
```
