---
title: "Vertical Stack 카드"
sidebar_label: Vertical Stack
description: "The Vertical Stack card allows you to stack multiple cards together"
---

Vertical Stack을 사용하면 여러 개의 카드를 그룹화하여 항상 같은 열에 배치할 수 있습니다.

{% configuration %}
type:
  required: true
  description: vertical-stack
  type: string
title:
  required: false
  description: 스택의 제목.
  type: string
cards:
  required: true
  description: 카드 목록.
  type: list
{% endconfiguration %}

### 사례

기본 예제:

```yaml
type: vertical-stack
title: Backyard
cards:
  - type: picture-entity
    entity: camera.demo_camera
    show_info: false
  - type: entities
    entities:
      - binary_sensor.movement_backyard
```

<p class="img">
  <img src="/images/lovelace/lovelace_vertical-stack.png" alt="Picture- and entities-card in a stack">
  스택의 그림과 엔티티 카드.
</p>

수직과 수평 스택 카드의 조합 :

```yaml
type: vertical-stack
cards:
  - type: picture-entity
    entity: group.all_lights
    image:  /local/house.png
  - type: horizontal-stack
    cards:
      - type: picture-entity
        entity: light.ceiling_lights
        image: /local/bed_1.png
      - type: picture-entity
        entity: light.bed_light
        image: /local/bed_2.png
```

<p class="img">
  <img src="/images/lovelace/lovelace_vertical-horizontal-stack.png" alt="Create a grid layout using vertical and horizontal stack">
  수직과 수평 스택을 사용하여 그리드 레이아웃을 만듭니다.
</p>
