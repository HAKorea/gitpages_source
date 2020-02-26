---
title: "Horizontal Stack 카드"
sidebar_label: Horizontal Stack
description: "Horizontal stack card allows you to stack together multiple cards, so they always sit next to each other in the space of one column."
---

Horizontal Stack 카드를 사용하면 여러카드를 함께 쌓을 수 있으므로 항상 한 열의 공간에서 서로 옆에 배치되어 있습니다.

{% configuration %}
type:
  required: true
  description: horizontal-stack
  type: string
title:
  required: false
  description: Stack 타이틀.
  type: string
cards:
  required: true
  description: 카드 리스트.
  type: list
{% endconfiguration %}

## 예시

```yaml
type: horizontal-stack
title: Lights
cards:
  - type: picture-entity
    image: /local/bed_1.png
    entity: light.ceiling_lights
  - type: picture-entity
    image: /local/bed_2.png
    entity: light.bed_light
```

<p class='img'>
  <img src='/images/lovelace/lovelace_horizontal_stack.PNG' alt='Two picture cards in a horizontal stack card'>
  horizontal Stack 카드에 두 장의 그림 카드.
</p>
