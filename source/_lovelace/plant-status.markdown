---
title: "Plant Status 카드"
sidebar_label: Plant Status
description: "The Plant card gives you an easy way of viewing the status of your plants"
---

아름다운 식물원을 위한 카드입니다. 나무를 키우거나 화분을 관리할 수 있는 카드입니다. 

<p class='img'>
<img src='/images/lovelace/lovelace_plant_card.png' alt='Screenshot of the plant status card'>
plant status 카드의 스크린 샷.
</p>

{% configuration %}
type:
  required: true
  description: plant-status
  type: string
entity:
  required: true
  description: "`plant` 도메인의 엔티티 ID"
  type: string
name:
  required: false
  description: 이름을 덮어 씁니다
  type: string
  default: 엔터티 이름
theme:
  required: false
  description: "내 테마로 설정 `themes.yaml`"
  type: string
{% endconfiguration %}

## 예시

```yaml
type: plant-status
entity: plant.bonsai
```
