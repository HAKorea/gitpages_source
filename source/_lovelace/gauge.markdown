---
title: "gauge 카드"
sidebar_label: Gauge
description: "The Gauge card allows you to display sensor information visually"
---

게이지(gauge) 카드는 센서 데이터를 시각적으로 볼 수 있는 기본 카드입니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_gauge_card.gif' alt='Screenshot of the gauge card'>
게이지 카드의 스크린 샷.
</p>

```yaml
type: gauge
entity: sensor.cpu_usage
```

{% configuration %}
type:
  required: true
  description: gauge
  type: string
entity:
  required: true
  description: "표시할 엔티티 ID"
  type: string
name:
  required: false
  description: 게이지 엔터티 이름
  type: string
  default: Entity Name
unit:
  required: false
  description: 데이터에 주어진 측정 단위
  type: string
  default: "Unit Of Measurement given by entity"
theme:
  required: false
  description: 내 테마로 설정 `themes.yaml`
  type: string
min:
  required: false
  description: 그래프의 최소값
  type: integer
  default: 0
max:
  required: false
  description: 그래프의 최대값
  type: integer
  default: 100
severity:
  required: false
  description: 숫자에 따른 색상을 설정
  type: map
  keys:
    green:
      required: true
      description: 녹색을 시작하는 값
      type: integer
    yellow:
      required: true
      description: 노란색을 시작할 값
      type: integer
    red:
      required: true
      description: 붉은색을 시작할 값
      type: integer
{% endconfiguration %}

## 예시

제목과 측정 단위 예:

```yaml
type: gauge
name: CPU Usuage
unit: '%'
entity: sensor.cpu_usage
```

<p class='img'>
<img src='/images/lovelace/lovelace_gauge_card.gif' alt='Screenshot of the gauge card with custom title and unit of measurement'>
사용자 정의 제목과 측정 단위가 있는 게이지 카드의 스크린 샷.
</p>

심각도 수준(map)을 정의 :

```yaml
type: gauge
name: With Severity
unit: '%'
entity: sensor.cpu_usage
severity:
  green: 0
  yellow: 45
  red: 85
```
