---
title: "Sensor Card"
sidebar_label: Sensor
description: "The sensor card gives you information about the sensor state"
---

The sensor card gives you a quick overview of your sensors state with an optional graph to visualize change over time.
센서 카드는 시간 경과에 따른 변화를 시각화 할 수있는 옵션 그래프를 통해 센서 상태에 대한 빠른 개요를 제공합니다.

<p class='img'>
  <img src='/images/lovelace/lovelace_sensor.png' alt='Screenshot of the sensor card'>
  Screenshot of the sensor card.
</p>

{% configuration %}
type:
  required: true
  description: sensor
  type: string
entity:
  required: true
  description: "`sensor` 도메인의 엔티티 ID"
  type: string
icon:
  required: false
  description: 카드 아이콘
  type: string
name:
  required: false
  description: 카드 이름
  type: string
graph:
  required: false
  description: 그래프 유형 `none` 혹은 `line`
  type: string
unit:
  required: false
  description: 측정 단위
  type: string
detail:
  required: false
  description: 그래프의 디테일 `1` 혹은 `2`, `1`은 시간당 1점, `2` 는 시간당 6점
  type: integer
  default: 1
hours_to_show:
  required: false
  description: 그래프로 표시 할 시간
  type: integer
  default: 24
theme:
  required: false
  description: 내 테마로 설정 `themes.yaml`
  type: string
{% endconfiguration %}

## 사례 

```yaml
type: sensor
entity: sensor.illumination
name: Illumination
```
